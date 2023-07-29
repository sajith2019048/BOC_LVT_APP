import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartpay/core/service/dependency_injection.dart';
import 'package:smartpay/error/messages.dart';
import 'package:smartpay/features/presentation/bloc/base_bloc.dart';
import 'package:smartpay/features/presentation/bloc/base_event.dart';
import 'package:smartpay/features/presentation/bloc/base_state.dart';
import 'package:smartpay/features/presentation/bloc/transaction_history/transaction_history_state.dart';
import 'package:smartpay/features/presentation/common/app_button_outline.dart';
import 'package:smartpay/features/presentation/common/app_text_field.dart';
import 'package:smartpay/features/presentation/views/base_view.dart';
import 'package:smartpay/utils/app_colors.dart';
import 'package:smartpay/utils/app_constants.dart';
import 'package:smartpay/utils/app_utils.dart';

import '../../../../utils/enums.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../data/datasources/shared_preference.dart';
import '../../../data/models/response/transaction_history_response.dart';
import '../../../domain/entities/transaction_refund_entity.dart';
import '../../bloc/transaction_history/transaction_history_bloc.dart';
import '../../common/app_button.dart';
import '../../common/appbar.dart';
import '../otp_view/otp_view.dart';

class TransactionRefundView extends BaseView {
  final TransactionHistoryItemData transactionHistoryItemData;

  TransactionRefundView({required this.transactionHistoryItemData});

  @override
  State<TransactionRefundView> createState() => _TransactionRefundViewState();
}

class _TransactionRefundViewState extends BaseViewState<TransactionRefundView> {
  final _bloc = injection<TransactionHistoryBloc>();
  final _amountField = TextEditingController();

  @override
  void initState() {
    _amountField.text =
        widget.transactionHistoryItemData.txnAmount!.toStringAsFixed(2);
    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: SmartpayAppBar(title: "Refund Transaction"),
      body: BlocProvider<TransactionHistoryBloc>(
        create: (context) => _bloc,
        child: BlocListener<TransactionHistoryBloc,
            BaseState<TransactionHistoryState>>(
          bloc: _bloc,
          listener: (context, state) {},
          child: Padding(
            padding: EdgeInsets.all(AppConstants.UI_PADDING),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'You can refund either full amout or partial amount.',
                  style: TextStyle(
                    color: AppColors.fontColorWhite,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                AppTextField(
                  hint: 'Amount in LKR',
                  shouldRedirectToNextField: false,
                  isCurrency: true,
                  inputType: TextInputType.number,
                  controller: _amountField,
                ),
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                        child: AppButtonOutline(
                            buttonText: 'Cancel',
                            onTapButton: () {
                              Navigator.pop(context);
                            })),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: AppButton(
                        buttonText: 'Proceed',
                        onTapButton: () {
                          _validate();
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _validate() {
    if (_amountField.text.isEmpty) {
      showAppDialog(title: ErrorHandler.TITLE_OOPS, message: 'Amount required');
    } else {
      final amount = double.parse(_amountField.text.replaceAll(',', ''));
      if (amount > widget.transactionHistoryItemData.txnAmount!) {
        showAppDialog(
            title: ErrorHandler.TITLE_OOPS,
            message:
                'Please enter an amount less than ${AppUtils.convertToCurrency(widget.transactionHistoryItemData.txnAmount!, shouldAddSymbol: false)}');
      } else {
        Navigator.pushNamed(
          context,
          Routes.kOtpView,
          arguments: OTPViewArgs(
            fromView: ToOtpView.FROMLOGINFORGETPINQUESTIONANSWER,
            isFormVerifySecurity: true,
            isOtpSent: true,
            payload: TransactionRefundPayloadEntity(
                amount: amount,
                invoiceNumber: widget.transactionHistoryItemData.invoiceNo!,
                rrnValue: widget.transactionHistoryItemData.rrn!),
            mobileNo: appSharedData.getData(MOBILE_NO_PREFERENCE),
          ),
        ).then((value){
          if(value!=null && value is bool && value){
            Navigator.pop(context, value);
          }
        });
      }
    }
  }

  @override
  Base<BaseEvent, BaseState> getBloc() {
    return _bloc;
  }
}

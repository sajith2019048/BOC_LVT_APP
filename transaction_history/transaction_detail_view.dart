import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smartpay/core/service/app_permission.dart';
import 'package:smartpay/core/service/dependency_injection.dart';
import 'package:smartpay/core/service/storage_service.dart';
import 'package:smartpay/error/messages.dart';
import 'package:smartpay/features/presentation/bloc/base_bloc.dart';
import 'package:smartpay/features/presentation/bloc/base_event.dart';
import 'package:smartpay/features/presentation/bloc/base_state.dart';
import 'package:smartpay/features/presentation/bloc/transaction_history/transaction_history_state.dart';
import 'package:smartpay/features/presentation/common/app_button.dart';
import 'package:smartpay/features/presentation/views/base_view.dart';
import 'package:smartpay/utils/app_constants.dart';
import 'package:smartpay/utils/app_utils.dart';
import 'package:smartpay/utils/navigation_routes.dart';
import 'package:smartpay/utils/txn_codes.dart';

import '../../../domain/entities/transaction_history_args.dart';
import '../../bloc/transaction_history/transaction_history_bloc.dart';
import '../../bloc/transaction_history/transaction_history_event.dart';
import '../../common/appbar.dart';
import 'widget/history_entry_ui.dart';

class TransactionDetailView extends BaseView {
  final TransactionHistoryArgs transactionHistoryArgs;

  TransactionDetailView({required this.transactionHistoryArgs});

  @override
  State<TransactionDetailView> createState() => _TransactionDetailViewState();
}

class _TransactionDetailViewState extends BaseViewState<TransactionDetailView> {
  final _bloc = injection<TransactionHistoryBloc>();
  List<TransactionHistoryEntry> dataEntries = [];

  @override
  void initState() {
    _prepareData();
    super.initState();
  }

  _prepareData() {
    dataEntries.clear();
    final transaction =
        widget.transactionHistoryArgs.transactionHistoryItemData;

    dataEntries.add(
      TransactionHistoryEntry(key: 'Invoice No', data: transaction.rrn ?? ''),
    );

    if (widget.transactionHistoryArgs.walletType ==
        AppConstants.historyTypeCustomer) {
      dataEntries.add(
        TransactionHistoryEntry(
            key: 'Source Account', data: transaction.maskedPaymentToken!),
      );
      dataEntries.add(
        TransactionHistoryEntry(
          key: 'Paid To',
          data: transaction.txnType == TransactionCodes.FUND_TRANSFER_REQUEST
              ? transaction.maskedToAccount!
              : transaction.merchantLegalName!,
        ),
      );
      dataEntries.add(
        TransactionHistoryEntry(
            key: 'Amount',
            data: AppUtils.convertToCurrency(transaction.txnAmount!,
                shouldAddSymbol: true)),
      );

      if (transaction.txnType != TransactionCodes.FUND_TRANSFER_REQUEST) {
        dataEntries.add(
          TransactionHistoryEntry(
              key: 'Merchant Address', data: transaction.merchantAddress!),
        );
      } else {
        if (transaction.benefiName != null) {
          dataEntries.add(
            TransactionHistoryEntry(
                key: 'Beneficiary Name', data: transaction.benefiName!),
          );
        }
      }
    } else {
      dataEntries.add(
        TransactionHistoryEntry(
            key: 'Customer Name', data: transaction.customerName!),
      );
      dataEntries.add(
        TransactionHistoryEntry(
          key: 'Amount',
          data: AppUtils.convertToCurrency(transaction.txnAmount!,
              shouldAddSymbol: true),
        ),
      );
      dataEntries.add(
        TransactionHistoryEntry(
            key: 'Commission',
            data: AppUtils.convertToCurrency(transaction.merchantCommission!,
                shouldAddSymbol: true)),
      );
    }

    dataEntries.add(
      TransactionHistoryEntry(
          key: 'Date',
          data: DateFormat('dd MMM yyyy').format(transaction.dateTime!)),
    );
    dataEntries.add(
      TransactionHistoryEntry(
          key: 'Time',
          data: DateFormat('hh:mm a').format(transaction.dateTime!)),
    );
    dataEntries.add(
      TransactionHistoryEntry(
          key: 'Status', data: transaction.description ?? ''),
    );
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: SmartpayAppBar(title: "Transaction Details"),
      body: BlocProvider<TransactionHistoryBloc>(
        create: (context) => _bloc,
        child: BlocListener<TransactionHistoryBloc,
            BaseState<TransactionHistoryState>>(
          bloc: _bloc,
          listener: (context, state) async {
            if (state is DownloadEReceiptSuccessState) {
              final data = base64.decode(state.eReceiptData);
              StorageService(directoryName: 'SmartPay').storeFile(
                  fileName:
                      'eReceipt_${widget.transactionHistoryArgs.transactionHistoryItemData.rrn}',
                  fileExtension: 'pdf',
                  fileData: data,
                  onComplete: (file) async {
                    if (state.shouldOpen) {
                      await OpenFilex.open(file.path);
                    } else {
                      Share.shareFiles(
                        [file.path],
                      );
                    }
                  },
                  onError: (error) {
                    showAppDialog(
                        title: ErrorHandler.TITLE_SMARTPAY, message: error);
                  });
            }
          },
          child: Padding(
            padding: EdgeInsets.all(AppConstants.UI_PADDING),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...dataEntries.map(
                          (e) => HistoryEntryUI(
                            entry: e,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                widget.transactionHistoryArgs.isPaymentSuccess
                    ? Row(
                        children: [
                          widget.transactionHistoryArgs.isVoidTransaction
                              ? Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 10.0),
                                    child: AppButton(
                                        buttonText: 'Refund',
                                        onTapButton: () {
                                          Navigator.pushNamed(
                                            context,
                                            Routes.kTransactionRefundView,
                                            arguments: widget
                                                .transactionHistoryArgs
                                                .transactionHistoryItemData,
                                          ).then((value) {
                                            if (value != null &&
                                                value is bool &&
                                                value) {
                                              Navigator.pop(context);
                                            }
                                          });
                                        }),
                                  ),
                                )
                              : const SizedBox.shrink(),
                          Expanded(
                            child: AppButton(
                                buttonText: 'Download',
                                onTapButton: () {
                                  _downloadEReceipt(true);
                                }),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: AppButton(
                                buttonText: 'Share',
                                onTapButton: () {
                                  _downloadEReceipt(false);
                                }),
                          ),
                        ],
                      )
                    : const SizedBox.shrink()
              ],
            ),
          ),
        ),
      ),
    );
  }

  _downloadEReceipt(bool shouldStore) {
    AppPermissionManager.requestExternalStoragePermission(context, () {
      AppPermissionManager.requestManageStoragePermission(context, () {
        _bloc.add(
          DownloadEReceiptEvent(
              rrn:
                  widget.transactionHistoryArgs.transactionHistoryItemData.rrn!,
              txnType: widget.transactionHistoryArgs.txnType,
              walletType: widget.transactionHistoryArgs.walletType,
              shouldOpen: shouldStore),
        );
      });
    });
  }

  @override
  Base<BaseEvent, BaseState> getBloc() {
    return _bloc;
  }
}

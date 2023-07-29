import 'package:flutter/material.dart';
import 'package:smartpay/features/presentation/bloc/base_bloc.dart';
import 'package:smartpay/features/presentation/bloc/base_event.dart';
import 'package:smartpay/features/presentation/bloc/base_state.dart';
import 'package:smartpay/features/presentation/common/app_button.dart';
import 'package:smartpay/features/presentation/views/base_view.dart';

import '../../../../core/service/dependency_injection.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/navigation_routes.dart';
import '../../bloc/otp/otp_bloc.dart';
import '../../common/app_button_outline.dart';
import '../../common/appbar.dart';

class PaymentRequestView extends BaseView {
  PaymentRequestView({Key? key}) : super(key: key);

  @override
  State<PaymentRequestView> createState() => _PaymentRequestViewState();
}

class _PaymentRequestViewState extends BaseViewState<PaymentRequestView> {
  final _bloc = injection<OtpBloc>();

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: SmartpayAppBar(
        title: "Payment Request",
        // onBackPressed: () {
        //   Navigator.pop(context);
        // },
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 29,right: 29,top: 32),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 85,
                    decoration: BoxDecoration(
                      //color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: AppColors.fontColorDark),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            backgroundImage: NetworkImage(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSfOFVvObAnDfY1H_mLDPXQGDgTqdY7yK1qhQ&usqp=CAU',
                            ),
                            radius: 30,
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Keells Super - Battramulla',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: AppColors.fontColorDark,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                'No21, Nimsara Road, Battaramulla,\n Koswatta',
                                style: TextStyle(
                                  color: AppColors.fontColorDark,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32,),
                  Row(
                    children: const [
                      Text(
                        'Pay From',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.fontColorDark,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8,),
                  Container(
                    width: double.infinity,
                    height: 70,
                    decoration: BoxDecoration(
                      //color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: AppColors.fontColorDark),
                    ),
                  ),
                  const SizedBox(height: 32,),
                  Row(
                    children: const [
                      Text(
                        'Amount in LKR',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.fontColorDark,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8,),
                  Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      //color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: AppColors.fontColorDark),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AppButtonOutline(
                  buttonText: 'Reject',
                  onTapButton: () {},
                  width: 150,
                  verticalPadding: 10,
                ),
                // const SizedBox(
                //   width: 12,
                // ),
                AppButton(
                  buttonText: 'Accept',
                  onTapButton: () {
                    Navigator.pushNamed(
                        context, Routes.kPaymentSummeryView);
                  },
                  width: 150,
                  verticalPadding: 10,
                ),
              ],
            ),
            const SizedBox(height: 24,),
          ],
        ),
      ),
    );
  }

  @override
  Base<BaseEvent, BaseState> getBloc() {
    // TODO: implement getBloc
    return _bloc;
  }
}

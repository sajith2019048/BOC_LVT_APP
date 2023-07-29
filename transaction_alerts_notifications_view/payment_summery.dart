import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smartpay/features/presentation/bloc/base_bloc.dart';
import 'package:smartpay/features/presentation/bloc/base_event.dart';
import 'package:smartpay/features/presentation/bloc/base_state.dart';
import 'package:smartpay/features/presentation/views/base_view.dart';
import 'package:smartpay/utils/app_colors.dart';

import '../../../../core/service/dependency_injection.dart';
import '../../../../utils/app_images.dart';
import '../../bloc/otp/otp_bloc.dart';
import '../../common/app_button.dart';
import '../../common/app_button_outline.dart';
import '../../common/appbar.dart';

class PaymentSummery extends BaseView {
  PaymentSummery({Key? key}) : super(key: key);

  @override
  State<PaymentSummery> createState() => _PaymentSummeryState();
}

class _PaymentSummeryState extends BaseViewState<PaymentSummery> {
  final _bloc = injection<OtpBloc>();

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: SmartpayAppBar(
        title: "Payment Summery",
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(
            height: 78,
          ),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 21,right: 21),
                  child: Stack(
                    children: [
                      Center(
                        child: Image.asset(
                          AppImages.icPaymentSummery1,
                          height: 387,
                          width: 332,
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          width: 282,
                          height: 343,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              SizedBox(height: 38,),
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSfOFVvObAnDfY1H_mLDPXQGDgTqdY7yK1qhQ&usqp=CAU',
                                ),
                                radius: 40,
                              ),
                              SizedBox(height: 10,),
                              Text(
                                'Pay From:',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: AppColors.notificationSummeryFontColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                'My BOC Panadura',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: AppColors.notificationSummeryFontColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 30,),
                              Text(
                                'Merchant Name:',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: AppColors.notificationSummeryFontColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                'Keells Super - Battramulla',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: AppColors.notificationSummeryFontColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 30,),
                              Text(
                                'Merchant Address:',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: AppColors.notificationSummeryFontColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                textAlign: TextAlign.center,
                                'No21, Nimsara Road, Battaramulla, Koswatta',
                                style: TextStyle(
                                  color: AppColors.notificationSummeryFontColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 21,right: 21),
                  child: Stack(
                    children: [
                      Center(
                        child: Image.asset(
                          AppImages.icPaymentSummery2,
                          width: 332,
                          height: 93,
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          width: 282,
                          //height: 50,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 40,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  const Text(
                                    'Amount:',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: AppColors.notificationSummeryFontColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: const [
                                        Text(
                                          'LKR',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: AppColors.notificationSummeryFontColor,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 13,
                                          ),
                                        ),
                                        SizedBox(width: 5,),
                                        Text(
                                          '1,000.00',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: AppColors.notificationSummeryFontColor,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppButtonOutline(
                  buttonText: 'Cancel',
                  onTapButton: () {},
                  width: 150,
                  verticalPadding: 10,
                ),
                const SizedBox(width: 13,),
                AppButton(
                  buttonText: 'Confirm',
                  onTapButton: () {},
                  width: 150,
                  verticalPadding: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Base<BaseEvent, BaseState> getBloc() {
    // TODO: implement getBloc
    return _bloc;
  }
}
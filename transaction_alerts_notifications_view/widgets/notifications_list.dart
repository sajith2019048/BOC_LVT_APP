import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:smartpay/utils/enums.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/navigation_routes.dart';
import '../../../common/app_button.dart';
import '../../../common/app_button_outline.dart';

class NotificationsListView extends StatelessWidget {
  final List<NotificationsEntity> notificationList;

  const NotificationsListView({required this.notificationList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      //shrinkWrap: true,
      //physics: const NeverScrollableScrollPhysics(),
      itemCount: notificationList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {},
          child: notificationList[index].isPaymentAlert == true
              ? Container(
                  margin: const EdgeInsets.only(top: 32.0, left: 15, right: 15),

                  ///TODO: use Sizer.
                  height: 85.0,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.borderColor,
                      style: BorderStyle.solid,
                      width: 1.0,
                    ),
                    color: AppColors.colorScaffoldBackground,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //const SizedBox(height: 2.0),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              notificationList[index].title!,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: AppColors.fontColorDark,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(children: [
                                  const TextSpan(
                                    text: 'Pay for: ',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w300,
                                        color: AppColors.fontColorDark),
                                  ),
                                  TextSpan(
                                    text: notificationList[index].payFor!,
                                    style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.fontColorDark),
                                  ),
                                ]),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    notificationList[index].date!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13,
                                        color: AppColors.fontColorDark),
                                  ),
                                  SizedBox(width: 10),
                                  RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text: notificationList[index].time!,
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.fontColorDark),
                                      ),
                                      const TextSpan(
                                        text: ' AM',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w300,
                                            color: AppColors.fontColorDark),
                                      ),
                                    ]),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(children: [
                                  const TextSpan(
                                    text: 'Status : ',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w300,
                                        color: AppColors.fontColorDark),
                                  ),
                                  TextSpan(
                                    text: notificationList[index].status!,
                                    style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.fontColorDark),
                                  ),
                                ]),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Text(
                                    'Amount: ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13,
                                        color: AppColors.fontColorDark),
                                  ),
                                  RichText(
                                    text: TextSpan(children: [
                                      const TextSpan(
                                        text: 'LKR ',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w300,
                                            color: AppColors.fontColorDark),
                                      ),
                                      TextSpan(
                                        text: notificationList[index].amount!,
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.fontColorDark),
                                      ),
                                    ]),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : notificationList[index].isReceivePayment == true
                  ? Container(
                      margin:
                          const EdgeInsets.only(top: 32.0, left: 15, right: 15),

                      ///TODO: use Sizer.
                      height: 130.0,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.borderColor,
                          style: BorderStyle.solid,
                          width: 1.0,
                        ),
                        color: AppColors.colorScaffoldBackground,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //const SizedBox(height: 2.0),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  notificationList[index].title!,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: AppColors.fontColorDark,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  RichText(
                                    text: TextSpan(children: [
                                      const TextSpan(
                                        text: 'From: ',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w300,
                                            color: AppColors.fontColorDark),
                                      ),
                                      TextSpan(
                                        text: notificationList[index].from!,
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.fontColorDark),
                                      ),
                                    ]),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        'Amount: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                            color: AppColors.fontColorDark),
                                      ),
                                      RichText(
                                        text: TextSpan(children: [
                                          const TextSpan(
                                            text: 'LKR ',
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w300,
                                                color: AppColors.fontColorDark),
                                          ),
                                          TextSpan(
                                            text:
                                                notificationList[index].amount!,
                                            style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.fontColorDark),
                                          ),
                                        ]),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    //mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        notificationList[index].date!,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                            color: AppColors.fontColorDark),
                                      ),
                                      SizedBox(width: 10),
                                      RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                            text: notificationList[index].time!,
                                            style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.fontColorDark),
                                          ),
                                          const TextSpan(
                                            text: ' AM',
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w300,
                                                color: AppColors.fontColorDark),
                                          ),
                                        ]),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  AppButtonOutline(
                                    buttonText: 'Reject',
                                    onTapButton: () {},
                                    width: 92,
                                    verticalPadding: 10,
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  AppButton(
                                    buttonText: 'Accept',
                                    onTapButton: () {},
                                    width: 92,
                                    verticalPadding: 10,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : notificationList[index].isPaymentRequest == true
                      ? Container(
                          margin: const EdgeInsets.only(
                              top: 32.0, left: 15, right: 15),

                          ///TODO: use Sizer.
                          height: 130.0,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.borderColor,
                              style: BorderStyle.solid,
                              width: 1.0,
                            ),
                            color: AppColors.colorScaffoldBackground,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                //crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //const SizedBox(height: 2.0),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      notificationList[index].title!,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: AppColors.fontColorDark,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      RichText(
                                        text: TextSpan(children: [
                                          const TextSpan(
                                            text: 'From: ',
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w300,
                                                color: AppColors.fontColorDark),
                                          ),
                                          TextSpan(
                                            text: notificationList[index].from!,
                                            style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.fontColorDark),
                                          ),
                                        ]),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            'Status: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 13,
                                                color: AppColors.fontColorDark),
                                          ),
                                          Text(
                                            notificationList[index].status!,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 13,
                                                color: AppColors.fontColorDark),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        //mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            notificationList[index].date!,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 13,
                                                color: AppColors.fontColorDark),
                                          ),
                                          SizedBox(width: 10),
                                          RichText(
                                            text: TextSpan(children: [
                                              TextSpan(
                                                text: notificationList[index]
                                                    .time!,
                                                style: const TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w400,
                                                    color: AppColors
                                                        .fontColorDark),
                                              ),
                                              const TextSpan(
                                                text: ' AM',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w300,
                                                    color: AppColors
                                                        .fontColorDark),
                                              ),
                                            ]),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      AppButton(
                                        buttonText: 'View',
                                        onTapButton: () {
                                          Navigator.pushNamed(
                                              context, Routes.kPaymentRequestView);
                                        },
                                        width: 92,
                                        verticalPadding: 10,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
        );
      },
    );
  }
}

class NotificationsEntity {
  String? title;
  String? payFor;
  String? status;
  String? amount;
  String date;
  String time;
  String? from;
  bool? isPaymentAlert;
  bool? isReceivePayment;
  bool? isPaymentRequest;

  NotificationsEntity(
      {this.title,
      this.payFor,
      this.status,
      this.amount,
      required this.date,
      required this.time,
      this.from,
      this.isPaymentAlert,
      this.isReceivePayment,
      this.isPaymentRequest});
}

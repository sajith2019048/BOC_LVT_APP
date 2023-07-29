import 'package:flutter/material.dart';
import 'package:smartpay/features/presentation/bloc/base_bloc.dart';
import 'package:smartpay/features/presentation/bloc/base_event.dart';
import 'package:smartpay/features/presentation/bloc/base_state.dart';
import 'package:smartpay/features/presentation/views/base_view.dart';
import 'package:smartpay/features/presentation/views/transaction_alerts_notifications_view/widgets/notifications_list.dart';

import '../../../../core/service/dependency_injection.dart';
import '../../bloc/otp/otp_bloc.dart';
import '../../common/appbar.dart';

class NotificationView extends BaseView {
  NotificationView({Key? key}) : super(key: key);

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends BaseViewState<NotificationView> {
  final _bloc = injection<OtpBloc>();

  final List<NotificationsEntity> notificationList = [
    NotificationsEntity(
      isPaymentAlert: true,
      title: 'Payment Alert',
      payFor: 'Chanuka',
      status: 'Completed',
      date: '07-Oct-2022',
      time: '10:15',
      amount: '1,000.00',

    ),
    NotificationsEntity(
      isReceivePayment: true,
      title: 'You have received a payment',
        from: 'Received Name',
        amount: '1000.00',
        date: '07-Oct-2022',
        time: '10:15'
    ),
    NotificationsEntity(
        isPaymentRequest: true,
        title: 'You have payment request',
        from: 'Keels Super - Battaramulla',
        status: 'Pending',
        date: '07-Oct-2022',
        time: '10:15'
    ),
  ];

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: SmartpayAppBar(
        title: "Notification",
        // onBackPressed: () {
        //   Navigator.pop(context);
        // },
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      body: NotificationsListView(notificationList: notificationList ,),
    );
  }

  @override
  Base<BaseEvent, BaseState> getBloc() {
    // TODO: implement getBloc
    return _bloc;
  }
}

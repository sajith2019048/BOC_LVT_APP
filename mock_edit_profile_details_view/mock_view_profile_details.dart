import 'package:flutter/material.dart';
import 'package:smartpay/features/presentation/bloc/base_bloc.dart';
import 'package:smartpay/features/presentation/bloc/base_event.dart';
import 'package:smartpay/features/presentation/bloc/base_state.dart';
import 'package:smartpay/features/presentation/common/app_button.dart';
import 'package:smartpay/features/presentation/common/appbar.dart';
import 'package:smartpay/features/presentation/views/base_view.dart';
import 'package:smartpay/utils/app_colors.dart';
import 'package:smartpay/utils/app_constants.dart';

import '../../../../core/service/dependency_injection.dart';
import '../../../../utils/navigation_routes.dart';
import '../../bloc/fresh_login/fresh_login_bloc.dart';

class ProfileDetailsView extends BaseView {
  ProfileDetailsView({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileDetailsView> createState() => _ProfileDetailsViewState();
}

class _ProfileDetailsViewState extends BaseViewState<ProfileDetailsView> {
  final _bloc = injection<FreshLoginBloc>();

  String fName = AppConstants.FIRST_NAME;

  @override
  Base<BaseEvent, BaseState> getBloc() {
    return _bloc;
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: SmartpayAppBar(
        title: 'My Profile',
      ),
      body: Padding(
        padding:
        const EdgeInsets.only(left: 29, right: 29, top: 32, bottom: 24),
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                AppConstants.PROFILE_PICTURE,
              ),
              radius: 60,
            ),
            Expanded(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top:24),
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "First Name",
                      style: TextStyle(
                          color: AppColors.colorHintTextLabel,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top:5),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      fName,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.fontColorDark),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top:24),
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Last Name",
                      style: TextStyle(
                          color: AppColors.colorHintTextLabel,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top:5),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      AppConstants.LAST_NAME,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.fontColorDark),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top:24),
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "National Identity Card Number",
                      style: TextStyle(
                          color: AppColors.colorHintTextLabel,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top:5),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      AppConstants.NIC,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.fontColorDark),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top:24),
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Mobile",
                      style: TextStyle(
                          color: AppColors.colorHintTextLabel,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top:5),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      AppConstants.MOBILE_NUMBER,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.fontColorDark),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top:24),
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Email",
                      style: TextStyle(
                          color: AppColors.colorHintTextLabel,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top:5),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      AppConstants.EMAIL_ADDRESS,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.fontColorDark),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top:24),
                  ),
                ],
              ),
            ),
            AppButton(
                buttonText: 'Edit',
                textColor: AppColors.fontColorDark,
                onTapButton: () {
                  Navigator.pushNamed(context, Routes.kEditProfileView).then((value) =>  {
                    setState(() {
                      fName = AppConstants.FIRST_NAME;
                    })
                  });
                }),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smartpay/core/service/dependency_injection.dart';
import 'package:smartpay/features/presentation/bloc/base_bloc.dart';
import 'package:smartpay/features/presentation/bloc/base_event.dart';
import 'package:smartpay/features/presentation/bloc/base_state.dart';
import 'package:smartpay/features/presentation/bloc/fresh_login/fresh_login_bloc.dart';
import 'package:smartpay/features/presentation/common/app_button.dart';
import 'package:smartpay/features/presentation/common/app_dialog.dart';
import 'package:smartpay/features/presentation/views/base_view.dart';
import 'package:smartpay/features/presentation/views/otp_view/otp_view.dart';
import 'package:smartpay/utils/app_colors.dart';
import 'package:smartpay/utils/app_images.dart';
import 'package:smartpay/utils/enums.dart';

import '../../../../utils/navigation_routes.dart';
import '../../common/on_boarding_button.dart';

class LoginView extends BaseView {
  LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends BaseViewState<LoginView> {
  final _bloc = injection<FreshLoginBloc>();

  String _mobileNumber = "";

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocProvider<FreshLoginBloc>(
        create: (context) => _bloc,
        child: BlocListener<FreshLoginBloc, BaseState<FreshLoginState>>(
          listener: (context, state) {
            if (state is MobileNumberEmptyFailedState) {
              showDialog(
                context: context,
                builder: (context) =>
                    AppDialog(title: "Mobile Number is Empty!"),
              );
            } else if (state is MobileNumberValidateFailedState) {
              showDialog(
                context: context,
                builder: (context) =>
                    AppDialog(title: "Invalid Mobile Number!"),
              );
            } else if (state is FreshLoginSuccessState) {
              Navigator.pushNamed(
                context,
                Routes.kOtpView,
                arguments: OTPViewArgs(
                  mobileNo: _mobileNumber,
                  fromView: ToOtpView.FROMLOGIN,
                ),
              );
            }
          },
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.colorPrimary,
                    AppColors.colorSecondary,
                    AppColors.fontColorWhite,
                    AppColors.fontColorWhite,
                    AppColors.fontColorWhite,
                    AppColors.fontColorWhite,
                  ]),
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: ()=> Navigator.pop(context),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 18.0),
                          child: SvgPicture.asset(
                            AppImages.icBack,
                          ),
                        ),
                      ),
                      // SvgPicture.asset(
                      //   AppImages.icInfo,
                      // ),
                      //TODO add info
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 75,
                        ),
                        Image.asset(
                          AppImages.imgSmartPay,
                          height: 80,
                        ),
                        const SizedBox(
                          height: 48,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 24.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Text(
                                "Welcome,",
                                style: TextStyle(
                                    fontSize: 32, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 24.0, top: 8, bottom: 55),
                          child: Row(
                            children: const [
                              Text(
                                "We are happy to see you here!",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(
                            vertical: 24,
                            horizontal: 24,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppColors.colorPrimary,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Enter your mobile number to continue",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: AppColors.fontColorGray,
                                ),
                                textAlign: TextAlign.start,
                              ),
                              TextFormField(
                                maxLength: 9,
                                decoration: const InputDecoration(
                                  counterText: "",
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.colorPrimary),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.colorPrimary),
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.colorPrimary),
                                  ),
                                  prefixText: "+94 ",
                                  prefixStyle: TextStyle(
                                      color: AppColors.textFieldPrefixColor),
                                  label: Text(
                                    "Mobile Number",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: AppColors.fontColorGray,
                                    ),
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _mobileNumber = value;
                                  });
                                },
                                keyboardType: TextInputType.number,
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              OnBoardingButton(
                                buttonText: "Continue",
                                onClick: () {
                                  _bloc.add(
                                    MobileNumberVerificationEvent(
                                      mobileNumber: "0$_mobileNumber",
                                    ),
                                  );
                                },
                              ),

                            ],
                          ),
                        ),
                        // const Spacer(),
                      ],
                    ),
                  ),
                ),
                InkResponse(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.kContactUsView);
                  },
                  child: Image.asset(
                    "images/png/contact_icon.png",
                    height: 60,
                    width: 60,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Base<BaseEvent, BaseState> getBloc() {
    return _bloc;
  }
}

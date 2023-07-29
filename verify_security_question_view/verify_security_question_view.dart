import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartpay/features/data/datasources/shared_preference.dart';
import 'package:smartpay/features/presentation/bloc/base_bloc.dart';
import 'package:smartpay/features/presentation/bloc/base_event.dart';
import 'package:smartpay/features/presentation/bloc/base_state.dart';
import 'package:smartpay/features/presentation/bloc/security_question/security_question_bloc.dart';
import 'package:smartpay/features/presentation/views/base_view.dart';
import 'package:smartpay/features/presentation/views/otp_view/otp_view.dart';
import 'package:smartpay/utils/app_constants.dart';
import 'package:smartpay/utils/enums.dart';

import '../../../../core/service/dependency_injection.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../data/models/request/security_question_bean.dart';
import '../../bloc/otp/otp_bloc.dart';
import '../../common/app_button.dart';
import '../../common/app_button_outline.dart';
import '../../common/app_text_field.dart';
import '../../common/appbar.dart';

class VerifySecurityQuestionView extends BaseView {
  VerifySecurityQuestionView({Key? key}) : super(key: key);

  @override
  _VerifySecurityQuestionViewState createState() =>
      _VerifySecurityQuestionViewState();
}

class _VerifySecurityQuestionViewState
    extends BaseViewState<VerifySecurityQuestionView> {
  final _bloc = injection<SecurityQuestionBloc>();
  List<SecurityQuestionBean> questionsList = [];
  String answer1 = "";
  String answer2 = "";
  String answer3 = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc.add(SecurityQuestionRequestEvent(
        type: AppConstants.REQUEST_SECURITY_QUESTIONS_ANSWERD));
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: SmartpayAppBar(
        title: "Security Questions Verifications",
      ),
      body: BlocProvider<SecurityQuestionBloc>(
        create: (context) => _bloc,
        child: BlocListener<SecurityQuestionBloc,
            BaseState<SecurityQuestionState>>(
          bloc: _bloc,
          listener: (context, state) {
            if (state is SecurityQuestionRequestSuccessState) {
              setState(() {
                questionsList = state.questionList!;
              });
            } else if (state is SaveAnswersSuccessState) {
              // Todo Navigate WalletOTPVerificationView
              Navigator.pushNamed(
                context,
                Routes.kOtpView,
                arguments: OTPViewArgs(
                  fromView: ToOtpView.FROMLOGINFORGETPINQUESTIONANSWER,
                  isFormVerifySecurity: true,
                  isOtpSent: true,
                  mobileNo: appSharedData.getData(MOBILE_NO_PREFERENCE),
                ),
              );
            }
          },
          child: Container(
            margin: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15.0),
                Text(questionsList.isNotEmpty ? questionsList[0].value! : ""),
                AppTextField(
                  hint: "",
                  onTextChanged: (value) {
                    setState(() {
                      answer1 = value;
                    });
                  },
                ),
                const SizedBox(height: 15.0),
                Text(questionsList.isNotEmpty ? questionsList[1].value! : ""),
                AppTextField(
                  hint: "",
                  onTextChanged: (value) {
                    setState(() {
                      answer2 = value;
                    });
                  },
                ),
                const SizedBox(height: 15.0),
                Text(questionsList.isNotEmpty ? questionsList[2].value! : ""),
                AppTextField(
                  hint: "",
                  onTextChanged: (value) {
                    setState(() {
                      answer3 = value;
                    });
                  },
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: AppButton(
                        buttonText: "Verify",
                        textColor: Colors.black,
                        onTapButton: () {
                          _bloc.add(
                            SaveAnswersEvent(
                              type: AppConstants.VERIFY_SECURITY_QUESTIONS,
                              question1ID: questionsList[0].code.toString(),
                              question2ID: questionsList[1].code.toString(),
                              question3ID: questionsList[2].code.toString(),
                              answer1: answer1,
                              answer2: answer2,
                              answer3: answer3,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: AppButtonOutline(
                        buttonText: "Cancel",
                        onTapButton: () {
                          Navigator.pop(context);
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

  @override
  Base<BaseEvent, BaseState> getBloc() {
    return _bloc;
  }
}

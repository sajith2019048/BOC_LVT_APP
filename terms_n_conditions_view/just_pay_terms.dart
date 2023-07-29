import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:smartpay/features/data/models/response/just_pay_data_bean.dart';
import 'package:smartpay/features/presentation/common/app_button.dart';
import 'package:smartpay/utils/app_constants.dart';

import '../../../../core/service/app_permission.dart';
import '../../../../core/service/dependency_injection.dart';
import '../../../../core/service/platform_services.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/device_info.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../data/models/common/justpay_payload.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../bloc/just_pay/just_pay_bloc.dart';
import '../../common/app_dialog.dart';
import '../../common/appbar.dart';
import '../base_view.dart';

class JustPayArgs {
  final JustPayDataBean justPayBean;
  final bool isCommonTerm;

  JustPayArgs({required this.justPayBean, required this.isCommonTerm});
}

class JustPayTermsView extends BaseView {
  final JustPayArgs justPayArgs;

  JustPayTermsView({required this.justPayArgs});

  @override
  State<JustPayTermsView> createState() => _TermsNConditionsViewState();
}

class _TermsNConditionsViewState extends BaseViewState<JustPayTermsView> {
  var bloc = injection<JustPayBloc>();
  final DeviceInfo deviceInfo = DeviceInfo();
  String termsNConditions = '';
  Widget? html;

  @override
  Widget buildView(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (!widget.justPayArgs.isCommonTerm) {
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: SmartpayAppBar(
          title: "Terms and Conditions",
          goBackEnabled: !widget.justPayArgs.isCommonTerm,
          onBackPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
          },
        ),
        body: RepositoryProvider(
          create: (context) => bloc,
          child: BlocListener<JustPayBloc, BaseState<JustPayState>>(
            listener: (_, state) {
              if (state is DeviceChangeJustPayRevokeSuccessState) {
                _createJustPayIdentity(state.challangeId!);
              } else if (state
                  is ParseSignedTermsRequestDeviceChangeSuccessState) {
                Navigator.pushReplacementNamed(context, Routes.kLoginPinView);
              } else if (state is ParseSignedTermsSuccessState) {
                showDialog(
                  context: context,
                  builder: (context) => AppDialog(
                      alertType: AlertType.SUCCESS,
                      title: "SUCCESS",
                      description: "Payment Instrument verified successfully.",
                      positiveButtonText: 'Continue',
                      onPositiveCallback: () {
                        if (!widget.justPayArgs.isCommonTerm) {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context,true);
                        } else {
                          Navigator.pushReplacementNamed(
                              context, Routes.kPaymentMethodsView);
                        }
                      }),
                );
              }
            },
            child: Container(
              margin: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Please read carefully.",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            width: 30.0,
                            child: Divider(
                              color: AppColors.colorPrimary,
                              thickness: 3.0,
                            ),
                          ),
                          const SizedBox(height: 15.0),
                          Html(
                            data: widget.justPayArgs.justPayBean.justPayTerms!,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  AppButton(
                    buttonText: 'Accept',
                    textColor: AppColors.fontColorDark,
                    onTapButton: () {
                      _termsVerificationRequest();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _termsVerificationRequest() {
    if (widget.justPayArgs.justPayBean.challangeId != null) {
      _createJustPayIdentity(widget.justPayArgs.justPayBean.challangeId!);
    } else {
      showProgressBar();
      _onIdentitySuccess();
    }
  }

  _createJustPayIdentity(String s) async {
    showProgressBar();
    JustPayPayload justPayPayload =
        await PlatformServices.justPayCreateIdentity(s);
    if (justPayPayload.isSuccess) {
      _onIdentitySuccess();
    } else {
      _onIdentityFailed(justPayPayload.code!, s);
    }
  }

  _onIdentitySuccess() async {
    AppPermissionManager.requestReadPhoneStatePermission(context, () async {
      if (await PlatformServices.isJustPayIdentityExists()) {
        JustPayPayload justPayPayload =
            await PlatformServices.justPaySignedTerms(
                widget.justPayArgs.justPayBean.justPayTerms!);
        if (justPayPayload.isSuccess) {
          hideProgressBar();
          if (widget.justPayArgs.isCommonTerm) {
            bloc.add(ParseSignedTermsRequestDeviceChangeEvent(
                encTc: justPayPayload.data));
          } else {
            bloc.add(
              ParseSignedTermsRequestEvent(
                accountType: AppConstants.INSTRUMENT_TYPE_ACCOUNT,
                cardToken: widget.justPayArgs.justPayBean.paymentToken,
                challengeIdExistFlag:
                    await PlatformServices.isJustPayIdentityExists()
                        ? "0"
                        : "1",
                signedTerms: justPayPayload.data,
              ),
            );
          }
        } else {
          hideProgressBar();
          showAppDialog(
            title: 'Oops!',
            message: 'Something went wrong',
            alertType: AlertType.FAIL,
          );
        }
      }
      else {
        bloc.add(DeviceChangeJustPayRevokeEvent(
            justpayDeviceId: await PlatformServices.getJustPayDeviceId()));
        hideProgressBar();
      }
    });
    hideProgressBar();
  }

  _onIdentityFailed(int i, String s) async {
    hideProgressBar();
    showAppDialog(
      title: 'Oops!',
      message: 'Something went wrong',
      alertType: AlertType.FAIL,
    );
  }

  @override
  Base<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}

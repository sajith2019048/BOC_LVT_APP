import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartpay/features/presentation/views/sign_up_view/widgets/boc_id_capture.dart';

import '../../../../core/service/app_permission.dart';
import '../../../../core/service/dependency_injection.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/common_info.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../data/datasources/shared_preference.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../bloc/sign_up/sign_up_bloc.dart';
import '../../common/app_button.dart';
import '../../common/app_button_outline.dart';
import '../../common/app_text_field.dart';
import '../../common/appbar.dart';
import '../base_view.dart';
import '../create_pin_view/create_pin_view.dart';
import '../otp_view/otp_view.dart';
import '../security_questions_view/security_questions_view.dart';

class UserSignUpView extends BaseView {
  UserSignUpView({Key? key}) : super(key: key);

  @override
  State<UserSignUpView> createState() => _UserSignUpViewState();
}

class _UserSignUpViewState extends BaseViewState<UserSignUpView> {
  var signUpbloc = injection<SignUpBloc>();

  String? mobileNumber,
      firstName,
      lastName,
      identityType,
      idNumber,
      passportNumber,
      email;

  List<DropdownMenuItem<String>> identityTypes = [
    const DropdownMenuItem(
      value: "NIC",
      child: Text(
        "NIC",
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
    const DropdownMenuItem(
      value: "Passport",
      child: Text(
        "Passport",
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
  ];
  List<Widget> popUpList = [];

  var nicPassportController = TextEditingController();
  var mobileNumberController = TextEditingController();

  String? selectedIdentity;
  String? selectedSelfieImage;
  String? selectedFrontIdImage;
  String? selectedBackIdImage;

  @override
  void initState() {
    super.initState();
    try {
      appSharedData.setData(IS_LOGGED_IN_PREFERENCE, "false");
      if (appSharedData.getData(IS_OTP_OBTAINED) == "1") {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          redirectApp();
        });
      }
    } on Exception catch (e) {

    }
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: SmartpayAppBar(
        title: "User Sign Up",
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      body: BlocProvider<SignUpBloc>(
        create: (context) => signUpbloc,
        child: BlocListener<SignUpBloc, BaseState<SignUpState>>(
          bloc: signUpbloc,
          listener: (_, state) {
            if (state is SignUpSuccessState) {
              Navigator.pushNamed(
                context,
                Routes.kOtpView,
                arguments: OTPViewArgs(
                  fromView: ToOtpView.FROMSIGNUP,
                  mobileNo: appSharedData.getData(MOBILE_NO_PREFERENCE),
                ),
              ).then((value) {
                if (value != null) {
                  if (value as bool) {
                    Navigator.pushReplacementNamed(
                      context,
                      Routes.kSecurityQuestionView,
                      arguments: SecurityQuestionsArgs(
                        fromView: ToSecurityQuestionView.FROMSIGNUP,
                      ),
                    );
                  }
                } else {
                  Navigator.pop(context);
                }
              });
            } else if (state is SignUpFailedState) {
              showAppDialog(
                title: 'Oops',
                alertType: AlertType.FAIL,
                message: state.message,
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
                          "Please enter your personal details and upload required documents. Then click continue",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 35.0),
                        Center(
                          child: Column(
                            children: [
                              const Text(
                                "Profile Picture",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              IdCapture(
                                idType: IDType.SELFIE,
                                image: selectedSelfieImage,
                                onTap: () {
                                  _captureImage(IDType.SELFIE);
                                },
                                onDelete: () {
                                  _deleteImage(IDType.SELFIE);
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15.0),
                        AppTextField(
                          hint: "Mobile Number",
                          controller: mobileNumberController,
                          maxLength: 10,
                          inputType: TextInputType.number,
                          onTextChanged: (value) {
                            setState(() {
                              mobileNumber = value;
                            });
                          },
                        ),
                        const SizedBox(height: 35.0),
                        AppTextField(
                          hint: "First Name",
                          onTextChanged: (value) {
                            setState(() {
                              firstName = value;
                            });
                          },
                        ),
                        const SizedBox(height: 35.0),
                        AppTextField(
                          hint: "Last Name",
                          onTextChanged: (value) {
                            setState(() {
                              lastName = value;
                            });
                          },
                        ),
                        const SizedBox(height: 35.0),
                        DropdownButton<String>(
                            isExpanded: true,
                            items: identityTypes,
                            value: selectedIdentity,
                            hint: const Text(
                              "Select type of identity",
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            underline: Container(
                              height: 1,
                              color: AppColors.colorPrimary,
                            ),
                            onChanged: (value) {
                              setState(() {
                                if (selectedIdentity != value!) {
                                  nicPassportController.clear();
                                  passportNumber = "";
                                  idNumber = "";
                                }
                                selectedIdentity = value;
                              });
                            }),
                        const SizedBox(height: 35.0),
                        selectedIdentity != null
                            ? Column(
                                children: [
                                  AppTextField(
                                    controller: nicPassportController,
                                    hint: selectedIdentity == "Passport"
                                        ? "Passport Number"
                                        : "National Identity Card Number",
                                    onTextChanged: (value) {
                                      setState(() {
                                        if (selectedIdentity == "Passport") {
                                          passportNumber = value;
                                        } else {
                                          idNumber = value;
                                        }
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 35.0),
                                ],
                              )
                            : const SizedBox.shrink(),
                        AppTextField(
                          hint: "Email",
                          onTextChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          },
                        ),
                        const SizedBox(height: 35.0),
                        const Text(
                          "Images of National Identity Card",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 25.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IdCapture(
                              idType: IDType.ID_FRONT,
                              image: selectedFrontIdImage,
                              onTap: () {
                                _captureImage(IDType.ID_FRONT);
                              },
                              onDelete: () {
                                _deleteImage(IDType.ID_FRONT);
                              },
                            ),
                            IdCapture(
                              idType: IDType.ID_BACK,
                              image: selectedBackIdImage,
                              onTap: () {
                                _captureImage(IDType.ID_BACK);
                              },
                              onDelete: () {
                                _deleteImage(IDType.ID_BACK);
                              },
                            )
                          ],
                        ),
                        const SizedBox(height: 35.0),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    AppButton(
                        buttonText: "Continue",
                        textColor: AppColors.appColorDark,
                        onTapButton: () {
                          signUpbloc.add(UserSignUpEvent(
                            idNumber: selectedIdentity == "NIC"
                                ? idNumber
                                : passportNumber,
                            mobileNumber: mobileNumber,
                            profileImageUrl: '',
                            lastName: lastName,
                            firstName: firstName,
                            email: email,
                            selectedIdentity: selectedIdentity,
                            selectedSelfieImage: selectedSelfieImage,
                            selectedFrontIdImage: selectedFrontIdImage,
                            selectedBackIdImage: selectedBackIdImage,
                          ));
                        }),
                    const SizedBox(height: 5.0),
                    AppButtonOutline(
                      appButtonStyle: AppButtonStyle.EMPTY,
                      onTapButton: () {
                        Navigator.pop(context);
                      },
                      buttonText: 'Cancel',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///CaptureImage
  _captureImage(IDType idType) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20.0),
          child: Wrap(
            spacing: 15.0,
            children: [
              AppButton(
                textColor: AppColors.fontColorDark,
                buttonText: "Open Camera",
                onTapButton: () {
                  AppPermissionManager.requestCameraPermission(context, () {
                    _saveImage(idType);
                  });
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 15.0),
              AppButton(
                textColor: AppColors.fontColorDark,
                buttonText: "Upload",
                onTapButton: () {
                  AppPermissionManager.requestGalleryPermission(context, () {
                    _saveImage(idType, isFromCamera: false);
                  });
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 15.0),
              AppButtonOutline(
                appButtonStyle: AppButtonStyle.EMPTY,
                onTapButton: () {
                  Navigator.pop(context);
                },
                buttonText: 'Cancel',
              ),
            ],
          ),
        );
      },
    );
  }

  ///SaveImage
  _saveImage(IDType idType, {bool isFromCamera = true}) async {
    final XFile? file = await ImagePicker().pickImage(
        source: isFromCamera ? ImageSource.camera : ImageSource.gallery,
        imageQuality: 25,
        maxHeight: 480,
        maxWidth: idType == IDType.SELFIE ? 480 : 640);
    if (file != null) {
      final CroppedFile? cropped = await AppImageCropper()
          .getCroppedImage(PickedFile(file.path), idType);
      if (cropped != null) {
        final output = cropped.path;

        switch (idType) {
          case IDType.SELFIE:
            selectedSelfieImage = output;
            break;
          case IDType.ID_FRONT:
            selectedFrontIdImage = output;
            break;
          case IDType.ID_BACK:
            selectedBackIdImage = output;
            break;
        }
      }
    }

    setState(() {});
  }

  ///Delete Image
  _deleteImage(IDType idType) {
    switch (idType) {
      case IDType.SELFIE:
        selectedSelfieImage = null;
        break;
      case IDType.ID_FRONT:
        selectedFrontIdImage = null;
        break;
      case IDType.ID_BACK:
        selectedBackIdImage = null;
        break;
    }

    setState(() {});
  }

  ///Redirect the user
  redirectApp() {
    try {
      if (appSharedData.getData(IS_REGISTERED) == "1") {
        if (appSharedData.getData(START_PINNED) == "1") {
          Navigator.pushReplacementNamed(context, Routes.kLoginPinView);
        } else {
          Navigator.pushReplacementNamed(
            context,
            Routes.kPinCreateView,
            arguments: CreatePinArgs(
              fromView: ToPinCreate.FROMSECURITYQUESTION,
            ),
          );
        }
      } else {
        if (CommonInfo.ISRESEND) {
          CommonInfo.ISRESEND = false;
          mobileNumberController.text = CommonInfo.USERPHONENO;
        } else {
          Navigator.pushNamed(
            context,
            Routes.kOtpView,
            arguments: OTPViewArgs(
              fromView: ToOtpView.FROMSIGNUP,
              mobileNo: appSharedData.getData(MOBILE_NO_PREFERENCE),
            ),
          ).then((value) {
            if (value != null) {
              if (value as bool) {
                Navigator.pushReplacementNamed(
                  context,
                  Routes.kSecurityQuestionView,
                  arguments: SecurityQuestionsArgs(
                    fromView: ToSecurityQuestionView.FROMSIGNUP,
                  ),
                );
              }
            } else {
              Navigator.pop(context);
            }
          });
        }
      }
    } catch (e) {
    }
  }

  @override
  Base<BaseEvent, BaseState> getBloc() {
    return signUpbloc;
  }
}

class AppImageCropper {
  Future<CroppedFile?> getCroppedImage(PickedFile file, IDType idType) async {
    return ImageCropper().cropImage(
      sourcePath: file.path,
      aspectRatioPresets: idType == IDType.SELFIE
          ? [CropAspectRatioPreset.square]
          : [CropAspectRatioPreset.ratio4x3],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: AppColors.colorPrimary,
            toolbarWidgetColor: AppColors.colorScaffoldBackground,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true),
        IOSUiSettings(
          minimumAspectRatio: 1.0,
        ),
      ],
    );
  }
}

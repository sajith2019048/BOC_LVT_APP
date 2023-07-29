import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartpay/core/service/dependency_injection.dart';
import 'package:smartpay/error/messages.dart';
import 'package:smartpay/features/presentation/bloc/base_bloc.dart';
import 'package:smartpay/features/presentation/bloc/base_event.dart';
import 'package:smartpay/features/presentation/bloc/base_state.dart';
import 'package:smartpay/features/presentation/bloc/edit_profile/edit_profile_bloc.dart';
import 'package:smartpay/features/presentation/bloc/fresh_login/fresh_login_bloc.dart';
import 'package:smartpay/features/presentation/common/app_text_field.dart';
import 'package:smartpay/features/presentation/common/appbar.dart';
import 'package:smartpay/features/presentation/views/base_view.dart';
import 'package:smartpay/features/presentation/views/sign_up_view/widgets/boc_id_capture.dart';
import 'package:smartpay/utils/app_constants.dart';
import 'package:smartpay/utils/app_extensions.dart';
import 'package:smartpay/utils/app_images.dart';
import 'package:smartpay/utils/enums.dart';

import '../../../../core/service/app_permission.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/common_info.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../data/datasources/shared_preference.dart';
import '../../common/app_button.dart';
import '../../common/app_button_outline.dart';
import '../../common/app_dialog.dart';
import '../create_pin_view/create_pin_view.dart';
import '../otp_view/otp_view.dart';
import '../security_questions_view/security_questions_view.dart';
import '../sign_up_view/user_sign_up_view.dart';

class EditProfileView extends BaseView {

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends BaseViewState<EditProfileView> {
  final _bloc = injection<EditProfileBloc>();

  late TextEditingController fname = TextEditingController();
  late TextEditingController lname = TextEditingController();
  late TextEditingController nic = TextEditingController();
  late TextEditingController mobile = TextEditingController();
  late TextEditingController emailAddress = TextEditingController();
  var mobileNumberController = TextEditingController();

  String? firstName;
  String? lastName;
  String? idNumber;
  String? email;

  String? selectedIdentity;
  String? selectedSelfieImage;
  String? selectedFrontIdImage;
  String? selectedBackIdImage;

  bool isCommonPin = false;

  @override
  void initState() {
    super.initState();
    fname.text = AppConstants.FIRST_NAME;
    lname.text = AppConstants.LAST_NAME;
    nic.text = AppConstants.NIC;
    mobile.text = AppConstants.MOBILE_NUMBER;
    emailAddress.text = AppConstants.EMAIL_ADDRESS;
    selectedSelfieImage = AppConstants.PROFILE_PICTURE;
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: SmartpayAppBar(
        title: 'My Profile',
      ),
      body: BlocProvider<EditProfileBloc>(
        create: (context) => _bloc,
        child: BlocListener<EditProfileBloc, BaseState<EditProfileState>>(
          bloc: _bloc,
          listener: (context, state) {
            if (state is EditProfileFailState) {
              showAppDialog(
                title: 'Oops',
                alertType: AlertType.FAIL,
                message: state.message,
              );
            } else if (state is EditProfileSuccessState) {
              _bloc.add(GetProfileDataEvent(shouldClose: true));
            } else if (state is GetProfileDataState) {
              showAppDialog(
                  title: ErrorHandler.TITLE_SUCCESS,
                  message: 'Successfully Updated!',
                  onPositiveCallback: () {
                    if (state.shouldClose) {
                      Navigator.pop(context);
                    } else {
                      setState(() {});
                    }
                  });
            } else if (state is ProfilePicUploadSuccessState) {
              _bloc.add(GetProfileDataEvent(shouldClose: false));
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Container(
                  width: 120,
                  height: 130,
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      Stack(children: [
                        GestureDetector(
                          child: CircleAvatar(
                            backgroundImage:
                                NetworkImage(AppConstants.PROFILE_PICTURE),
                            radius: 60,
                          ),
                          onTap: () {
                            _captureImage(IDType.SELFIE);
                          },
                        ),
                      ]),
                      Positioned(
                        right: 0,
                        bottom: 5,
                        child: GestureDetector(
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                AppConstants.PROFILE_PICTURE,
                              )),
                              border: Border.all(
                                  color: AppColors.colorPrimary, width: 1.0),
                            ),
                            child: CircleAvatar(
                              //backgroundColor: AppColors.colorScaffoldBackground,
                              backgroundColor:
                                  AppColors.colorScaffoldBackground,
                              radius: 18,
                              child: SvgPicture.asset(
                                AppImages.icCamera,
                              ),
                            ),
                          ),
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top:10),
                ),
                Expanded(
                    child: Column(
                      children: [
                        AppTextField(
                          controller: fname,
                          isLabel: true,
                          hint: "First Name",
                          onTextChanged: (value) {
                            setState(() {
                              firstName = value;
                            });
                          },
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top:10),
                        ),
                        AppTextField(
                          controller: lname,
                          isLabel: true,
                          hint: "Last Name",
                          onTextChanged: (value) {
                            setState(() {
                              lastName = value;
                            });
                          },
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top:10),
                        ),
                        AppTextField(
                          isEnable: false,
                          controller: nic,
                          isLabel: true,
                          hint: "National Identity Card Number",
                          onTextChanged: null,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top:10),
                        ),
                        AppTextField(
                          isEnable: false,
                          isLabel: true,
                          hint: "Mobile Number",
                          controller: mobile,
                          maxLength: 10,
                          inputType: TextInputType.number,
                          onTextChanged: null,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top:10),
                        ),
                        AppTextField(
                          controller: emailAddress,
                          isLabel: true,
                          hint: "Email",
                          onTextChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          },
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top:40),
                        ),
                      ],
                    ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top:24),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Wrap(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 28,right: 28),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: SvgPicture.asset(
                                    AppImages.icExclamation,
                                  ),
                                ),
                                const Text(
                                  'You cannot change your NIC number and\n number. If you want to change it,Please\n contact the bank',
                                  softWrap: true,
                                  //textAlign: TextAlign.justify,
                                ),
                              ],
                            ),
                          ),
                        ]

                      ),
                      const Padding(
                        padding: EdgeInsets.only(top:20),
                      ),
                      AppButton(
                        buttonText: "Save",
                        buttonType: ButtonType.ENABLED,
                        textColor: AppColors.fontColorDark,
                        onTapButton: () {
                          if(_validate()){
                            _bloc.add(
                              SaveDetailsClickEvent(
                                  firstName: fname.text,
                                  lastName: lname.text,
                                  email: emailAddress.text,
                                  profilePic: AppConstants.PROFILE_PICTURE),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _validate(){
    if(fname.text.isEmpty){
      showAppDialog(title: ErrorHandler.TITLE_OOPS, message: 'First name cannot be empty');
      return false;
    }else if(lname.text.isEmpty){
      showAppDialog(title: ErrorHandler.TITLE_OOPS, message: 'Last name cannot be empty');
      return false;
    }else if(emailAddress.text.isEmpty){
      showAppDialog(title: ErrorHandler.TITLE_OOPS, message: 'Email cannot be empty');
      return false;
    }else{
      return true;
    }
  }

  @override
  Base<BaseEvent, BaseState> getBloc() {
    return _bloc;
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
        _bloc.add(ProfilePicUploadEvent(
            image: output.getBase64(), imageType: IDType.SELFIE));
      }
    }

    setState(() {});
  }

  // ///Delete Image
  // _deleteImage(IDType idType) {
  //   switch (idType) {
  //     case IDType.SELFIE:
  //       selectedSelfieImage = null;
  //       break;
  //     case IDType.ID_FRONT:
  //       selectedFrontIdImage = null;
  //       break;
  //     case IDType.ID_BACK:
  //       selectedBackIdImage = null;
  //       break;
  //   }
  //
  //   setState(() {});
  // }

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
    } catch (e) {}
  }
}

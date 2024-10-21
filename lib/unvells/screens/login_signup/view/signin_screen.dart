/*
 *


 *
 * /
 */

import 'dart:convert';
import 'dart:developer';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:lottie/lottie.dart';
import 'package:test_new/unvells/app_widgets/app_dialog_helper.dart';
import 'package:test_new/unvells/app_widgets/app_text_field.dart';
import 'package:test_new/unvells/app_widgets/custom_button.dart';
import 'package:test_new/unvells/app_widgets/flux_image.dart';
import 'package:test_new/unvells/configuration/text_theme.dart';
import 'package:test_new/unvells/constants/app_routes.dart';
import 'package:test_new/unvells/helper/app_storage_pref.dart';

import '../../../app_widgets/app_alert_message.dart';
import '../../../app_widgets/app_bar.dart';
import '../../../app_widgets/app_outlined_button.dart';
import '../../../app_widgets/dialog_helper.dart';
import '../../../app_widgets/loader.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/app_string_constant.dart';
import '../../../helper/app_localizations.dart';
import '../../../helper/bottom_sheet_helper.dart';
import '../../../helper/encryption.dart';
import '../../../helper/utils.dart';
import '../../../models/dashboard/UserDataModel.dart';
import '../../../models/login_signup/login_response_model.dart';
import '../../login_signup/bloc/signin_signup_screen_bloc.dart';
import '../bloc/signin_signup_screen_repository.dart';
import 'create_account_screen.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen(this.isComingFromCartPage, {Key? key}) : super(key: key);
  final bool isComingFromCartPage;

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late TextEditingController _emailController, _passwordController;
  SigninSignupScreenBloc? bloc;
  late bool _obscureText, _loading;
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _emailController =
        TextEditingController(text: kDebugMode ? AppConstant.demoEmail : '');
    _passwordController =
        TextEditingController(text: kDebugMode ? AppConstant.demoPassword : "");

    bloc = context.read<SigninSignupScreenBloc>();
    _loading = false;
    _formKey = GlobalKey();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void _validateForm() async {
    if (kDebugMode) {
      print('Logining.....');
    }
    if (_formKey.currentState?.validate() == true) {
      Utils.hideSoftKeyBoard();
      bloc?.add(
          LoginEvent(_emailController.text.trim(), _passwordController.text));
      bloc?.emit(LoadingState());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SigninSignupScreenBloc, SigninSignupScreenState>(
      builder: (context, state) {
        if (state is LoadingState) {
          _loading = true;
        } else if (state is ForgotPasswordState) {
          _loading = false;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            AlertMessage.showSuccess(state.data.message ?? "", context);
          });
        } else if (state is LoginState) {
          _loading = false;
          var model = state.data;

          WidgetsBinding.instance.addPostFrameCallback((_) {
            updateUserPreference(model);
            checkFingerprint();
            AlertMessage.showSuccess(model.message ?? "", context);
          });
          bloc?.add(const GetCustomerCartEvent());

          print("----===-->${state.data.customerToken}");
          print("bearrtoken=>>${model.bearerToken}");
        } else if (state is SigninSignupScreenError) {
          _loading = false;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            AlertMessage.showError(state.message ?? "", context);
          });
        }
        return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(
              children: <Widget>[
                _buildContent(),
                Visibility(
                  visible: _loading,
                  child: const Loader(),
                ),
              ],
            ));
      },
    );
  }

  Widget _buildContent() {
    return Stack(
      children: [
        const SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: FluxImage(
              imageUrl: "assets/images/login_bg.png",
              fit: BoxFit.cover,
            )),
        Scaffold(
          resizeToAvoidBottomInset: false,
          // i had to add this here, when i add here the image didnt move anymore by the keyboard

          backgroundColor: Colors.transparent,
          appBar: AppBar(backgroundColor: Colors.transparent),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 50),
                    const Center(
                      child: FluxImage(imageUrl: AppImages.loginLogo),
                    ),
                    const SizedBox(height: 44),
                    Text(
                      Utils.getStringValue(
                        context,
                        AppStringConstant.login,
                      ),
                      style: KTextStyle.of(context).bold32,
                    ),
                    const SizedBox(height: 27),

                    AppTextField(
                      controller: _emailController,
                      isRequired: true,
                      isPassword: false,
                      validationType: AppStringConstant.email,
                      inputType: TextInputType.emailAddress,
                      hintText: Utils.getStringValue(
                        context,
                        AppStringConstant.emailAddress,
                      ),
                    ),
                    const SizedBox(height: AppSizes.size24),
                    AppTextField(
                      controller: _passwordController,
                      isRequired: true,
                      isPassword: true,
                      validationType: AppStringConstant.password,
                      hintText: Utils.getStringValue(
                          context, AppStringConstant.password),
                    ),
                    const SizedBox(
                      height: AppSizes.size30,
                    ),

                    /** Forgot password **/
                    GestureDetector(
                      child: Text(
                        Utils.getStringValue(
                            context, AppStringConstant.forgotPassword),
                        style: KTextStyle.of(context)
                            .sixteen
                            .copyWith(color: const Color(0xffFF0000)),
                      ),
                      onTap: () {
                        DialogHelper.forgotPasswordDialog(
                          context,
                          AppLocalizations.of(context),
                          Utils.getStringValue(
                              context, AppStringConstant.forgotPasswordTitle),
                          Utils.getStringValue(
                              context, AppStringConstant.forgotPasswordMessage),
                          _emailController.text,
                          onConfirm: (email) {
                            bloc?.add(ForgotPasswordEvent(email));
                            bloc?.emit(LoadingState());
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 48),
                    SizedBox(
                      child: CustomButton(
                        onPressed: () {
                          _validateForm();
                        },
                        title: Utils.getStringValue(
                                context, AppStringConstant.signIn)
                            .toUpperCase(),
                      ),
                    ),
                    const SizedBox(height: AppSizes.size10),

                    /** Create account **/

                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                        create: (context) => SigninSignupScreenBloc(
                                            repository:
                                                SigninSignupScreenRepositoryImp()),
                                        child: CreateAnAccount(false),
                                      )));
                          // Navigator.pop(context);
                          // signInSignUpBottomModalSheet(context, true, false);
                        },
                        child: Text(
                          Utils.getStringValue(
                                  context, AppStringConstant.createAnAccount)
                              .toUpperCase(),
                          style: KTextStyle.of(context).boldSixteen,
                        ),
                      ),
                    ),

                    // appOutlinedButton(context, () {
                    //   Navigator.pop(context);
                    //   signInSignUpBottomModalSheet(context, true, false);
                    // },
                    //     Utils.getStringValue(
                    //             context, AppStringConstant.createAnAccount)
                    //         .toUpperCase()),
                    const SizedBox(height: AppSizes.size16),
                    if ((appStoragePref.getFingerPrintUser() ?? "").isNotEmpty)
                      Center(
                        child: InkWell(
                          child: Lottie.asset(
                            AppImages.fingerPrintLottie,
                            width: AppSizes.deviceWidth / 6,
                            height: AppSizes.deviceWidth / 6,
                            fit: BoxFit.fill,
                            repeat: true,
                          ),
                          onTap: () {
                            startAuthentication(false);
                          },
                        ),
                      )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  //==========Update Session==========//
  void updateUserPreference(LoginResponseModel model) {
    appStoragePref.setIsLoggedIn(true);
    appStoragePref.setCustomerToken(model.customerToken);
    appStoragePref.setBearerToken(model.bearerToken);
    appStoragePref.setQuoteId(0);

    appStoragePref.setUserData(UserDataModel(
        isEmailVerified: true,
        customerId: model.customerId,
        name: model.customerName,
        email: model.customerEmail,
        bannerImage: model.bannerImage,
        profileImage: model.profileImage,
        cartCount: model.cartCount));
  }

  /// ================Handle Fingerprint Login==============
  final LocalAuthentication auth = LocalAuthentication(); //----Initialization
  void checkFingerprint() {
    auth.isDeviceSupported().then((value) {
      debugPrint('isDeviceSupported: ${value}');
      if (value &&
          ((appStoragePref.getFingerPrintUser() ?? "").isEmpty ||
              (_emailController.text ?? "").toString() !=
                  (appStoragePref.getFingerPrintUser() ?? ""))) {
        showFingerprintDialog();
      } else {
        if (widget.isComingFromCartPage == true) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(AppRoutes.cart, (route) => false);
        } else {
          Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.bottomTabBar, (route) => false);
        }
        Navigator.of(context)
            .pushNamedAndRemoveUntil(AppRoutes.bottomTabBar, (route) => false);
      }
    });
  }

  void showFingerprintDialog() async {
    DialogHelper.forgotPasswordDialog(
        context,
        AppLocalizations.of(context),
        Utils.getStringValue(context, AppStringConstant.fingerprintLogin),
        Utils.getStringValue(context, AppStringConstant.fingerprintMessage),
        _emailController.text, onConfirm: (data) {
      startAuthentication(true);
    }, onCancel: (value) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(AppRoutes.bottomTabBar, (route) => false);
    }, isForgotPassword: false);
  }

  void startAuthentication(bool alreadyLogin) async {
    auth.isDeviceSupported().then((value) async {
      if (value) {
        bool didAuthenticate = await auth.authenticate(
            localizedReason: Utils.getStringValue(
                    context, AppStringConstant.fingerprintLogin) ??
                '');
        if (didAuthenticate) {
          if (alreadyLogin) {
            appStoragePref.setFingerPrintUser(_emailController.text);
            appStoragePref.setFingerPrintPassword(_passwordController.text);

            Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.bottomTabBar, (route) => false);
          } else {
            bloc?.add(LoginEvent(appStoragePref.getFingerPrintUser() ?? "",
                appStoragePref.getFingerPrintPassword() ?? ""));
            bloc?.emit(LoadingState());
          }
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            AlertMessage.showError(
                Utils.getStringValue(
                        context, AppStringConstant.authenticationFailed) ??
                    '',
                context);
          });
        }
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          AlertMessage.showError(
              Utils.getStringValue(
                      context, AppStringConstant.authenticationFailed) ??
                  '',
              context);
        });
      }
    });
  }
}

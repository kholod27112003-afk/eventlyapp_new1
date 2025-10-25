
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:eventlyapp_new/generated/l10n.dart';
import 'package:eventlyapp_new/home_screen/Tabs/widgets/custom_elevated_button.dart';
import 'package:eventlyapp_new/home_screen/Tabs/widgets/custom_textformfiled.dart';
import 'package:eventlyapp_new/providers/app_language.dart';
import 'package:eventlyapp_new/utils/app_assets.dart';
import 'package:eventlyapp_new/utils/app_colors.dart';
import 'package:eventlyapp_new/utils/app_routes.dart';
import 'package:eventlyapp_new/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formkey = GlobalKey<FormState>();

  bool isObscured = true;
  TextEditingController emailController =
  TextEditingController(text: "kholodali@gmail.com");
  TextEditingController passwordController =
  TextEditingController(text: "27112003");
  int? _getCurrentLanguageValue(String language) {
    switch (language) {
      case "en":
        return 0;
      case "ar":
        return 1;
      default:
        return null;
    }
  }

  String _getLanguageFromValue(int? value) {
    switch (value) {
      case 0:
        return "en";
      case 1:
        return "ar";
      default:
        return "en";
    }
  }

  @override
  Widget build(BuildContext context) {
    var hieght = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var languageProvider = Provider.of<AppLanguageProvider>(context);

    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(AppAssets.eventLogo),
                  SizedBox(
                    height: hieght * 0.03,
                  ),
                  Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomTextformfiled(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return "Please Enter Email";
                            }
                            final bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(text);
                            if (!emailValid) {
                              return "Please Enter Valid Email";
                            }
                            return null;
                          },
                          hintText: S.of(context).email,
                          prefixIcon: Icon(EvaIcons.email),
                        ),
                        SizedBox(
                          height: hieght * 0.02,
                        ),
                        CustomTextformfiled(
                          controller: passwordController,
                          isObscured: isObscured,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return "Please Enter Password";
                            }
                            return null;
                          },
                          hintText: S.of(context).password,
                          prefixIcon: Icon(Clarity.lock_solid),
                          suffixIcon: InkWell(
                              onTap: () {
                                isObscured = !isObscured;
                                setState(() {});
                              },
                              child: isObscured
                                  ? Icon(EvaIcons.eye_off)
                                  : Icon(EvaIcons.eye)),
                        ),
                        SizedBox(
                          height: hieght * 0.002,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                style: ButtonStyle(
                                  overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                                ),
                                onPressed: () {},
                                child: Text(
                                  "${S.of(context).forget_password}?",
                                  style: AppStyle.Bold16PrimaryItalicUL,
                                )),
                          ],
                        ),
                        SizedBox(
                          height: hieght * 0.02,
                        ),
                        CustomElevatedButton(
                          onPressed: login,
                          text: S.of(context).login,
                        ),
                        SizedBox(
                          height: hieght * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              S.of(context).dont_Have_account,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            TextButton(
                                style: ButtonStyle(
                                  overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                                ),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(AppRoutes.registerScreen);
                                },
                                child: Text(
                                  "${S.of(context).create_account}",
                                  style: AppStyle.Bold16PrimaryItalicUL,
                                )),
                          ],
                        ),
                        SizedBox(
                          height: hieght * 0.02,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                indent: width * 0.04,
                                endIndent: width * 0.04,
                                color: AppColor.primaryLightColor,
                                thickness: 1,
                              ),
                            ),
                            Text(
                              S.of(context).or,
                              style: AppStyle.medium16Primary,
                            ),
                            Expanded(
                              child: Divider(
                                indent: width * 0.04,
                                endIndent: width * 0.04,
                                color: AppColor.primaryLightColor,
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: hieght * 0.02,
                        ),
                        CustomElevatedButton(
                          backgroundColor: Colors.transparent,
                          onPressed: login,
                          text: S.of(context).login_with_google,
                          borderColor: AppColor.primaryLightColor,
                          textStyle: AppStyle.medium20Primary,
                          hasIcon: true,
                          mainAxisAlignment: MainAxisAlignment.center,
                          iconWidget: Image.asset(AppAssets.googlelogo),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: hieght * 0.02,
                  ),
                  AnimatedToggleSwitch<int?>.rolling(
                    iconOpacity: 100,
                    allowUnlistedValues: true,
                    styleAnimationType: AnimationType.onHover,
                    current: _getCurrentLanguageValue(languageProvider.appLanguage),
                    values: const [0, 1],
                    onChanged: (i) {
                      final newLanguage = _getLanguageFromValue(i);
                      languageProvider.changeLanguage(newLanguage);
                    },
                    iconBuilder: languageIconBuilder,
                    style: ToggleStyle(
                        backgroundColor: Colors.transparent,
                        borderColor: AppColor.primaryLightColor,
                        borderRadius: BorderRadius.circular(25),
                        indicatorColor: AppColor.primaryLightColor),
                    borderWidth: 3.0,
                  ),
                ],
              ),
            ),
          )),
    );
  }

  void login() {
    if (formkey.currentState?.validate() == true) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        AppRoutes.homescreen,
            (route) => false,
      );
    }
  }

  Widget languageIconBuilder(int? value, bool foreground) {
    return Container(
      child: Center(
        child: flagByValue(value),
      ),
    );
  }

  Widget iconBuilder(int value) {
    return languageIconBuilder(value, false);
  }

  Widget rollingIconBuilder(int? value, bool foreground) {
    return Container(
      child: Center(
        child: flagByValue(value),
      ),
    );
  }

  Color colorBuilder(int value) => switch (value) {
    0 => Colors.blueAccent,
    1 => Colors.red,
    _ => AppColor.primaryLightColor,
  };

  Widget flagByValue(int? value) => switch (value) {
    0 => Flag(
      Flags.united_states_of_america,
      size: 28,
    ),
    1 => Flag(
      Flags.egypt,
      size: 28,
    ),
    _ => Icon(
      Icons.language,
      size: 28,
      color: AppColor.primaryLightColor,
    ),
  };
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moliya_studyasi/common/widget/custom_textfield.dart';
import 'package:moliya_studyasi/common/widget/error_text.dart';
import 'package:moliya_studyasi/common/widget/text_and_button.dart';
import 'package:moliya_studyasi/feature/home_page/home_page.dart';
import 'package:moliya_studyasi/feature/login_page/login_bloc/login_bloc.dart';
import 'package:moliya_studyasi/feature/sign_up/sign_up.dart';

import '../../common/const/app_consts.dart';
import '../../common/style/app_colors.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _textController = TextEditingController();
  final _textFocusNode = FocusNode();
  final _passwordController = TextEditingController();
  final _passwordFocusNode = FocusNode();
  late ValueNotifier<bool> _focusState;

  @override
  void initState() {
    _focusState = ValueNotifier(false);
    _textFocusNode.addListener(() {
      _updateFocusState();
    });
    _passwordFocusNode.addListener(() {
      _updateFocusState();
    });
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    _textFocusNode.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    _focusState.dispose();

    super.dispose();
  }

  void _updateFocusState() {
    _focusState.value = _onTextFocusChange() || _onPasswordFocusChange();
  }

  bool _onTextFocusChange() => _textFocusNode.hasFocus;

  bool _onPasswordFocusChange() => _passwordFocusNode.hasFocus;

  final ValueNotifier<bool> _onTextInputError = ValueNotifier(false);

  final ValueNotifier<bool> _onPasswordInputError = ValueNotifier(false);

  final RegExp _employeeIdRegex = RegExp(r"^[A-Z][a-z0-9]*$");
  final RegExp _employeePasswordRegex = RegExp(r"[A-Za-z0-9]*$");

  void _onTextFieldIdError(String value) {
    _onTextInputError.value =
        !_employeeIdRegex.hasMatch(value) || !value.contains(RegExp(r'[0-9]'));
  }

  void _onTextFieldPasswordError(String value) {
    _onPasswordInputError.value = !_employeePasswordRegex.hasMatch(value) ||
        !value.contains(RegExp(r'[0-9]')) ||
        !value.contains(RegExp(r'[A-Z]'));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (_, state) {
        if (state is LoginSuccess) {
          print("success");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
        } else if (state is LoginProcess) {
          print("presses");
        } else if (state is LoginFailure) {
          print("LoginFailure");
        }
        // TODO: implement listener
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.backgroundImage2),
              fit: BoxFit.fill,
            ),
          ),
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 144.h),
                  ValueListenableBuilder(
                    valueListenable: _focusState,
                    builder: (context, focusState, child) {
                      if (!focusState) {
                        return Text(
                          AppTexts.davomat,
                          style: TextStyle(
                            color: AppColors.blackTextColor,
                            fontSize: 55.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  ValueListenableBuilder(
                    valueListenable: _focusState,
                    builder: (context, focusState, child) {
                      return SizedBox(height: focusState ? 0 : 19.h);
                    },
                  ),
                  Text(
                    AppTexts.akkauntgaKirish,
                    style: TextStyle(
                      color: AppColors.blackTextColor,
                      fontSize: 18.sp,
                    ),
                  ),
                  SizedBox(height: 35.h),
                  ValueListenableBuilder(
                    valueListenable: _onTextInputError,
                    builder: (context, value, child) {
                      return ErrorText(
                        error: "Noto'g'ri Id",
                        isVisible: value,
                      );
                    },
                  ),
                  CustomTextField(
                    regExp: _employeeIdRegex,
                    textCapitalization: TextCapitalization.words,
                    function: _onTextFieldIdError,
                    hintText: AppTexts.ishchiId,
                    controller: _textController,
                    icon: Icons.person_rounded,
                    focusNode: _textFocusNode,
                  ),
                  SizedBox(height: 41.h),
                  ValueListenableBuilder(
                      valueListenable: _onPasswordInputError,
                      builder: (context, value, child) {
                        return ErrorText(
                          error: "Noto'g'ri parol",
                          isVisible: value,
                        );
                      }),
                  CustomTextField(
                    regExp: _employeePasswordRegex,
                    textCapitalization: TextCapitalization.none,
                    function: _onTextFieldPasswordError,
                    hintText: AppTexts.parol,
                    controller: _passwordController,
                    icon: Icons.lock_rounded,
                    focusNode: _passwordFocusNode,
                  ),
                  SizedBox(height: 120.h),
                  TextAndButton(
                    text: AppTexts.kirish,
                    onTap: () {
                      context.read<LoginBloc>().add(
                            LogInRequired(
                              employeeId: _textController.text.trim(),
                              password: _passwordController.text.trim(),
                            ),
                          );
                    },
                    paddingFromRight: 45.w,
                    paddingFromMiddle: 14.w,
                  ),
                  SizedBox(height: 50.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppTexts.akkauntyoqmi,
                        style: TextStyle(
                          color: AppColors.blackTextColor,
                          fontSize: 15.sp,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUp(),
                            ),
                          );
                        },
                        child: Text(
                          AppTexts.yaratish,
                          style: TextStyle(
                            color: AppColors.blue,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.blue,
                            fontSize: 15.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

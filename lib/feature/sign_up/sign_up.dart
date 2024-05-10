import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moliya_studyasi/common/widget/custom_textfield.dart';
import 'package:moliya_studyasi/common/widget/error_text.dart';
import 'package:moliya_studyasi/common/widget/text_and_button.dart';
import 'package:moliya_studyasi/feature/sign_up/sign_up_bloc/sign_up_bloc.dart';
import 'package:moliya_studyasi/feature/sign_up/sign_up_repository/sign_up_repository.dart';

import '../../common/const/app_consts.dart';
import '../../common/style/app_colors.dart';
import '../home_page/home_page.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _nameController = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();

  final TextEditingController _surnameController = TextEditingController();
  final FocusNode _surnameFocusNode = FocusNode();

  final TextEditingController _idController = TextEditingController();
  final FocusNode _idFocusNode = FocusNode();

  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _passwordFocusNode = FocusNode();

  late final ValueNotifier<bool> _focusState;
  late final SignUpBloc bloc;

  @override
  void initState() {
    bloc = SignUpBloc(
      signUpRepository: SignUpRepository(),
    );

    _focusState = ValueNotifier(false);
    _nameFocusNode.addListener(() {
      _updateState();
    });
    _surnameFocusNode.addListener(() {
      _updateState();
    });
    _idFocusNode.addListener(() {
      _updateState();
    });
    _passwordFocusNode.addListener(() {
      _updateState();
    });
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nameFocusNode.dispose();

    _surnameController.dispose();
    _surnameFocusNode.dispose();

    _idController.dispose();
    _idFocusNode.dispose();

    _passwordController.dispose();
    _passwordFocusNode.dispose();

    bloc.close();

    super.dispose();
  }

  void _updateState() {
    _focusState.value = _nameFocusNode.hasFocus ||
        _surnameFocusNode.hasFocus ||
        _idFocusNode.hasFocus ||
        _passwordFocusNode.hasFocus;
  }

  final RegExp _regExpName = RegExp(r"[A-Za-z]*$");
  final RegExp _regExpSurname = RegExp(r"[A-Za-z]*$");
  final RegExp _regExpId = RegExp(r"^[A-Z][a-z0-9]*$");
  final RegExp _regExpPassword = RegExp(r"[A-Za-z0-9]*$");
  final ValueNotifier<bool> _onTextInputError = ValueNotifier(false);

  final ValueNotifier<bool> _onPasswordInputError = ValueNotifier(false);

  void _onTextFieldIdError(String value) {
    _onTextInputError.value =
        !_regExpId.hasMatch(value) || !value.contains(RegExp(r'[0-9]'));
  }

  void _onTextFieldPasswordError(String value) {
    _onPasswordInputError.value = !_regExpPassword.hasMatch(value) ||
        !value.contains(RegExp(r'[0-9]')) ||
        !value.contains(RegExp(r'[A-Z]'));
  }

  bool _prosses = false;

  void signUp() {
    bloc.add(
      SignUpRequired(
        employeeId: _idController.text.trim(),
        password: _passwordController.text.trim(),
        name: _nameController.text.trim(),
        surname: _surnameController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpBloc>.value(
      value: bloc,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.backgroundImage3),
              fit: BoxFit.fill,
            ),
          ),
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: SafeArea(
              child: ListView(
                children: [
                  SizedBox(height: 80.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        textScaler: TextScaler.noScaling,
                        AppTexts.akkauntYaratish,
                        style: TextStyle(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 42.h),
                  CustomTextField(
                    regExp: _regExpName,
                    textCapitalization: TextCapitalization.words,
                    function: (s) {},
                    controller: _nameController,
                    icon: Icons.person_rounded,
                    focusNode: _nameFocusNode,
                    hintText: AppTexts.ism,
                  ),
                  SizedBox(height: 42.h),
                  CustomTextField(
                    regExp: _regExpSurname,
                    textCapitalization: TextCapitalization.words,
                    function: (s) {},
                    controller: _surnameController,
                    icon: Icons.person_rounded,
                    focusNode: _surnameFocusNode,
                    hintText: AppTexts.familya,
                  ),
                  SizedBox(height: 42.h),
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
                    regExp: _regExpId,
                    textCapitalization: TextCapitalization.words,
                    function: _onTextFieldIdError,
                    controller: _idController,
                    icon: Icons.person_rounded,
                    focusNode: _idFocusNode,
                    hintText: AppTexts.ishchiId,
                  ),
                  SizedBox(height: 42.h),
                  ValueListenableBuilder(
                      valueListenable: _onPasswordInputError,
                      builder: (context, value, child) {
                        return ErrorText(
                          error: "Noto'g'ri parol",
                          isVisible: value,
                        );
                      }),
                  CustomTextField(
                    regExp: _regExpPassword,
                    textCapitalization: TextCapitalization.none,
                    function: _onTextFieldPasswordError,
                    controller: _passwordController,
                    icon: Icons.lock_rounded,
                    focusNode: _passwordFocusNode,
                    hintText: AppTexts.parol,
                  ),
                  SizedBox(height: 60.h),
                  BlocListener<SignUpBloc, SignUpState>(
                    bloc: bloc,
                    listener: (_, state) {
                      if (state is SignUpSuccessState) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      } else if (state is SignUpLoadingState) {
                        setState(() {
                          _prosses = true;
                        });
                      } else if (state is SignUpFailureState) {
                        setState(() {
                          _prosses = false;
                        });
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(seconds: 1),
                            content: Text("Xatolik yuzberdi"),
                          ),
                        );
                      }
                    },
                    child: TextAndButton(
                      icon: _prosses
                          ? SizedBox.square(
                        dimension: 25.sp,
                        child: CircularProgressIndicator(
                          color: AppColors.white,
                        ),
                      )
                          : Icon(
                        Icons.arrow_forward_rounded,
                        size: 26.sp,
                        color: AppColors.white,
                      ),
                      text: AppTexts.yaratish,
                      onTap: signUp,
                      paddingFromRight: 45.w,
                      paddingFromMiddle: 15.w,
                    ),
                  ),
                  SizedBox(height: 60.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppTexts.akkauntgaKirish,
                        style: TextStyle(
                          color: AppColors.blackTextColor,
                          fontSize: 15.sp,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          AppTexts.kirish,
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
                  SizedBox(
                    height: MediaQuery
                        .of(context)
                        .viewInsets
                        .bottom + 15.h,
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

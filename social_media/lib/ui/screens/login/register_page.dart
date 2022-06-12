import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:social_media/domain/blocs/blocs.dart';
import 'package:social_media/ui/helpers/helpers.dart';
import 'package:social_media/ui/screens/login/verify_email_page.dart';
import 'package:social_media/ui/themes/color_custom.dart';
import 'package:social_media/ui/widgets/widgets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController fullNameController;
  late TextEditingController userController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  final _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    fullNameController = TextEditingController();
    userController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    userController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final userBloc = BlocProvider.of<UserBloc>(context);

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is LoadingUserState) {
          modalLoading(context, 'Checking...');
        } else if (state is SuccessUserState) {
          Navigator.pop(context);
          modalSuccess(context, 'Registered successful!',
              onPressed: () => Navigator.push(
                  context,
                  routeSlide(
                      page: VerifyEmailPage(
                          email: emailController.text.trim()))));
        } else if (state is FailureUserState) {
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: SingleChildScrollView(
              child: Form(
                key: _keyForm,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextCustom(
                        text: 'Hello!',
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w500,
                        fontSize: 28.sp,
                        color: CustomColors.secundary),
                    SizedBox(height: 10.h),
                    TextCustom(
                      text: 'Create a new account.',
                      fontSize: 17.sp,
                      letterSpacing: 1.0,
                    ),
                    SizedBox(height: 40.h),
                    TextFieldCustom(
                      controller: fullNameController,
                      hintText: 'Full name',
                      validator:
                          RequiredValidator(errorText: 'Name is required'),
                    ),
                    SizedBox(height: 40.h),
                    TextFieldCustom(
                      controller: userController,
                      hintText: 'User',
                      validator:
                          RequiredValidator(errorText: 'User is required'),
                    ),
                    SizedBox(height: 40.h),
                    TextFieldCustom(
                      controller: emailController,
                      hintText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      validator: validatedEmail,
                    ),
                    SizedBox(height: 40.h),
                    TextFieldCustom(
                      controller: passwordController,
                      hintText: 'Password',
                      isPassword: true,
                      validator: passwordValidator,
                    ),
                    SizedBox(height: 60.h),
                    TextCustom(
                      text:
                          'By signing up, you agree to the terms of service and privacy policy.',
                      fontSize: 15.sp,
                      maxLines: 2,
                    ),
                    SizedBox(height: 20.h),
                    BtnCustom(
                        text: 'Register',
                        width: size.width,
                        onPressed: () {
                          if (_keyForm.currentState!.validate()) {
                            userBloc.add(OnRegisterUserEvent(
                                fullNameController.text.trim(),
                                userController.text.trim(),
                                emailController.text.trim(),
                                passwordController.text.trim()));
                          }
                        }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

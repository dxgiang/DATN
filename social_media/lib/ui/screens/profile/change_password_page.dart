import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:social_media/domain/blocs/blocs.dart';
import 'package:social_media/ui/helpers/helpers.dart';
import 'package:social_media/ui/screens/profile/widgets/text_form_profile.dart';
import 'package:social_media/ui/themes/color_custom.dart';
import 'package:social_media/ui/widgets/widgets.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  late TextEditingController _currentPasswordController;
  late TextEditingController _newPasswordController;
  late TextEditingController _newPasswordAgainController;
  final _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _currentPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _newPasswordAgainController = TextEditingController();
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _newPasswordAgainController.dispose();

    super.dispose();
  }

  void clear() {
    _currentPasswordController.clear();
    _newPasswordController.clear();
    _newPasswordAgainController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is LoadingUserState) {
          modalLoading(context, 'Updating password...');
        } else if (state is FailureUserState) {
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        } else if (state is SuccessUserState) {
          Navigator.pop(context);
          modalSuccess(context, 'Password has changed!', onPressed: () {
            clear();
            Navigator.pop(context);
          });
        }
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: TextCustom(text: 'Password', fontSize: 19.sp),
            elevation: 0,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colors.black),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    if (_keyForm.currentState!.validate()) {
                      userBloc.add(OnChangePasswordEvent(
                          _currentPasswordController.text.trim(),
                          _newPasswordAgainController.text.trim()));
                    }
                  },
                  child: TextCustom(
                      text: 'Save',
                      fontSize: 15.sp,
                      color: CustomColors.kPrimary))
            ],
          ),
          body: Form(
            key: _keyForm,
            child: SafeArea(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormProfile(
                      controller: _currentPasswordController,
                      labelText: 'Current password',
                      validator: MultiValidator([
                        MinLengthValidator(8,
                            errorText: 'Minimum 8 characters'),
                        RequiredValidator(
                            errorText: 'This field cannot be empty')
                      ]),
                    ),
                    SizedBox(height: 20.h),
                    TextFormProfile(
                      controller: _newPasswordController,
                      labelText: 'New Password',
                      validator: MultiValidator([
                        MinLengthValidator(8,
                            errorText: 'Minimum 8 characters'),
                        RequiredValidator(
                            errorText: 'This field cannot be empty')
                      ]),
                    ),
                    SizedBox(height: 20.h),
                    TextFormProfile(
                      controller: _newPasswordAgainController,
                      labelText: 'Retype password',
                      validator: MultiValidator([
                        MinLengthValidator(8,
                            errorText: 'Minimum 8 characters'),
                        RequiredValidator(
                            errorText: 'This field cannot be empty')
                      ]),
                    ),
                  ],
                ),
              ),
            )),
          )),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greencart_app/src/core/core.dart';
import 'package:greencart_app/src/features/authentication/domain/models/auth_payload.dart';
import 'package:greencart_app/src/features/authentication/presentation/controllers/auth_controller.dart';
import 'package:greencart_app/src/features/authentication/presentation/widgets/app_text_field.dart';
import 'package:greencart_app/src/shared/shared.dart';
import 'package:reactive_forms/reactive_forms.dart';

@RoutePage()
class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _form = FormGroup({
    'fullName': FormControl<String>(
      validators: [Validators.required, Validators.minLength(3)],
    ),
    'email': FormControl<String>(
      validators: [Validators.required, Validators.email],
    ),
    'password': FormControl<String>(
      validators: [Validators.required, Validators.minLength(6)],
    ),
  });
  @override
  Widget build(BuildContext context) {
    ref.listen(
      authControllerProvider,
      (_, state) => state.showLoadingDialog(context),
    );
    ref.listen(
      authControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    return AppScaffold(
      scrollable: false,
      useBackgroundImage: true,
      backgroundImage: GreenCartAssets.images.signUpScreenBg.provider(),
      body: ReactiveForm(
        formGroup: _form,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Create a New\n    Account",
              style: TextStyle(
                color: AppColors.white,
                fontSize: 34,
                fontWeight: FontWeight.w700,
              ),
            ),
            Sizes.p16.vGap,
            AppTextField(
              textFieldKey: const Key('fullName'),
              formControlName: 'fullName',
              hintText: 'Name',
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              validationMessages: {
                ValidationMessage.required: (error) => "Name can't be empty",
                ValidationMessage.minLength:
                    (error) =>
                        "Name must not be less than ${(error as Map)['requiredLength']} characters",
              },
              onSubmitted: (_) => _form.focus('email'),
            ),
            Sizes.p8.vGap,
            AppTextField(
              textFieldKey: const Key('email'),
              formControlName: 'email',
              hintText: 'Email',
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              validationMessages: {
                ValidationMessage.required: (error) => "Email can't be empty",
                ValidationMessage.email:
                    (error) => "Enter a valid email address",
              },
              onSubmitted: (_) => _form.focus('password'),
            ),
            Sizes.p8.vGap,
            AppTextField.secret(
              textFieldKey: const Key('password'),
              formControlName: 'password',
              hintText: 'Password',
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              validationMessages: {
                ValidationMessage.required:
                    (error) => "Password can't be empty",
                ValidationMessage.minLength:
                    (error) =>
                        "Password must not be less than ${(error as Map)['requiredLength']} characters",
              },
            ),
            Sizes.p16.vGap,
            ReactiveFormConsumer(
              builder:
                  (context, formGroup, child) => AppButton.large(
                    onPressed:
                        formGroup.valid
                            ? () => ref
                                .read(authControllerProvider.notifier)
                                .signUp(AuthPayload.fromJson(formGroup.value))
                            : null,
                    label: 'Create an account',
                  ),
            ),
            Sizes.p16.vGap,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already a member?",
                  style: TextStyle(
                    color: AppColors.white.withValues(alpha: 0.6),
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Sizes.p4.hGap,
                GestureDetector(
                  onTap:
                      () =>
                          ref
                              .read(authControllerProvider.notifier)
                              .goToSignInScreen(),
                  child: Text(
                    "Sign in",
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

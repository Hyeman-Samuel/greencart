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
class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _form = FormGroup({
    'email': FormControl<String>(
      validators: [Validators.required, Validators.email],
    ),
    'password': FormControl<String>(validators: [Validators.required]),
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
      backgroundImage: GreenCartAssets.images.signInScreenBg.provider(),
      body: ReactiveForm(
        formGroup: _form,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Sign in to Your\n      Account",
              style: TextStyle(
                color: AppColors.white,
                fontSize: 34,
                fontWeight: FontWeight.w700,
              ),
            ),
            Sizes.p16.vGap,
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
                                .signIn(AuthPayload.fromJson(formGroup.value))
                            : null,
                    label: 'Sign in',
                  ),
            ),
            Sizes.p16.vGap,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Not yet a member?",
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
                              .goToSignUpScreen(),
                  child: Text(
                    "Sign up",
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

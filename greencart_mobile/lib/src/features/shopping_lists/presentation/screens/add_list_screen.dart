import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greencart_app/src/config/config.dart';
import 'package:greencart_app/src/features/shopping_lists/presentation/controllers/add_list_controller.dart';
import 'package:greencart_app/src/shared/widgets/app_scaffold.dart';
import 'package:reactive_forms/reactive_forms.dart';

@RoutePage()
class AddListScreen extends StatefulWidget {
  const AddListScreen({super.key});

  @override
  State<AddListScreen> createState() => _AddListScreenState();
}

class _AddListScreenState extends State<AddListScreen> {
  final _form = FormGroup({
    'listName': FormControl<String>(
      validators: [Validators.required, Validators.minLength(3)],
    ),
  });
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      scrollable: false,
      body: ReactiveForm(
        formGroup: _form,
        child: Column(children: [_Header(), _Form()]),
      ),
    );
  }
}

class _Form extends StatelessWidget {
  const _Form();

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField(
      formControlName: 'listName',
      validationMessages: {
        ValidationMessage.required: (error) => "List name can't be empty",
        ValidationMessage.minLength:
            (error) =>
                "List name must not be less than ${(error as Map)['requiredLength']} characters",
      },
      showErrors: (control) => control.dirty,
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      decoration: InputDecoration(
        hintText: 'List name',
        hintStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: AppColors.black.withValues(alpha: 0.4),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.black.withValues(alpha: 0.4)),
          borderRadius: BorderRadius.circular(0),
        ),
      ),
      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
    );
  }
}

class _Header extends ConsumerWidget {
  const _Header();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(addListControllerProvider);
    return Padding(
      padding: Sizes.p12.vPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => context.router.popForced(true),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: AppColors.primary,
                  ),
                ),
              ),
              ReactiveFormConsumer(
                builder: (context, formGroup, child) {
                  return GestureDetector(
                    onTap:
                        formGroup.valid
                            ? () {
                              formGroup.unfocus();
                              ref
                                  .read(addListControllerProvider.notifier)
                                  .addList(
                                    title:
                                        formGroup.value['listName'] as String,
                                  );
                            }
                            : null,
                    child:
                        state.isLoading
                            ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator.adaptive(),
                            )
                            : Text(
                              'Save',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color:
                                    formGroup.valid
                                        ? AppColors.primary
                                        : AppColors.black.withValues(
                                          alpha: 0.4,
                                        ),
                              ),
                            ),
                  );
                },
              ),
            ],
          ),
          Sizes.p12.vGap,
          Text(
            'Add List',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

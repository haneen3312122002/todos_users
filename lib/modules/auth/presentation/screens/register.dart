import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';

import 'package:notes_tasks/core/shared/enums/role.dart';
import 'package:notes_tasks/core/shared/widgets/common/app_scaffold.dart';
import 'package:notes_tasks/core/shared/widgets/common/app_snackbar.dart';
import 'package:notes_tasks/core/shared/widgets/texts/app_text_link.dart';
import 'package:notes_tasks/core/shared/widgets/fields/custom_text_field.dart';
import 'package:notes_tasks/core/shared/widgets/buttons/primary_button.dart';
import 'package:notes_tasks/core/shared/constants/spacing.dart';
import 'package:notes_tasks/core/shared/widgets/fields/app_dropdown.dart';

import 'package:notes_tasks/modules/auth/domain/failures/auth_failure.dart';
import 'package:notes_tasks/modules/auth/presentation/viewmodels/firebase/register_viewmodel.dart';
import 'package:notes_tasks/modules/auth/presentation/providers/register_role_provider.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  late final ProviderSubscription _registerSub;

  final List<UserRole> _roles = const [
    UserRole.client,
    UserRole.freelancer,
  ];

  @override
  void initState() {
    super.initState();

    _registerSub = ref.listenManual(registerViewModelProvider, (prev, next) {
      next.whenOrNull(
        data: (_) {
          if (!mounted) return;
          context.go('/verify-email');
        },
        error: (e, _) {
          if (!mounted) return;
          final key =
              (e is AuthFailure) ? e.messageKey : 'something_went_wrong';
          AppSnackbar.show(context, key.tr());
        },
      );
    });
  }

  @override
  void dispose() {
    _registerSub.close();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final registerState = ref.watch(registerViewModelProvider);
    final registerNotifier = ref.read(registerViewModelProvider.notifier);

    final selectedRole = ref.watch(selectedRoleProvider);

    return AppScaffold(
      actions: const [],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppCustomTextField(
            controller: nameController,
            label: 'name'.tr(),
            inputAction: TextInputAction.next,
          ),
          SizedBox(height: AppSpacing.spaceMD),
          AppCustomTextField(
            controller: emailController,
            label: 'email'.tr(),
            inputAction: TextInputAction.next,
          ),
          SizedBox(height: AppSpacing.spaceMD),
          AppCustomTextField(
            controller: passwordController,
            label: 'password'.tr(),
            obscureText: true,
            inputAction: TextInputAction.done,
          ),
          SizedBox(height: AppSpacing.spaceMD),
          AppDropdown<UserRole>(
            label: 'role'.tr(),
            hint: 'select_your_role'.tr(),
            items: _roles,
            value: selectedRole,
            onChanged: (role) {
              ref.read(selectedRoleProvider.notifier).state = role;
            },
            itemLabelBuilder: (role) => role.labelKey.tr(),
            validator: (role) =>
                role == null ? 'please_select_role'.tr() : null,
          ),
          SizedBox(height: AppSpacing.spaceLG),
          AppPrimaryButton(
            label: 'register'.tr(),
            isLoading: registerState.isLoading,
            onPressed: () async {
              if (registerState.isLoading) return;

              final role = ref.read(selectedRoleProvider);
              if (role == null) {
                AppSnackbar.show(context, 'please_select_role'.tr());
                return;
              }

              await registerNotifier.register(
                name: nameController.text.trim(),
                email: emailController.text.trim(),
                password: passwordController.text.trim(),
                // ✅ هيك ما بتخربي شي: Firestore يستقبل String
                role: userRoleToString(role),
              );
            },
          ),
          SizedBox(height: AppSpacing.spaceLG),
          Center(
            child: AppTextLink(
              textKey: 'back_to_login',
              onPressed: () => context.pushReplacement('/login'),
            ),
          ),
          SizedBox(height: AppSpacing.spaceMD),
        ],
      ),
    );
  }
}

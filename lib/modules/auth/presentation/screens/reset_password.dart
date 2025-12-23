import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';

import 'package:notes_tasks/core/shared/widgets/common/app_scaffold.dart';
import 'package:notes_tasks/core/shared/widgets/common/app_snackbar.dart';
import 'package:notes_tasks/core/shared/widgets/fields/custom_text_field.dart';
import 'package:notes_tasks/core/shared/widgets/buttons/primary_button.dart';
import 'package:notes_tasks/core/shared/widgets/texts/app_text_link.dart';
import 'package:notes_tasks/core/shared/constants/spacing.dart';
import 'package:notes_tasks/modules/auth/domain/failures/auth_failure.dart';

import 'package:notes_tasks/modules/auth/presentation/viewmodels/firebase/reset_password_viewmodel.dart';

class ResetPasswordScreen extends ConsumerStatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  ConsumerState<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  final emailController = TextEditingController();
  late final ProviderSubscription _resetSub;
  @override
  void initState() {
    super.initState();
    _resetSub = ref.listenManual(resetPasswordViewModelProvider, (prev, next) {
      next.whenOrNull(data: (_) {
        if (!mounted) return;
        AppSnackbar.show(context, 'reset_email_sent'.tr());
      }, error: (e, _) {
        if (!mounted) return;
        final msg = (e is AuthFailure)
            ? e.messageKey.tr()
            : 'something_went_wrong'.tr();

        AppSnackbar.show(context, msg);
      });
    });
  }

  @override
  void dispose() {
    _resetSub.close();
    emailController.dispose();
    super.dispose();
  }

  void _onSendPressed() async {
    final state = ref.read(resetPasswordViewModelProvider);
    if (state.isLoading) return;
    await ref
        .read(resetPasswordViewModelProvider.notifier)
        .sendResetEmail(email: emailController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    final resetState = ref.watch(resetPasswordViewModelProvider);

    return AppScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'reset_password'.tr(),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: AppSpacing.spaceLG),
          AppCustomTextField(
            controller: emailController,
            label: 'email'.tr(),
            inputAction: TextInputAction.done,
            onSubmitted: (_) async => _onSendPressed(),
          ),
          SizedBox(height: AppSpacing.spaceLG),
          AppPrimaryButton(
              label: 'send_reset_link'.tr(),
              isLoading: resetState.isLoading,
              onPressed: () {
                _onSendPressed();
              }),
          SizedBox(height: AppSpacing.spaceLG),
          Center(
            child: AppTextLink(
              textKey: 'back_to_login',
              onPressed: () {
                context.pushReplacement('/login');
              },
            ),
          ),
          SizedBox(height: AppSpacing.spaceMD),
        ],
      ),
      actions: const [],
    );
  }
}

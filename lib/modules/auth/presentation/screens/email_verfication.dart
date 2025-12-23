import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';

import 'package:notes_tasks/core/shared/constants/spacing.dart';
import 'package:notes_tasks/core/data/remote/firebase/providers/firebase_providers.dart';
import 'package:notes_tasks/core/shared/widgets/buttons/app_icon_button.dart';
import 'package:notes_tasks/core/shared/widgets/common/app_scaffold.dart';
import 'package:notes_tasks/core/shared/widgets/texts/app_text_link.dart';
import 'package:notes_tasks/core/shared/widgets/common/error_view.dart';
import 'package:notes_tasks/core/shared/widgets/common/loading_indicator.dart';
import 'package:notes_tasks/core/shared/widgets/buttons/primary_button.dart';
import 'package:notes_tasks/core/shared/widgets/common/app_snackbar.dart';
import 'package:notes_tasks/core/features/auth/providers/email_verified_stream_provider.dart';

class VerifyEmailScreen extends ConsumerStatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  ConsumerState<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends ConsumerState<VerifyEmailScreen> {
  late final ProviderSubscription _verifiedSub;

  @override
  void initState() {
    super.initState();

    _verifiedSub = ref.listenManual(emailVerifiedStreamProvider, (prev, next) {
      next.whenOrNull(
        data: (isVerified) {
          if (!isVerified) return;
          if (!mounted) return;

          // ✅ الأفضل من push (ما بدنا نرجع لصفحة التحقق)
          context.go('/');
        },
        error: (_, __) {},
      );
    });
  }

  @override
  void dispose() {
    _verifiedSub.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final verifiedAsync = ref.watch(emailVerifiedStreamProvider);

    final auth = ref.read(firebaseAuthProvider); // read only data
    final authService = ref.read(authServiceProvider); // actions

    return AppScaffold(
      title: 'verify_email_title'.tr(),
      body: Center(
        child: verifiedAsync.when(
          data: (isVerified) {
            // ✅ ما في side effect هنا
            if (isVerified) return const SizedBox();

            final email = auth.currentUser?.email ?? '';
            return Padding(
              padding: EdgeInsets.all(AppSpacing.spaceLG),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AppIconButton(
                    icon: Icons.email_outlined,
                    onTap: null,
                    size: 64,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'verify_email_instructions'.tr(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    email,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 40),
                  AppPrimaryButton(
                    label: 'resend_verification_link'.tr(),
                    onPressed: () async {
                      try {
                        await authService.sendEmailVerification();
                        if (!mounted) return;
                        AppSnackbar.show(
                          context,
                          'verification_email_sent'.tr(),
                        );
                      } catch (e) {
                        // ✅ لا نعرض raw error للمستخدم
                        if (!mounted) return;
                        AppSnackbar.show(
                          context,
                          'verification_send_failed'.tr(),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  AppTextLink(
                    textKey: 'back_to_login',
                    onPressed: () async {
                      await authService.logout();
                      if (!mounted) return;
                      context.go('/login'); // ✅ go أفضل من pushReplacement هنا
                    },
                  ),
                ],
              ),
            );
          },
          loading: () => const LoadingIndicator(withBackground: false),
          error: (_, __) => ErrorView(
            message: 'something_went_wrong'.tr(),
            fullScreen: false,
            onRetry: () => ref.refresh(emailVerifiedStreamProvider),
          ),
        ),
      ),
      actions: const [],
    );
  }
}

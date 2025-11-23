import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_tasks/core/widgets/animation/fade_in.dart';
import 'package:notes_tasks/core/widgets/animation/slide_in.dart';
import 'package:notes_tasks/core/widgets/app_scaffold.dart';
import 'package:notes_tasks/core/widgets/app_text_link.dart';
import 'package:notes_tasks/core/widgets/custom_text_field.dart';
import 'package:notes_tasks/core/widgets/primary_button.dart';
import 'package:notes_tasks/core/widgets/loading_indicator.dart';
import 'package:notes_tasks/core/widgets/error_view.dart';
import 'package:notes_tasks/core/constants/spacing.dart';
import 'package:notes_tasks/modules/auth/presentation/viewmodels/firebase/login_firebase_viewmodel.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});
  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(firebaseLoginVMProvider);
    final loginNotifier = ref.read(firebaseLoginVMProvider.notifier);

    return AppScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //from up to down:
          FadeIn(
            child: SlideIn(
              from: const Offset(0, -20),
              child: AppCustomTextField(
                controller: emailController,
                label: 'email'.tr(),
                inputAction: TextInputAction.next,
              ),
            ),
          ),
          SizedBox(height: AppSpacing.spaceMD),
          FadeIn(
            delay: const Duration(milliseconds: 100),
            child: SlideIn(
              from: const Offset(0, -10),
              child: AppCustomTextField(
                controller: passwordController,
                label: 'password'.tr(),
                obscureText: true,
                inputAction: TextInputAction.done,
                onSubmitted: (_) async {
                  debugPrint('[UI] onSubmitted -> call VM');
                  await loginNotifier.login(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                  );
                },
              ),
            ),
          ),

          SizedBox(height: AppSpacing.spaceSM),
          FadeIn(
            delay: const Duration(milliseconds: 200),
            child: AppTextLink(
              textKey: 'forget password?',
              onPressed: () {
                context.push('/reset-pass');
              },
            ),
          ),
          SizedBox(height: AppSpacing.spaceLG),
          FadeIn(
            delay: const Duration(milliseconds: 250),
            child: AppPrimaryButton(
              label: 'login'.tr(),
              isLoading: loginState.isLoading,
              onPressed: () async {
                debugPrint('[UI] login button tapped -> call VM');
                await loginNotifier.login(
                  email: emailController.text.trim(),
                  password: passwordController.text.trim(),
                );
                debugPrint(
                  '[UI] after VM call, currentUser=${fb.FirebaseAuth.instance.currentUser?.uid}',
                );
              },
            ),
          ),
          SizedBox(height: AppSpacing.spaceLG),
          Center(
            child: AppTextLink(
              textKey: 'create_account',
              onPressed: () {
                context.pushReplacement('/register');
              },
            ),
          ),
          loginState.when(
            data: (user) {
              if (user == null) return const SizedBox();
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.pushReplacement('/');
              });
              return const SizedBox();
            },
            loading: () => const LoadingIndicator(withBackground: false),
            error: (e, _) {
              String msg = 'something_went_wrong'.tr();
              if (e is fb.FirebaseAuthException) {
                msg = '${e.code}: ${e.message ?? ''}';
              }
              return FadeIn(child: ErrorView(message: msg, fullScreen: false));
            },
          ),
        ],
      ),
      actions: const [],
    );
  }
}

//listener: if we want only to do side effects bassed on something(show: snackbar/dialog)
//state.when:if we will show UIs bassed on something(dtat,liading indecator/ error view/ empty view)
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_tasks/core/shared/widgets/animation/fade_in.dart';
import 'package:notes_tasks/core/shared/widgets/animation/slide_in.dart';
import 'package:notes_tasks/core/shared/widgets/common/app_scaffold.dart';
import 'package:notes_tasks/core/shared/widgets/common/app_snackbar.dart';
import 'package:notes_tasks/core/shared/widgets/texts/app_text_link.dart';
import 'package:notes_tasks/core/shared/widgets/fields/custom_text_field.dart';
import 'package:notes_tasks/core/shared/widgets/buttons/primary_button.dart';
import 'package:notes_tasks/core/shared/constants/spacing.dart';
import 'package:notes_tasks/modules/auth/domain/failures/auth_failure.dart';
import 'package:notes_tasks/modules/auth/presentation/viewmodels/firebase/login_firebase_viewmodel.dart';

// why no depends on firebase b user? -> no care about the user, only care about the success/ failure
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});
  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  late final ProviderSubscription _loginSub;

  @override
  void initState() {
    super.initState();

    _loginSub = ref.listenManual(firebaseLoginVMProvider, (prev, next) {
      //prev: prev provider state and next: the new state
      // ✅ listener = side effects
      next.whenOrNull(
        //no need for all:(data,error,loading)
        data: (_) {
          //if the page not on the screen:
          if (!mounted) return; //mounted: the widget still on the screen

          // أنظف مع go_router من pushReplacement
          context.go('/');
        },
        error: (e, _) {
          final key =
              (e is AuthFailure) ? e.messageKey : 'something_went_wrong';

          AppSnackbar.show(context, key.tr());
        },
      );
    });
  }

  @override
  void dispose() {
    _loginSub.close();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> submitLogin() async {
    final state = ref.read(firebaseLoginVMProvider);
    if (state.isLoading) return;

    FocusScope.of(context).unfocus();

    await ref.read(firebaseLoginVMProvider.notifier).login(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(firebaseLoginVMProvider);

    return AppScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
                onSubmitted: (_) => submitLogin(), // ✅ نفس المسار
              ),
            ),
          ),
          SizedBox(height: AppSpacing.spaceSM),
          FadeIn(
            delay: const Duration(milliseconds: 200),
            child: AppTextLink(
              textKey: 'forget password?',
              onPressed: () => context.push('/reset-pass'),
            ),
          ),
          SizedBox(height: AppSpacing.spaceLG),
          FadeIn(
            delay: const Duration(milliseconds: 250),
            child: AppPrimaryButton(
              label: 'login'.tr(),
              isLoading: loginState.isLoading, // ✅ UI فقط
              onPressed: submitLogin, // ✅ نفس المسار
            ),
          ),
          SizedBox(height: AppSpacing.spaceLG),
          Center(
            child: AppTextLink(
              textKey: 'create_account',
              onPressed: () => context.pushReplacement('/register'),
            ),
          ),
        ],
      ),
      actions: const [],
    );
  }
}

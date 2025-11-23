// lib/core/router/go_router_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_tasks/core/providers/firebase/auth/auth_state_provider.dart';
import 'package:notes_tasks/core/routs/app_routes.dart';
import 'package:notes_tasks/modules/auth/presentation/screens/login_screen.dart';
import 'package:notes_tasks/modules/auth/presentation/screens/email_verfication.dart';
import 'package:notes_tasks/core/widgets/app_navbar_container.dart';
import 'package:notes_tasks/core/widgets/loading_indicator.dart';
import 'package:notes_tasks/modules/auth/presentation/screens/register.dart';
import 'package:notes_tasks/modules/auth/presentation/screens/reset_password.dart';
import 'package:notes_tasks/modules/users/domain/entities/user_entity.dart';
import 'package:notes_tasks/modules/users/presentation/features/user_details/screens/user_section_details_view.dart';
import 'package:notes_tasks/modules/users/presentation/features/user_details/user_section_details_args.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final authAsync = ref.watch(authStateProvider);

  return GoRouter(
      // loading
      initialLocation: AppRoutes.loading,
      routes: [
        // Loading
        GoRoute(
          path: AppRoutes.loading,
          builder: (context, state) =>
              const LoadingIndicator(withBackground: true),
        ),

        // Login
        GoRoute(
          path: AppRoutes.login,
          builder: (context, state) => const LoginScreen(),
        ),

        // Verify email
        GoRoute(
          path: AppRoutes.verifyEmail,
          builder: (context, state) => const VerifyEmailScreen(),
        ),

        // Main app (AppNavBarContainer)
        GoRoute(
          path: AppRoutes.home,
          builder: (context, state) => const AppNavBarContainer(),
        ),

        // Reset password
        GoRoute(
          path: AppRoutes.resetPassword,
          builder: (context, state) => const ResetPasswordScreen(),
        ),

        // User section details
        GoRoute(
          path: AppRoutes.userSectionDetails,
          builder: (context, state) {
            final args = state.extra as UserSectionDetailsArgs;

            return UserSectionDetailsView<AddressEntity>(
              title: args.title,
              provider: args.provider,
              mapper: args.mapper,
            );
          },
        ),

        // Register
        GoRoute(
          path: AppRoutes.register,
          builder: (context, state) => const RegisterScreen(),
        ),
      ],
      redirect: (context, state) {
        final loc = state.fullPath ?? state.uri.toString();

        final isOnLoading = loc == AppRoutes.loading;
        final isOnLogin = loc == AppRoutes.login;
        final isOnRegister = loc == AppRoutes.register;
        final isOnResetPassword = loc == AppRoutes.resetPassword;
        final isOnVerifyEmail = loc == AppRoutes.verifyEmail;

        // 1) While auth is loading → always show loading
        if (authAsync.isLoading) {
          if (!isOnLoading) return AppRoutes.loading;
          return null;
        }

        // 2) Error in auth state → go to login
        if (authAsync.hasError) {
          if (!isOnLogin) return AppRoutes.login;
          return null;
        }

        final user = authAsync.value; // Firebase User?

        // 3) Not logged in:
        if (user == null) {
          // allow public auth routes:
          if (isOnLogin || isOnRegister || isOnResetPassword) {
            return null; // stay where you are
          }

          // any other route → redirect to login
          return AppRoutes.login;
        }

        // 4) Logged in but email *not* verified
        if (!user.emailVerified) {
          if (!isOnVerifyEmail) return AppRoutes.verifyEmail;
          return null;
        }

        // 5) Logged in + verified:
        // If user is still on auth screens → send to home
        if (isOnLogin || isOnRegister || isOnResetPassword || isOnLoading) {
          return AppRoutes.home;
        }

        // 6) Otherwise, stay where you are
        return null;
      });
});

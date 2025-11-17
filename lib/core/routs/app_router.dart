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
      // current location
      final loc = state.fullPath; // e.g. '/login', '/', ...

      final isOnLogin = loc == AppRoutes.login;
      final isOnVerifyEmail = loc == AppRoutes.verifyEmail;
      final isOnLoading = loc == AppRoutes.loading;

      // 1️ Loading state → always go to /loading
      if (authAsync.isLoading) {
        if (!isOnLoading) return AppRoutes.loading;
        return null;
      }

      // 2️ Error state → show login
      if (authAsync.hasError) {
        if (!isOnLogin) return AppRoutes.login;
        return null;
      }

      final user = authAsync.value; // User? from Firebase

      // 3️ Not logged in
      if (user == null) {
        if (!isOnLogin) return AppRoutes.login;
        return null;
      }

      // 4️ Logged in but email NOT verified
      if (!user.emailVerified) {
        if (!isOnVerifyEmail) return AppRoutes.verifyEmail;
        return null;
      }

      // 5️ Logged in + verified:
      if (isOnLogin || isOnVerifyEmail || isOnLoading) {
        return AppRoutes.home;
      }

      // otherwise, stay on current screen
      return null;
    },
  );
});

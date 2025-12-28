import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes_tasks/core/app/routs/app_router.dart';
import 'package:notes_tasks/core/data/remote/firebase/firebase_initializer.dart';

import 'package:notes_tasks/core/app/theme/app_theme.dart';
import 'package:notes_tasks/core/app/viewmodels/theme_viewmodel.dart';
import 'package:notes_tasks/core/shared/widgets/animation/fade_in.dart';
import 'package:notes_tasks/core/shared/widgets/animation/slide_in.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await AppFirebase.init();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'lib/core/l10n',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      child: const ProviderScope(child: MyApp()),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final router = ref.watch(goRouterProvider);

    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: router,
          title: 'Notes Tasks',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeMode,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          builder: (context, routerChild) {
            final child = routerChild ?? const SizedBox.shrink();

            return FadeIn(
              duration: const Duration(milliseconds: 250),
              child: SlideIn(
                from: const Offset(0, 20),
                duration: const Duration(milliseconds: 250),
                child: child,
              ),
            );
          },
        );
      },
    );
  }
}

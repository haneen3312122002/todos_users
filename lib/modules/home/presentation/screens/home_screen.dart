import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:notes_tasks/core/shared/constants/spacing.dart';
import 'package:notes_tasks/core/shared/enums/role.dart';
import 'package:notes_tasks/core/shared/widgets/common/app_scaffold.dart';
import 'package:notes_tasks/core/shared/widgets/common/empty_view.dart';
import 'package:notes_tasks/core/shared/widgets/common/error_view.dart';
import 'package:notes_tasks/core/shared/widgets/common/loading_indicator.dart';

import 'package:notes_tasks/modules/home/presentation/widgets/freelancer_home.dart';
import 'package:notes_tasks/modules/home/presentation/widgets/homeshell.dart';
import 'package:notes_tasks/modules/profile/presentation/providers/profile/get_profile_stream_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late final TextEditingController _search;

  @override
  void initState() {
    super.initState();
    _search = TextEditingController();
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(profileStreamProvider);

    return AppScaffold(
      extendBodyBehindAppBar: false,
      useSafearea: false,
      body: profileAsync.when(
        data: (profile) {
          if (profile == null) {
            return Padding(
              padding: EdgeInsets.all(AppSpacing.spaceMD),
              child: const EmptyView(),
            );
          }

          final subtitle = 'hello_name'.tr(namedArgs: {'name': profile.name});

          switch (profile.role) {
            case UserRole.client:
              return HomeShell(
                title: 'home_client_title'.tr(),
                subtitle: subtitle,
                showSearch: true,
                searchController: _search,
                searchHint: 'search'.tr(),
                padChild: true,
                child: Text(
                  'profile_client_ok'.tr(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              );

            case UserRole.admin:
              return HomeShell(
                title: 'home_admin_title'.tr(),
                subtitle: subtitle,
                showSearch: false,
                searchController: null,
                padChild: true,
                child: Text(
                  'profile_admin_ok'.tr(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              );

            case UserRole.freelancer:
              return HomeShell(
                title: 'home_freelancer_title'.tr(),
                subtitle: subtitle,
                showSearch: true,
                searchController: _search,
                searchHint: 'search'.tr(),
                padChild: false,
                child: const FreelancerHome(),
              );

            default:
              return HomeShell(
                title: 'home_title'.tr(),
                subtitle: subtitle,
                showSearch: false,
                searchController: null,
                padChild: true,
                child: const EmptyView(),
              );
          }
        },
        loading: () => HomeShell(
          title: 'home_title'.tr(),
          subtitle: 'hello'.tr(),
          showSearch: false,
          searchController: null,
          padChild: true,
          child: const LoadingIndicator(withBackground: false),
        ),
        error: (_, __) => HomeShell(
          title: 'home_title'.tr(),
          subtitle: 'hello'.tr(),
          showSearch: false,
          searchController: null,
          padChild: true,
          child: ErrorView(
            message: 'something_went_wrong'.tr(),
            fullScreen: false,
            onRetry: () => ref.refresh(profileStreamProvider),
          ),
        ),
      ),
    );
  }
}

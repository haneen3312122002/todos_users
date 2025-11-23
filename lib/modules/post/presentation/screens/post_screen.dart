import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:notes_tasks/core/widgets/app_infinite_list.dart';
import 'package:notes_tasks/core/widgets/app_scaffold.dart';
import 'package:notes_tasks/core/widgets/empty_view.dart';
import 'package:notes_tasks/core/widgets/error_view.dart';
import 'package:notes_tasks/core/widgets/loading_indicator.dart';
import 'package:notes_tasks/core/widgets/app_card.dart';
import 'package:notes_tasks/core/widgets/app_list_tile.dart';
import 'package:notes_tasks/modules/post/domain/entities/post_entity.dart';
import 'package:notes_tasks/modules/post/presentation/viewmodels/get_all_posts_viewmodel.dart';

class PostListScreen extends ConsumerWidget {
  const PostListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsState = ref.watch(getAllPostsViewModelProvider);
    final vm = ref.read(getAllPostsViewModelProvider.notifier);

    return AppScaffold(
      showLogout: true,
      scrollable: false,
      title: 'posts_title'.tr(),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: vm.refreshPosts,
        ),
      ],
      body: postsState.when(
        data: (List<PostEntity> posts) {
          if (posts.isEmpty) {
            return EmptyView(message: 'no_posts'.tr());
          }

          final hasMore = vm.hasMore;

          return AppInfiniteList<PostEntity>(
            items: posts,
            hasMore: hasMore,
            onRefresh: vm.refreshPosts,
            onLoadMore: vm.loadNextPage,
            itemBuilder: (context, post, index) {
              return AppCard(
                child: AppListTile(
                  title: post.title,
                  subtitle: post.body,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.remove_red_eye, size: 18),
                      const SizedBox(width: 4),
                      Text(post.views.toString()),
                    ],
                  ),
                  onTap: () {},
                ),
              );
            },
          );
        },
        loading: () => const LoadingIndicator(withBackground: false),
        error: (error, _) => ErrorView(
          message: 'failed_load_posts'.tr(),
          onRetry: vm.refreshPosts,
        ),
      ),
    );
  }
}

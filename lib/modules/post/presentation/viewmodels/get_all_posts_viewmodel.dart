import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_tasks/modules/post/domain/entities/post_entity.dart';
import 'package:notes_tasks/modules/post/domain/usecases/get_all_tasks_usecase.dart';
import 'package:notes_tasks/modules/post/presentation/providers/get_all_posts_provider.dart';

final getAllPostsViewModelProvider =
    AsyncNotifierProvider<GetAllPostsViewModel, List<PostEntity>>(
  GetAllPostsViewModel.new,
);

class GetAllPostsViewModel extends AsyncNotifier<List<PostEntity>> {
  late final GetAllPostsUseCase _getAllPostsUseCase =
      ref.read(getAllPostsUseCaseProvider);

  int _currentPage = 1;
  final int _limit = 10; //10 posts
  bool _hasMore = true;
  bool _isLoadingMore = false;

  bool get hasMore => _hasMore;
  bool get isLoadingMore => _isLoadingMore;
  int get currentPage => _currentPage;

  @override
  FutureOr<List<PostEntity>> build() async {
    return await _loadFirstPage();
  }

  Future<List<PostEntity>> _loadFirstPage() async {
    _currentPage = 1;
    _hasMore = true;

    try {
      final posts = await _getAllPostsUseCase(
        page: _currentPage,
        limit: _limit,
      );
      if (posts.length < _limit) {
        //no more pages
        _hasMore = false;
      }
      return posts;
    } catch (e, st) {
      state = AsyncError(e, st);
      return [];
    }
  }

  Future<void> refreshPosts() async {
    state = const AsyncLoading();
    final posts = await _loadFirstPage();
    state = AsyncData(posts);
  }

  Future<void> loadNextPage() async {
    if (!_hasMore || _isLoadingMore) return;

    _isLoadingMore = true;

    try {
      _currentPage++;
      final newPosts = await _getAllPostsUseCase(
        page: _currentPage,
        limit: _limit,
      );

      if (newPosts.isEmpty || newPosts.length < _limit) {
        _hasMore = false;
      }

      final current = state.value ?? [];
      state = AsyncData([...current, ...newPosts]);
    } catch (e, st) {
      _currentPage--;
      state = AsyncError(e, st);
    } finally {
      _isLoadingMore = false;
    }
  }
}

import 'package:flutter/material.dart';
import '../animation/fade_in.dart';
import '../animation/slide_in.dart';

class AppInfiniteList<T> extends StatefulWidget {
  final List<T> items;


  final Widget Function(BuildContext context, T item, int index) itemBuilder;


  final Future<void> Function() onRefresh;


  final VoidCallback onLoadMore;


  final bool hasMore;


  final EdgeInsetsGeometry padding;


  final double loadMoreThreshold;


  final bool animateItems;
  final Duration itemAnimationDuration;
  final int itemStaggerMs;

  const AppInfiniteList({
    super.key,
    required this.items,
    required this.itemBuilder,
    required this.onRefresh,
    required this.onLoadMore,
    required this.hasMore,
    this.padding = const EdgeInsets.symmetric(vertical: 8),
    this.loadMoreThreshold = 200,
    this.animateItems = false,
    this.itemAnimationDuration = const Duration(milliseconds: 250),
    this.itemStaggerMs = 40,
  });

  @override
  State<AppInfiniteList<T>> createState() => _AppInfiniteListState<T>();
}

class _AppInfiniteListState<T> extends State<AppInfiniteList<T>> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()..addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (maxScroll - currentScroll <= widget.loadMoreThreshold &&
        widget.hasMore) {
      widget.onLoadMore();
    }
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final showLoaderItem = widget.hasMore;
    final itemCount = widget.items.length + (showLoaderItem ? 1 : 0);

    return RefreshIndicator(
      onRefresh: widget.onRefresh,
      child: ListView.builder(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: widget.padding,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          final isLoaderItem = showLoaderItem && index == itemCount - 1;
          if (isLoaderItem) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          final item = widget.items[index];
          Widget row = widget.itemBuilder(context, item, index);

          if (!widget.animateItems) return row;

          return FadeIn(
            duration: widget.itemAnimationDuration,
            delay: Duration(milliseconds: widget.itemStaggerMs * index),
            child: SlideIn(
              from: const Offset(0, 10),
              duration: widget.itemAnimationDuration,
              child: row,
            ),
          );
        },
      ),
    );
  }
}
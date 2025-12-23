import 'package:flutter/material.dart';

typedef OnItemTap<T> = void Function(T item);
typedef OnDeleteTap<T> = void Function(T item);
typedef ItemTitle<T> = String Function(T item);
typedef ItemSubtitle<T> = String Function(T item);

class BasicListView<T> extends StatelessWidget {
  final List<T> items;
  final ItemTitle<T> itemTitle;
  final ItemSubtitle<T>? itemSubtitle;
  final OnItemTap<T>? onItemTap;
  final OnDeleteTap<T>? onDeleteTap;

  const BasicListView({
    super.key,
    required this.items,
    required this.itemTitle,
    this.itemSubtitle,
    this.onItemTap,
    this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Center(child: Text("no items found"));
    }

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          title: Text(itemTitle(item)),
          subtitle: itemSubtitle != null ? Text(itemSubtitle!(item)) : null,
          onTap: () => onItemTap?.call(item),
          trailing: onDeleteTap != null
              ? IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => onDeleteTap!(item),
                )
              : null,
        );
      },
    );
  }
}

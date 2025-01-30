import 'package:flutter/material.dart';

typedef ItemWidgetBuilder<T> = Widget Function(
  BuildContext context,
  T item,
  int index,
);

/// If you need separators conditionally, you can return `null`,
/// or you can define a more complex type of function here.
typedef SeparatorWidgetBuilder<T> = Widget? Function(
  BuildContext context,
  T item,
  int index,
);

class CalendarGrid<T> extends StatelessWidget {
  /// The data items to be displayed in the grid.
  final List<T> items;

  /// How many items to display per row.
  final int itemsPerRow;

  /// Called to build each item in the grid.
  final ItemWidgetBuilder<T> itemBuilder;

  /// Called to build a separator between items, optional.
  final SeparatorWidgetBuilder<T>? separatorBuilder;

  /// If you want more control over scroll behavior or other aspects,
  /// you can expose them as well.
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry padding;

  /// Additional parameters you might want: spacing, alignment, etc.
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double childAspectRatio;

  const CalendarGrid({
    required this.items,
    required this.itemsPerRow,
    required this.itemBuilder,
    this.separatorBuilder,
    this.shrinkWrap = false,
    this.physics,
    this.padding = EdgeInsets.zero,
    this.mainAxisSpacing = 0,
    this.crossAxisSpacing = 0,
    this.childAspectRatio = 1.0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: shrinkWrap,
      physics: physics,
      padding: padding,
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: itemsPerRow,
        mainAxisSpacing: mainAxisSpacing,
        crossAxisSpacing: crossAxisSpacing,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) {
        final item = items[index];

        // Build the main item
        final itemWidget = itemBuilder(context, item, index);

        // If we have no separatorBuilder, just return the item.
        if (separatorBuilder == null) {
          return itemWidget;
        }

        // Otherwise, see if we need to build a separator for this item.
        // For example, you might only want to place a separator
        // on the right or bottom side. This is flexible.
        final separatorWidget = separatorBuilder!(context, item, index);

        // If no separator, return the item as is.
        if (separatorWidget == null) {
          return itemWidget;
        }

        // If you do have a separator, you can stack them or place them in a Column/Row, etc.
        return Stack(
          children: [
            itemWidget,
            Positioned.fill(child: separatorWidget),
          ],
        );
      },
    );
  }
}

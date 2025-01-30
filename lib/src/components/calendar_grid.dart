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

class CalendarGrid<T> extends StatefulWidget {
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
    this.scrollToIndex,
    super.key,
  });

  /// The data items to be displayed in the grid.
  final List<T> items;

  /// How many items per row (e.g. 3 for years/months, 7 for days).
  final int itemsPerRow;

  /// Builds each grid item.
  final ItemWidgetBuilder<T> itemBuilder;

  /// Optionally builds a separator overlay. (Omitted for brevity here.)
  final IndexedWidgetBuilder? separatorBuilder;

  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry padding;
  final double mainAxisSpacing;
  final double crossAxisSpacing;

  /// width : height ratio = `childAspectRatio : 1`
  /// If = 3.0, it means itemWidth / itemHeight = 3 => itemHeight = itemWidth / 3
  final double childAspectRatio;

  /// The index you want to scroll to on first build, if any.
  /// For example, if you want to jump to the selected year's index.
  final int? scrollToIndex;

  @override
  State<CalendarGrid<T>> createState() => _CalendarGridState<T>();
}

class _CalendarGridState<T> extends State<CalendarGrid<T>> {
  late final ScrollController _scrollController;
  bool _didScrollInitially = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        // Once the layout constraints are known, we can compute the offset
        // in a post frame callback.
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _jumpToInitialIndexIfNeeded(constraints);
        });

        return GridView.builder(
          controller: _scrollController,
          shrinkWrap: widget.shrinkWrap,
          physics: widget.physics,
          padding: widget.padding,
          itemCount: widget.items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: widget.itemsPerRow,
            mainAxisSpacing: widget.mainAxisSpacing,
            crossAxisSpacing: widget.crossAxisSpacing,
            childAspectRatio: widget.childAspectRatio,
          ),
          itemBuilder: (context, index) {
            final item = widget.items[index];
            return widget.itemBuilder(context, item, index);
          },
        );
      },
    );
  }

  void _jumpToInitialIndexIfNeeded(BoxConstraints constraints) {
    if (_didScrollInitially) return;
    _didScrollInitially = true; // so we only do it once

    final targetIndex = widget.scrollToIndex;
    if (targetIndex == null) return; // no scroll requested

    // 1) Compute which row the target index is on.
    final rowIndex = targetIndex ~/ widget.itemsPerRow;

    // 2) Calculate each cell's width and height.
    final horizontalPadding =
        widget.padding.resolve(TextDirection.rtl).horizontal;
    final usableWidth = constraints.maxWidth - horizontalPadding;
    final totalCrossSpacing =
        widget.crossAxisSpacing * (widget.itemsPerRow - 1);

    // The 'childAspectRatio' = (itemWidth / itemHeight).
    // => itemHeight = itemWidth / childAspectRatio
    final itemWidth = (usableWidth - totalCrossSpacing) / widget.itemsPerRow;
    final itemHeight = itemWidth / widget.childAspectRatio;

    // 3) The offset is rowIndex * (itemHeight + mainAxisSpacing).
    final offset = rowIndex * (itemHeight + widget.mainAxisSpacing);

    // 4) Jump or animate.
    _scrollController.animateTo(
      offset.clamp(0, _scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 800),
      curve: Easing.linear,
    );
  }
}

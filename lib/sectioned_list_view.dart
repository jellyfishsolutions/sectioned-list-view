library sectioned_list_view;
import 'package:flutter/material.dart';
import 'package:flutter_widgets/flutter_widgets.dart';

class SectionedListView extends StatelessWidget {
  SectionedListView(
      {Key key,
      this.numberOfSection,
      this.numberOfRowsInSection,
      this.headerBuilder,
      this.itemBuilder,
      this.itemScrollController,
      this.itemPositionsListener})
      : super(key: key);

  final int Function() numberOfSection;
  final int Function(int section) numberOfRowsInSection;
  final Widget Function(BuildContext context, int section) headerBuilder;
  final Widget Function(BuildContext context, int section, int index)
      itemBuilder;

  final ItemScrollController itemScrollController;
  final ItemPositionsListener itemPositionsListener;

  int _calculateListSize() {
    int sections = numberOfSection();
    int size = 0;
    for (int i = 0; i < sections; i++) {
      size += numberOfRowsInSection(i);
    }
    return size + sections;
  }

  Widget _buildItem(BuildContext context, int index) {
    if (index == 0) {
      return headerBuilder(context, 0);
    }

    index -= 1;
    int current = 0;
    int groupIndex = 0;
    int internalIndex = 0;
    while (current < index) {
      if (internalIndex == numberOfRowsInSection(groupIndex)) {
        groupIndex++;
        internalIndex = 0;
      } else {
        internalIndex++;
      }
      current++;
    }
    if (internalIndex == numberOfRowsInSection(groupIndex)) {
      return headerBuilder(context, groupIndex + 1);
    }

    return itemBuilder(context, groupIndex, internalIndex);
  }

  @override
  Widget build(BuildContext context) {
    return ScrollablePositionedList.builder(
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: _calculateListSize(),
        itemBuilder: (BuildContext context, int index) =>
            _buildItem(context, index),
        itemScrollController: itemScrollController,
        itemPositionsListener: itemPositionsListener,
    );
  }
}

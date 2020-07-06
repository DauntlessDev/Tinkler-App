import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'empty_content.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class ListItemBuilder<T> extends StatelessWidget {
  const ListItemBuilder(
      {@required this.model,
      @required this.itemBuilder,
      @required this.divider,
      @required this.items});

  // final StreamViewModel model;
  final ItemWidgetBuilder<T> itemBuilder;
  final Divider divider;

  //TODO: to be removed and replaced by the commented property above
  final BaseViewModel model;
  final List<T> items;

  @override
  Widget build(BuildContext context) {
    if (!model.isBusy) {
      return _buildList(items);
      // if (model.data != null) {
      //   // final List<T> items = model.data;
      //   if (items.isNotEmpty) {
      //     return _buildList(items);
      //   }
      //   return EmptyContent();
      // } else if (model.hasError) {
      //   return EmptyContent(
      //     title: 'Loading Error',
      //     message: 'Something has gone wrong',
      //   );
      // }
    }
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildList(List<T> items) {
    return ListView.separated(
        itemBuilder: (context, index) {
          if (index == 0 || index == items.length + 1) {
            return Container();
          }
          return itemBuilder(context, items[index - 1]);
        },
        itemCount: items.length + 2,
        separatorBuilder: (BuildContext context, int index) => divider);
  }
}

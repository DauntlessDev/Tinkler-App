import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tinkler/ui/shared/empty_content.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class ListItemBuilder<T> extends StatelessWidget {
  const ListItemBuilder(
      {@required this.model, @required this.itemBuilder, @required this.items});

  final StreamViewModel model;
  final ItemWidgetBuilder<T> itemBuilder;

  final List<T> items;

  @override
  Widget build(BuildContext context) {
    if (model != null) {
      if (!model.isBusy) {
        if (model.data != null) {
          final List<T> items = model.data;
          if (items.isNotEmpty) {
            return _buildList(items);
          }
          return EmptyContent();
        } else if (model.hasError ?? false) {
          return EmptyContent(
            title: 'Loading Error',
            message: 'Something has gone wrong',
          );
        }
      }
    }
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildList(List<T> items) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return itemBuilder(context, items[index]);
      },
      itemCount: items.length,
    );
  }
}

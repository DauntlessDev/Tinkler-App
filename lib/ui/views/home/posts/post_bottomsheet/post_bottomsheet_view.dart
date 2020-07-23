//view class
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:stacked/stacked.dart';

import 'post_bottomsheet_viewmodel.dart';

class PostBottomsheetView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PostBottomsheetViewModel>.nonReactive(
      builder: (context, model, child) => Container(
        color: Theme.of(context).backgroundColor,
        height: 350,
        width: double.maxFinite,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('Create Post'),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter status',
                    fillColor: Theme.of(context).colorScheme.onSurface,
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => PostBottomsheetViewModel(),
    );
  }
}

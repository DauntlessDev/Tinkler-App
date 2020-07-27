import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tinkler/ui/views/shared/fullpicture/fullpicture_viewmodel.dart';

class FullPictureView extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      ViewModelBuilder<FullPictureViewModel>.reactive(
        viewModelBuilder: () => FullPictureViewModel(),
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
              title: Text('Picture'),
              backgroundColor:
                  Theme.of(context).backgroundColor.withOpacity(0.3)),
          body: SafeArea(
            child: Container(
              height: double.maxFinite,
              width: double.maxFinite,
              child: Image(image: NetworkImage(model.imageUrl)),
            ),
          ),
        ),
      );
}

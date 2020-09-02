import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tinkler/ui/views/shared/fullpicture/fullpicture_viewmodel.dart';
import 'package:tinkler/ui/widgets/independent_scale.dart';

class FullPictureView extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      ViewModelBuilder<FullPictureViewModel>.reactive(
        viewModelBuilder: () => FullPictureViewModel(),
        builder: (context, model, child) => IndependentScale(
          child: Scaffold(
            appBar: AppBar(title: Text('Picture')),
            body: SafeArea(
              child: Container(
                height: double.maxFinite,
                width: double.maxFinite,
                child: Image(image: CachedNetworkImageProvider(model.imageUrl)),
              ),
            ),
          ),
        ),
      );
}

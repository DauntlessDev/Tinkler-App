//view class
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:stacked/stacked.dart';

import 'post_bottomsheet_viewmodel.dart';

class PostBottomsheetView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PostBottomsheetViewModel>.reactive(
      builder: (context, model, child) => ModalProgressHUD(
        inAsyncCall: model.isBusy,
        child: Container(
          height: 280,
          color: Theme.of(context).backgroundColor,
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
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextField(
                            minLines: 5,
                            maxLines: 5,
                            onChanged: model.setInput,
                            decoration: InputDecoration(
                              hintText: 'Enter status',
                              fillColor:
                                  Theme.of(context).colorScheme.onSurface,
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                        SizedBox(width: 15),
                        if (model.imagePath.isNotEmpty)
                          Expanded(
                            flex: 1,
                            child: Image(
                              image: FileImage(File(model.imagePath)),
                              fit: BoxFit.cover,
                              height: 80,
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () async {
                          await model.addImage();
                        },
                        child: Icon(MdiIcons.imagePlus, size: 30),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          color: Theme.of(context).primaryColor,
                          child: FlatButton(
                            onPressed: () async {
                              await model.proceedPost();
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Post',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 6),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          color: Theme.of(context).colorScheme.onSurface,
                          child: FlatButton(
                            onPressed: () {
                              model.fileReset();
                              Navigator.pop(context);
                            },
                            child: Text('Cancel'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      viewModelBuilder: () => PostBottomsheetViewModel(),
    );
  }
}

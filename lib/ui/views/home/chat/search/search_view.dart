import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:stacked/stacked.dart';
import 'package:tinkler/model/profile.dart';
import 'package:tinkler/ui/shared/list_item_builder.dart';
import 'package:tinkler/ui/widgets/avatar.dart';

import 'search_viewmodel.dart';

class SearchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchViewModel>.reactive(
      viewModelBuilder: () => SearchViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: TextField(
            onChanged: model.filterSearch,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        body: ModalProgressHUD(inAsyncCall: model.isBusy,
        child: SearchTileList()),
      ),
    );
  }
}

class SearchTileList extends ViewModelWidget<SearchViewModel> {
  const SearchTileList({
    Key key,
  }) : super(key: key, reactive: true);

  @override
  Widget build(BuildContext context, SearchViewModel model) {
    return ListItemBuilder(
      itemBuilder: (BuildContext context, profile) =>
          SearchTile(profile: profile),
      // items: model.listOfUsers,
      model: model,
      divider: Divider(),
    );
  }
}

class SearchTile extends StatelessWidget {
  const SearchTile({
    Key key,
    @required this.profile,
  }) : super(key: key);

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Avatar(photoUrl: profile.photoUrl, radius: 30),
      title: Text(profile.displayName),
    );
  }
}

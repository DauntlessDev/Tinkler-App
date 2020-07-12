import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:stacked/stacked.dart';
import 'package:tinkler/model/profile.dart';
import 'package:tinkler/ui/shared/empty_content.dart';
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
            decoration: InputDecoration(hintText: 'Enter name'),
            onChanged: model.setInput,
            onEditingComplete: model.searchUsers,
          ),
          actions: <Widget>[
            FlatButton(
              // padding: EdgeInsets.only(left: 20),
              onPressed: model.searchUsers,
              child: Icon(
                Icons.search,
              ),
            )
          ],
        ),
        body: ModalProgressHUD(
          inAsyncCall: model.isBusy,
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SearchTileList(),
          ),
        ),
      ),
    );
  }
}

class SearchTileList extends ViewModelWidget<SearchViewModel> {
  SearchTileList({
    Key key,
  }) : super(key: key, reactive: true);

  @override
  Widget build(BuildContext context, SearchViewModel model) {
    if (model.listOfUsers == null) return Container();
    if (model.listOfUsers.isEmpty)
      return EmptyContent(
          title: 'Empty Result', message: 'The name entered is not found.');

    return ListView.builder(
      itemBuilder: (context, index) =>
          SearchTile(profile: model.listOfUsers[index]),
      itemCount: model.listOfUsers.length,
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

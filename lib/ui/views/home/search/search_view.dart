//view class
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:stacked/stacked.dart';
import 'package:tinkler/model/profile.dart';
import 'package:tinkler/ui/shared/empty_content.dart';
import 'package:tinkler/ui/views/home/search/search_viewmodel.dart';
import 'package:tinkler/ui/widgets/avatar.dart';

class SearchView extends StatelessWidget {
  static final navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchViewModel>.reactive(
      viewModelBuilder: () => SearchViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Search Users',
            style: Theme.of(context).appBarTheme.textTheme.headline1,
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(80),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        color: Colors.grey[100],
                        width: 290,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          decoration: InputDecoration(hintText: 'Enter name'),
                          onChanged: model.setInput,
                          onEditingComplete: model.searchUsers,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 12.0),
                        child: Icon(
                          Icons.search,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: ModalProgressHUD(
          inAsyncCall: model.isBusy,
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SearchTileBuilder(),
          ),
        ),
      ),
    );
  }
}

class SearchTileBuilder extends ViewModelWidget<SearchViewModel> {
  SearchTileBuilder({
    Key key,
  }) : super(key: key, reactive: true);

  @override
  Widget build(BuildContext context, SearchViewModel model) {
    if (model.listOfUsers == null) return Container();
    if (model.listOfUsers.isEmpty)
      return EmptyContent(
          title: 'Empty Result', message: 'The name entered is not found.');

    return ListView.builder(
      itemBuilder: (context, index) => SearchTile(
        profile: model.listOfUsers[index],
        visitProfile: () => model.visitProfile(model.listOfUsers[index]),
      ),
      itemCount: model.listOfUsers.length,
    );
  }
}

class SearchTile extends StatelessWidget {
  const SearchTile({
    Key key,
    @required this.profile,
    @required this.visitProfile,
  }) : super(key: key);

  final Profile profile;
  final Function visitProfile;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: visitProfile,
      leading: Avatar(photoUrl: profile.photoUrl, radius: 30),
      title: Text(profile.displayName),
      subtitle: Text(profile.email),
    );
  }
}

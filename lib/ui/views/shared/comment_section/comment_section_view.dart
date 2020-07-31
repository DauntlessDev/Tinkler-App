import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import 'package:tinkler/model/commentprofile.dart';
import 'package:tinkler/ui/views/shared/comment_section/comment_section_viewmodel.dart';
import 'package:tinkler/ui/widgets/avatar.dart';
import 'package:tinkler/ui/widgets/empty_content.dart';

class CommentSectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      ViewModelBuilder<CommentSectionViewModel>.reactive(
        viewModelBuilder: () => CommentSectionViewModel(),
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
              title: Text('Comments'),
              backgroundColor:
                  Theme.of(context).backgroundColor.withOpacity(0.3)),
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(child: _CommentList()),
                _InputComment(),
              ],
            ),
          ),
        ),
      );
}

class _CommentList extends ViewModelWidget<CommentSectionViewModel> {
  const _CommentList({
    Key key,
  }) : super(key: key, reactive: true);

  @override
  Widget build(BuildContext context, CommentSectionViewModel model) {
    if (model.commentprofileList == null) return EmptyContent();
    return ListView.builder(
      itemCount: model.commentprofileList.length,
      itemBuilder: (context, index) => _CommentTile(
        commentProfile: model.commentprofileList[index],
      ),
    );
  }
}

class _CommentTile extends ViewModelWidget<CommentSectionViewModel> {
  const _CommentTile({
    Key key,
    @required this.commentProfile,
  }) : super(key: key, reactive: true);

  final CommentProfile commentProfile;

  @override
  Widget build(BuildContext context, CommentSectionViewModel model) {
    return ListTile(
      onTap: () => model.visitProfile(commentProfile.profile.email),
      leading: Avatar(
        radius: 25,
        photoUrl: commentProfile.profile.photoUrl,
      ),
      title: Row(children: [
        Text(
          commentProfile.profile.displayName,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 10),
        Text(
          commentProfile.comment.commentContent,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
        ),
      ]),
      subtitle: Text(
        ' ${model.formatDate(commentProfile.comment.commentTime)}',
        style: TextStyle(color: Colors.grey, fontSize: 10),
      ),
    );
  }
}

class _InputComment extends HookViewModelWidget<CommentSectionViewModel> {
  const _InputComment({
    Key key,
  }) : super(key: key, reactive: false);

  @override
  Widget buildViewModelWidget(
      BuildContext context, CommentSectionViewModel model) {
    var messageTextController = useTextEditingController();
    return Container(
      padding: EdgeInsets.all(2),
      color: Theme.of(context).colorScheme.onSurface,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Container(
                child: TextField(
                  controller: messageTextController,
                  onChanged: model.setInput,
                  decoration: InputDecoration(
                    fillColor: Theme.of(context).colorScheme.onSurface,
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ),
          ),
          FlatButton(
            onPressed: () {
              model.sendComment();
              messageTextController.clear();
            },
            child: Text(
              'Send',
            ),
          ),
        ],
      ),
    );
  }
}

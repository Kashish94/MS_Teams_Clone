import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teams_clone/models/contact.dart';
import 'package:teams_clone/models/user.dart';
import 'package:teams_clone/provider/user_provider.dart';
import 'package:teams_clone/resources/auth_methods.dart';
import 'package:teams_clone/resources/chat_methods.dart';
import 'package:teams_clone/screens/chatscreens/chat_screen.dart';
import 'package:teams_clone/screens/chatscreens/widgets/cached_image.dart';
import 'package:teams_clone/shared/theme_builder.dart';
import 'package:teams_clone/widgets/custom_tile.dart';

import 'message_container.dart';
import 'active_status.dart';

class ContactView extends StatelessWidget {
  final Contact contact;
  ContactView(this.contact);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: AuthMethods.getUserDetailsById(contact.uid),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          User user = snapshot.data;

          return ViewLayout(
            contact: user,
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class OpenContainerWrapper extends StatelessWidget {
  const OpenContainerWrapper({
    @required this.closedBuilder,
    @required this.transitionType,
    @required this.onClosed,
    @required this.animateToScreen,
  });

  final CloseContainerBuilder closedBuilder;
  final ContainerTransitionType transitionType;
  final ClosedCallback<bool> onClosed;
  final Widget animateToScreen;

  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      builder: (theme) => OpenContainer<bool>(
        closedColor: theme.scaffoldBackgroundColor,
        transitionType: transitionType,
        openBuilder: (BuildContext context, VoidCallback _) {
          return animateToScreen;
        },
        onClosed: onClosed,
        tappable: true,
        closedBuilder: closedBuilder,
      ),
    );
  }
}

class ViewLayout extends StatelessWidget {
  final User contact;
  final ChatMethods _chatMethods = ChatMethods();

  ViewLayout({
    @required this.contact,
  });

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return OpenContainerWrapper(
      closedBuilder: (context, _) {
        return CustomTile(
          mini: false,
          title: Text(
            (contact != null ? contact.name : null) != null
                ? contact.name
                : "..",
            style: TextStyle(
                color: AdaptiveTheme.of(context).theme.primaryColorDark,
                fontFamily: "Arial",
                fontSize: 17),
          ),
          subtitle: MessageContainer(
            stream: _chatMethods.fetchLastMessageBetween(
              senderId: userProvider.getUser.uid,
              receiverId: contact.uid,
            ),
          ),
          leading: Container(
            constraints: BoxConstraints(maxHeight: 60, maxWidth: 60),
            child: Stack(
              children: <Widget>[
                CachedImage(
                  contact.profilePhoto,
                  radius: 80,
                  isRound: true,
                ),
                ActiveStatus(
                  uid: contact.uid,
                ),
              ],
            ),
          ),
        );
      },
      animateToScreen: ChatScreen(receiver: contact),
      onClosed: (bool value) {},
      transitionType: ContainerTransitionType.fade,
    );
  }
}

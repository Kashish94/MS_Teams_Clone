import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teams_clone/models/contact.dart';
import 'package:teams_clone/provider/user_provider.dart';
import 'package:teams_clone/resources/chat_methods.dart';
import 'package:teams_clone/screens/callscreens/pickup/pickup_layout.dart';
import 'package:teams_clone/screens/search/search_bar.dart';
import 'package:teams_clone/shared/intro_preview.dart';
import 'package:teams_clone/shared/theme_builder.dart';
import 'package:teams_clone/shared/user_icon.dart';
import 'package:teams_clone/utils/utilities.dart';
import 'package:teams_clone/widgets/teams_appbar.dart';

import 'widgets/contact_view.dart';
import 'widgets/chat_button.dart';

class ChatListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PickupLayout(
      scaffold: ThemeBuilder(
        builder: (theme) => Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          appBar: TeamsAppBar(
            title: Text(
              "TEAMS CLONE",
              style: TextStyle(color: theme.primaryColorDark),
            ),
            color: theme.scaffoldBackgroundColor,
            centerTitle: false,
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: theme.primaryColorDark,
                ),
                onPressed: () {
                  Utils.navigateTo(context, SearchBar());
                },
              ),
              UserIcon(),
            ],
          ),
          floatingActionButton: ChatButton(),
          body: ChatListContainer(),
        ),
      ),
    );
  }
}

class ChatListContainer extends StatelessWidget {
  final ChatMethods _chatMethods = ChatMethods();

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: _chatMethods.fetchContacts(
            userId: userProvider.getUser.uid,
          ),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var docList = snapshot.data.documents;

              if (docList.isEmpty) {
                return QuietBox(
                  heading: "This is where all the contacts are listed",
                  subtitle:
                      "Search for your friends and family to start calling or chatting with them",
                );
              }
              return ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: docList.length,
                itemBuilder: (context, index) {
                  Contact contact = Contact.fromMap(docList[index].data);

                  return ContactView(contact);
                },
              );
            }

            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}

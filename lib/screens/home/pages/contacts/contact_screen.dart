import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:teams_clone/constants/strings.dart';
import 'package:teams_clone/screens/callscreens/pickup/pickup_layout.dart';
import 'package:teams_clone/screens/chatscreens/widgets/cached_image.dart';
import 'package:teams_clone/shared/intro_preview.dart';
import 'package:teams_clone/shared/theme_builder.dart';
import 'package:teams_clone/widgets/custom_tile.dart';
import 'package:teams_clone/widgets/teams_appbar.dart';
import 'package:contacts_service/contacts_service.dart' as cs;

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  List<cs.Contact> contactList;

  @override
  void initState() {
    super.initState();

    getContacts();
  }

  getContacts() async {
    try {
      contactList = (await cs.ContactsService.getContacts(
        withThumbnails: false,
      ))
          .toList();
    } catch (e) {
      contactList = [];
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return PickupLayout(
      scaffold: Scaffold(
        backgroundColor:
            AdaptiveTheme.of(context).theme.scaffoldBackgroundColor,
        appBar: TeamsAppBar(
          title: "Contacts",
          color: AdaptiveTheme.of(context).theme.scaffoldBackgroundColor,
          actions: <Widget>[],
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 15),
          child: contactList == null
              ? Center(child: CircularProgressIndicator())
              : contactList.isEmpty
                  ? QuietBox(
                      heading: 'No Contacts Found',
                      subtitle: 'Found no contacts to display')
                  : ListView.builder(
                      itemCount: contactList.length,
                      itemBuilder: (context, index) {
                        cs.Contact _contact = contactList[index];

                        return CustomTile(
                          subtitle: Container(),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: CachedImage(
                              demoImage,
                              height: 50,
                              width: 50,
                            ),
                          ),
                          mini: false,
                          title: ThemeBuilder(
                            builder: (theme) => Text(
                              _contact?.displayName ?? '-',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                                color: theme.primaryColorDark,
                              ),
                            ),
                          ),
                          trailing: MaterialButton(
                            elevation: 3.0,
                            height: 25.0,
                            minWidth: 50,
                            color: AdaptiveTheme.of(context).theme.primaryColor,
                            textColor: Colors.white,
                            child: Icon(Icons.share),
                            onPressed: () {
                              Share.share(
                                'Hey, Teams Clone is your digital workplace, chat, call and collaborate with your peers all in one place! Come join me there.',
                                subject: 'Teams Clone app on Android',
                              );
                            },
                          ),
                        );
                      },
                    ),
        ),
      ),
    );
  }
}

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hey_guys/shared/contact_tile_widget.dart';
import 'package:hey_guys/shared/loading_screen.dart';

class HomePage extends StatefulWidget {
  final List<Contact> selectedContacts;
  HomePage({
    Key key,
    @required this.selectedContacts,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loaded();
    // getDataFromSharedPrefs();
    // selectContacts();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? LoadingScreen()
        : Scaffold(
            body: Container(
              child: ListView.builder(
                padding: EdgeInsets.only(top: 30),
                shrinkWrap: true,
                itemCount: widget.selectedContacts.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: ContactTileWidget(
                      name: widget.selectedContacts[index].displayName,
                      phoneNo: widget.selectedContacts[index].phones
                          .elementAt(0)
                          .value,
                    ),
                  );
                },
              ),
            ),
          );
  }

  loaded() {
    setState(() {
      loading = false;
    });
  }
}

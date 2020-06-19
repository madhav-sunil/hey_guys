import 'dart:math';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:hey_guys/pages/intro_slides.dart';
import 'package:hey_guys/shared/shared_prefs.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

const int DEFAULT_NUMBER_OF_CONTACTS = 2;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Contact> contacts = [];
  List<Contact> selectedContacts = [];
  List<String> _excludedContacts = [];
  int _numberOfContactsToDisplay = DEFAULT_NUMBER_OF_CONTACTS;
  bool _firstTimeUser = false;

  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: _firstTimeUser
          ? IntroSlide(selectedContacts: selectedContacts)
          : IntroSlide(selectedContacts: selectedContacts),
    );
  }

  void requestPermission() async {
    setData();

    if (await Permission.contacts.status.isGranted) {
      getContacts();
    } else if (await Permission.contacts.request().isDenied) {
      requestPermission();
    }
  }

  void getContacts() async {
    List<Contact> _contacts =
        (await ContactsService.getContacts(withThumbnails: false)).toList();
    setState(() {
      contacts = _contacts;
    });

    getDataFromSharedPrefs();

    Random random = new Random();
    int randomIndex = random.nextInt(4);
    while (selectedContacts.length < _numberOfContactsToDisplay) {
      if (selectedContacts.contains(contacts[randomIndex]) ||
          _excludedContacts.contains(contacts[randomIndex].displayName)) {
        randomIndex = random.nextInt(4);
      } else {
        selectedContacts.add(contacts[randomIndex]);
      }
    }
  }

  // gets data from Shared Prefs
  Future<void> getDataFromSharedPrefs() async {
    SharedPrefsForThisApp prefsForThisApp = new SharedPrefsForThisApp();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _excludedContacts =
          prefs.getStringList(prefsForThisApp.EXCLUDED_CONTACTS) ?? [];
      _numberOfContactsToDisplay =
          prefs.getInt(prefsForThisApp.NUMBER_OF_CONTACTS_TO_DISPLAY) ??
              DEFAULT_NUMBER_OF_CONTACTS;
      _firstTimeUser = prefs.getBool(prefsForThisApp.FIRST_TIME_USER) ?? true;
    });
  }

  setData() async {
    SharedPrefsForThisApp prefsForThisApp = new SharedPrefsForThisApp();
    _excludedContacts.add('Shameel');
    _excludedContacts.add('Hai');
    print(_excludedContacts.length);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(prefsForThisApp.EXCLUDED_CONTACTS, _excludedContacts);
  }
}

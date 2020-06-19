import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hey_guys/shared/shared_prefs.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'home_pages.dart';

class IntroSlide extends StatefulWidget {
  final List<Contact> selectedContacts;

  const IntroSlide({
    Key key,
    @required this.selectedContacts,
  }) : super(key: key);

  @override
  _IntroSlideState createState() => _IntroSlideState();
}

class _IntroSlideState extends State<IntroSlide> {
  List<Slide> slides = new List();

  Function gotToTap;

  @override
  void initState() {
    super.initState();

    slides.add(Slide(
      title: "Welcome",
      styleTitle: TextStyle(
          color: Colors.black87,
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'RobotoMono'),
      description:
          "hey guys helps you to connect with your friends and does the task of \n organising random contacts for you...",
      styleDescription: TextStyle(
          color: Colors.black87,
          fontSize: 20.0,
          fontStyle: FontStyle.normal,
          fontFamily: 'Raleway'),
      backgroundColor: Colors.white,
      pathImage: "assets/Phone-introscreen.png",
    ));

    slides.add(Slide(
      title: "Welcome",
      styleTitle: TextStyle(
          color: Colors.black87,
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'RobotoMono'),
      description:
          "hey guys helps you to connect with your friends and does the task of \n organising random contacts for you...",
      styleDescription: TextStyle(
          color: Colors.black87,
          fontSize: 20.0,
          fontStyle: FontStyle.normal,
          fontFamily: 'Raleway'),
      backgroundColor: Colors.white,
      pathImage: "assets/Phone-introscreen.png",
    ));

    slides.add(Slide(
      title: "Welcome",
      styleTitle: TextStyle(
          color: Colors.black87,
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'RobotoMono'),
      description:
          "hey guys helps you to connect with your friends and does the task of \n organising random contacts for you...",
      styleDescription: TextStyle(
          color: Colors.black87,
          fontSize: 20.0,
          fontStyle: FontStyle.normal,
          fontFamily: 'Raleway'),
      backgroundColor: Colors.white,
      pathImage: "assets/Phone-introscreen.svg",
    ));
    tutorialDone();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: IntroSlider(
          slides: this.slides,
          isScrollable: true,

          //Done button
          onDonePress: onDonePress,
          renderDoneBtn: renderDoneBtn(),
          colorDoneBtn: Color(0xFABBD70F1),
          highlightColorDoneBtn: Color(0xFAA8D3FB),

          //Next button
          renderNextBtn: renderNextBtn(),

          // //Skip button
          // renderSkipBtn: renderSkipBtn(),
          // colorSkipBtn: Color(0xFABBD7F1),
          // highlightColorSkipBtn: Color(0xFAA8D3FB),

          //Dot indicator
          colorDot: Color(0xA0BBD7F1),
          colorActiveDot: Color(0xFAA8D3FB),
          // typeDotAnimation: dotSliderAnimation.DOT_MOVEMENT,

          //Tabs
          listCustomTabs: this.renderListCustomTabs(),
          backgroundColorAllSlides: Colors.white,
          refFuncGoToTab: (refFunc) {
            gotToTap = refFunc;
          },

          //show  or hide status bar
          shouldHideStatusBar: true,

          onTabChangeCompleted: onTapChangeCompleted,
        ),
      ),
    );
  }

  void onDonePress() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(
                  selectedContacts: widget.selectedContacts,
                )));
  }

  void onTapChangeCompleted(index) {
    //index is focused
  }

  Widget renderNextBtn() {
    return Icon(
      Icons.navigate_next,
      color: Colors.white,
      size: 35.0,
    );
  }

  Widget renderDoneBtn() {
    return Icon(
      Icons.done,
      color: Colors.white,
      size: 35.0,
    );
  }

  // Widget renderSkipBtn() {
  //   return Icon(
  //     Icons.skip_next,
  //     color: Colors.white,
  //     size: 35.0,
  //   );
  // }

  List<Widget> renderListCustomTabs() {
    var screenSize = MediaQuery.of(context).size;
    List<Widget> tabs = new List();
    for (int i = 0; i < slides.length; i++) {
      Slide currentSlide = slides[i];
      tabs.add(
        Container(
          width: screenSize.width,
          height: screenSize.height,
          child: Container(
            margin: EdgeInsets.only(top: 40),
            child: ListView(
              children: <Widget>[
                GestureDetector(
                  child: Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset("assets/Phone-introscreen.svg"),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Text(
                    currentSlide.title,
                    style: currentSlide.styleTitle,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  child: Text(
                    currentSlide.description,
                    style: currentSlide.styleDescription,
                    textAlign: TextAlign.center,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                  margin: EdgeInsets.only(top: 20.0),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return tabs;
  }

  void tutorialDone() async {
    SharedPrefsForThisApp prefsForThisApp = new SharedPrefsForThisApp();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(prefsForThisApp.FIRST_TIME_USER, false);
  }
}

import 'package:flutter/material.dart';

class ContactTileWidget extends StatefulWidget {
  final String name;
  final String phoneNo;
  const ContactTileWidget({
    Key key,
    @required this.name,
    @required this.phoneNo,
  }) : super(key: key);

  @override
  _ContactTileWidgetState createState() => _ContactTileWidgetState();
}

class _ContactTileWidgetState extends State<ContactTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: RaisedButton(
        padding: EdgeInsets.all(10),
        color: Color(0xFDFFFFFF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                widget.name,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 24,
                ),
              ),
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 100,
                ),
                Text(widget.phoneNo),
              ],
            )
          ],
        ),
        onPressed: () {
          //TODO: drop down
        },
      ),
    );
  }
}

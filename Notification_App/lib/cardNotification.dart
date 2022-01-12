import 'package:flutter/material.dart';

class CardNotification extends StatefulWidget {
  var title;
  var body;
  CardNotification(@required this.title, @required this.body){}

  @override
  _CardNotificationState createState() => _CardNotificationState();
}

class _CardNotificationState extends State<CardNotification> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight:  FontWeight.bold,
                  color: Colors.blue
              ),
            ),
            Text(
              widget.body,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight:  FontWeight.w500,
                  fontStyle: FontStyle.italic,
                  color: Colors.teal
              ),
            )
          ],
        ),
      ),
    );
  }
}
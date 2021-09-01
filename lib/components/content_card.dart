//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:rhamna_pam/models/content.dart';
import 'package:rhamna_pam/components/video.dart';
import 'package:rhamna_pam/screens/article.dart';

class ContentCard extends StatelessWidget {
  final Content content;
  ContentCard({Key? key, required this.content}) : super(key: key);

  Widget build(BuildContext context) {
    Widget fileWidget = Text('');
    Widget seeMoreWidget = SizedBox();

    if (content.type == 'jpg' ||
        content.type == 'jpeg' ||
        content.type == 'png') {
      fileWidget = InteractiveViewer(child: Image.network(content.file));
    } else if (content.type == "mp4") {
      fileWidget = MyVideo(video: content.file);
    }

    if (content.name == "article") {
      seeMoreWidget = TextButton(
        onPressed: () {
          Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => ArticlePage(content: content)),
          );
        },
        style: TextButton.styleFrom(
          primary: Colors.white,
          backgroundColor: Colors.cyan,
          padding: EdgeInsets.symmetric(horizontal: 5),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Text('معرفة المزيد'),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 0.01,
            blurRadius: 9,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.all(20),
        child: Center(
            child: Column(
          children: [
            Text(
              content.title,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.blue[900]),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8, top: 8),
              child: fileWidget,
            ),
            seeMoreWidget
          ],
        )),
      ),
    );
  }
}

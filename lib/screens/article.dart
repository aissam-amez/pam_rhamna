import 'package:flutter/material.dart';
import 'package:rhamna_pam/models/content.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:rhamna_pam/components/video.dart';

class ArticlePage extends StatelessWidget {
  final Content content;
  const ArticlePage({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget fileWidget = Text('');
    if (content.type == 'jpg' ||
        content.type == 'jpeg' ||
        content.type == 'png') {
      fileWidget = Image.network(content.file);
    } else if (content.type == "mp4") {
      fileWidget = MyVideo(video: content.file);
    }

    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              children: [
                /*2*/
                Container(
                  child: Text(
                    content.title,
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.blue[900]),
                  ),
                ),
                /*Text(
                  'Kandersteg, Switzerland',
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),*/
              ],
            ),
          ),
          /*3*/
          /*Icon(
            Icons.star,
            color: Colors.red[500],
          ),
          const Text('41'),*/
        ],
      ),
    );

    /*Column _buildButtonColumn(Color color, IconData icon, String label) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color),
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: color,
              ),
            ),
          ),
        ],
      );
    }*/

    /*Color color = Theme.of(context).primaryColor;*/

    /*Widget buttonSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButtonColumn(color, Icons.favorite, 'Favotie'),
        _buildButtonColumn(color, Icons.near_me, 'ROUTE'),
        _buildButtonColumn(color, Icons.share, 'SHARE'),
      ],
    );*/

    Widget textSection = Padding(
      padding: EdgeInsets.all(32),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Html(
          data: content.content,
        ),
      ),
    );

    return Scaffold(
      //extendBodyBehindAppBar: true, //for body enter the app bar
      appBar: new AppBar(
        centerTitle: true,
        title: new Text(
          "تراكتور الرحامنة",
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          fileWidget,
          titleSection,
          textSection,
        ],
      )),
    );
  }
}

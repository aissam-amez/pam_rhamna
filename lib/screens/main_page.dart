import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:rhamna_pam/components/content_card.dart';
import 'package:rhamna_pam/apis/calls.dart';
import 'package:rhamna_pam/components/header.dart';
import 'package:rhamna_pam/models/content.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future connectivityResult;
  late Future contents;

  @override
  void initState() {
    super.initState();
    connectivityResult = Connectivity().checkConnectivity();
    contents = getContentFromApi();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Rhamna PAM'),
        ),
        body: FutureBuilder(
            future: connectivityResult,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data == ConnectivityResult.mobile ||
                    snapshot.data == ConnectivityResult.wifi) {
                  return Container(
                    child: SafeArea(
                        child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Header(
                            background: "assets/rhamna_pam_header.jpg",
                            avatar: "assets/rhamna_pam.jpg",
                          ),
                          /*Text(
                  widget.label,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),*/
                          FutureBuilder(
                              future: contents,
                              builder: (BuildContext context,
                                  AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.hasData) {
                                  print(snapshot.data);
                                  List contents = snapshot.data
                                      .map((model) => Content.fromJson(model))
                                      .toList();
                                  print(contents);

                                  return Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      children: contents
                                          .map(
                                            (content) => ContentCard(
                                              content: content,
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  );
                                } else if (snapshot.hasError) {
                                  return Center(
                                    child: Text(snapshot.error.toString()),
                                  );
                                }
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [CircularProgressIndicator()],
                                );
                              })
                        ],
                      ),
                    )),
                  );
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'المرجو الإتصال بالشبكة !!!',
                          style: TextStyle(fontSize: 20),
                          textDirection: TextDirection.rtl,
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 20),
                          child: TextButton(
                              style: TextButton.styleFrom(
                                  padding: const EdgeInsets.all(16.0),
                                  primary: Colors.white,
                                  textStyle: const TextStyle(fontSize: 20),
                                  backgroundColor: Colors.cyan[800]),
                              onPressed: () {
                                setState(() {
                                  connectivityResult =
                                      Connectivity().checkConnectivity();
                                });
                              },
                              child: Text('تحديث')),
                        )
                      ],
                    ),
                  );
                }
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                      'ثدوث غلط أثناء محاولة التأكد من الإتصال بالشبكة !!!'),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}

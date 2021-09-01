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
  ScrollController _scrollController = new ScrollController();

  var end = 5;

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
          title: Text('تراكتور الرحامنة'),
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
                      controller: _scrollController,
                      child: Column(
                        children: [
                          Header(
                            background: "assets/bg_pam_r.jpg",
                            avatar: "assets/pam_r.jpg",
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
                                  //print(snapshot.data);
                                  List contents = snapshot.data
                                      .map((model) => Content.fromJson(model))
                                      .toList();
                                  //print(contents);
                                  _scrollController.addListener(() {
                                    if (_scrollController.position.pixels ==
                                        _scrollController
                                            .position.maxScrollExtent) {
                                      //print("fdgfgdfgdfg");
                                      setState(() {
                                        end = end + 5 >= contents.length
                                            ? contents.length
                                            : end + 5;
                                      });
                                    }
                                  });
                                  return Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      children: contents
                                          .sublist(0, end) //contents
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
                                      child: Column(
                                    children: [
                                      Text(
                                        "حدث غلط في الإتصال بالشبكة المرجو إعادة المحاولة",
                                        textAlign: TextAlign.center,
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(top: 20),
                                        child: TextButton(
                                            style: TextButton.styleFrom(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                primary: Colors.white,
                                                textStyle: const TextStyle(
                                                    fontSize: 20),
                                                backgroundColor:
                                                    Colors.cyan[800]),
                                            onPressed: () {
                                              setState(() {
                                                contents = getContentFromApi();
                                              });
                                            },
                                            child: Text('تحديث')),
                                      )
                                    ],
                                  ));
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

                                  contents = getContentFromApi();
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

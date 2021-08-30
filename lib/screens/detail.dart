//import 'dart:io';
import 'package:flutter/material.dart';
import 'package:rhamna_pam/components/header.dart';
//import 'package:rhamna_pam/apis/calls.dart';
//import 'package:rhamna_pam/models/content.dart';
//import 'package:rhamna_pam/components/content_card.dart';

class Detail extends StatefulWidget {
  Detail(
      {Key? key,
      required this.label,
      required this.background,
      required this.avatar})
      : super(key: key);

  final String label;
  final String background;
  final String avatar;

  @override
  _Detail createState() => _Detail();
}

class _Detail extends State<Detail> {
  late Future contents;

  @override
  void initState() {
    super.initState();
    setState(() {
      //contents = getProductsFromApi();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('فاطمة الزهراء المنصوري'),
        ),
        body: Container(
          child: SafeArea(
              child: SingleChildScrollView(
            child: Column(
              children: [
                Header(
                  background: widget.background,
                  avatar: widget.avatar,
                ),
                Text(
                  widget.label,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                FutureBuilder(
                    future: contents,
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData) {
                        print(snapshot.data);
                        /* List contents = snapshot.data
                            .map((model) => Content.fromJson(model))
                            .toList();*/
                        print(contents);

                        return Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                              children: [] /* contents
                                .map(
                                  (content) => ContentCard(
                                    content: content,
                                  ),
                                )
                                .toList(),*/
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
        ));
  }
}

/*import 'package:flutter/material.dart';
import 'package:mansouri/screens/detail.dart';

class Circle extends StatelessWidget {
  final String avatar;
  final String label;
  final String background;

  Circle({
    required this.avatar,
    required this.label,
    required this.background,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Detail(
                        label: label, background: background, avatar: avatar)),
              )
            },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2,
              margin: const EdgeInsets.only(bottom: 15),
              padding: const EdgeInsets.all(5),
              child: Container(
                margin: const EdgeInsets.only(bottom: 15),
                //width: MediaQuery.of(context).size.width / 2,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage('assets/images/circle.png'))),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(background),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: 130,
                  child: Stack(
                    children: [
                      Positioned(
                          child: Container(
                              decoration: BoxDecoration(
                        color: Color(0xff1976d2).withOpacity(0.6), //0xff1976d2
                        shape: BoxShape.circle,
                      ))),
                      Align(
                          alignment: Alignment.center,
                          child: Text(
                            label,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: Colors.white),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
*/
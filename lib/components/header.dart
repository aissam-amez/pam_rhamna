import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Header extends StatelessWidget {
  final String background;
  final String avatar;

  const Header({Key? key, required this.background, required this.avatar})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return _header(context, background, avatar);
  }

  Container _header(BuildContext context, String background, String image) {
    return Container(
      padding: const EdgeInsets.only(bottom: 45),
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15)),
              image: DecorationImage(
                image: AssetImage(background),
                fit: BoxFit.cover,
                //repeat: ImageRepeat.repeat,
              ),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  bottom: -110,
                  right: 40,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(150, 60)),
                      //shape: BoxShape.circle,
                    ),
                    alignment: Alignment.bottomCenter,
                    width: MediaQuery.of(context).size.width - 80,
                    height: 130,
                    margin: const EdgeInsets.only(bottom: 15),
                    child: Text(''),
                  ),
                ),
                Positioned(
                  bottom: -35,
                  right: (MediaQuery.of(context).size.width / 2) - 75,
                  child: Container(
                      height: 150,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        shape: BoxShape.circle,
                      ),
                      child: Container(
                        height: 150,
                        decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage(image)),
                          shape: BoxShape.circle,
                        ),
                        padding: EdgeInsets.all(10),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/circle.png',
                            height: 150,
                          ),
                        ),
                      )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:rhamna_pam/screens/main_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: Duration(milliseconds: 2500), vsync: this);

    controller.forward().then((_) {
      navigationPage();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void navigationPage() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => MyHomePage(title: 'Rhamna PAM')));
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          color: Colors.indigo[900],
          image: DecorationImage(
              image: AssetImage("Layer.png"), fit: BoxFit.cover)),
      child: Center(
        child: Container(
          height: 250,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[100],
          ),
          child: ClipRRect(
            child: ClipOval(
              child: Image.asset(
                'assets/rhamna_pam.jpg',
                //height: 250,
              ),
            ),
          ),
        ),
      ),
    ));
  }
}

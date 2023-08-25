import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wallpaper_app/pages/wall_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 4)).then((value) => Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx)=> const WallScreen())));
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Image(
              image: AssetImage("assets/splash.gif"),width: 375,
            ),
            SizedBox(
              height: 50,
            ),
            SpinKitDoubleBounce(
              color: Colors.lightBlueAccent,
              size: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}

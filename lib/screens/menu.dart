import 'package:flutter/material.dart';
import 'package:flutter_webapi_first_course/screens/home_screen/home_screen.dart';
import 'package:flutter_webapi_first_course/screens/overview_screen/overview_screen.dart';
import 'package:flutter_webapi_first_course/theme/theme_typography.dart';

import 'about_screen/about_screen.dart';

class BuildMenu extends StatelessWidget {
  BuildMenu({Key? key}) : super(key: key);

  late final TextStyle thinTile = ThemeTypography.gFonts(
      'Sora', 15, FontWeight.w300, Colors.white);

  late final TextStyle boldTile = ThemeTypography.gFonts(
      'Sora', 15, FontWeight.w600, Colors.white);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar( // TODO : IMPLEMENT PICTURE UPLOAD
                  backgroundColor: Colors.white,
                  radius: 22.0,

                ),
                const SizedBox(height: 16.0),
                Text(
                  "Hello, ポッテル・リッキ",
                  style: thinTile,
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder:(context) => const HomeScreen()));
            },
            leading: const Icon(Icons.sunny, size: 25.0, color: Colors.white),
            title: Text("sept jours", style: boldTile,),
            textColor: Colors.white,
            dense: true,
          ),
          ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder:(context) => const Overview()));
            },
            leading: const Icon(
                Icons.motion_photos_on, size: 25.0, color: Colors.white),
            title: Text("le panorama", style: thinTile,),
            textColor: Colors.white,
            dense: true,
          ),
          ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder:(context) => const About()));
            },
            leading: const Icon(Icons.star, size: 25.0, color: Colors.white),
            title: Text("environ", style: thinTile,),
            textColor: Colors.white,
            dense: true,
          ),
        ],
      ),
    );
  }
}

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:movie_traliers/ui/theme_ui.dart';

class HomeAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 96,
      padding: EdgeInsets.only(left: 24, right: 24, top: 30),
      decoration: BoxDecoration(
        color: bgColor,
        border: Border(
            bottom: BorderSide(
          width: 0.3,
          color: accentColor,
        )),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(2.5),
            decoration: BoxDecoration(
              border: Border.all(color: accentColor, width: 1.5),
              borderRadius: BorderRadius.circular(36),
            ),
            child: CircleAvatar(
              backgroundColor: accentColor,
              backgroundImage: AssetImage('assets/images/serdar.jpg'),
              radius: 18,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'DISCOVER',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  letterSpacing: 1.4,
                  color: accentColor,
                ),
              ),
              Text(
                'Discover & Enjoy',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  letterSpacing: 1.2,
                  color: whiteColor,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 44,
              height: 44,
              alignment: AlignmentDirectional.centerEnd,
              child: Icon(
                EvaIcons.search,
                color: accentColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

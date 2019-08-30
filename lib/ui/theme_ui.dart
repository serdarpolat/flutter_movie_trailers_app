import 'package:flutter/material.dart';

final Color bgColor = Color(0xff191C21);
final Color accentColor = Color(0xffFEC337);
final Color whiteColor = Color(0xffE0E0E0);

Widget header(String title, bool hasSeeAll) {
  return Padding(
    padding: const EdgeInsets.only(top: 36, bottom: 20, left: 24),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            color: whiteColor,
            fontWeight: FontWeight.bold,
            fontSize: 32,
            letterSpacing: 1.1,
          ),
        ),
        hasSeeAll ? 
        GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                bottomLeft: Radius.circular(24),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Text(
                'See All',
                style: TextStyle(
                    color: bgColor,
                    letterSpacing: 1.2,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ) : Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                bottomLeft: Radius.circular(24),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Text(
                'See All',
                style: TextStyle(
                    color: Colors.transparent,
                    letterSpacing: 1.2,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
      ],
    ),
  );
}

Widget detailsPageHeader(String title) {
  return Padding(
    padding: const EdgeInsets.only(top: 24.0, bottom: 8),
    child: Text(
      title,
      style: TextStyle(
        color: accentColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        letterSpacing: 2,
      ),
    ),
  );
}

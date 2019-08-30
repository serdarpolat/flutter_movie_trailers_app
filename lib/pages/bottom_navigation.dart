import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:movie_traliers/ui/theme_ui.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedIndex = 0;

  List<NavItem> items = [
    NavItem(
      Icon(
        EvaIcons.homeOutline,
        color: accentColor,
      ),
      Text('Trending',
          style: TextStyle(color: bgColor, fontWeight: FontWeight.bold)),
      0,
    ),
    NavItem(
      Icon(
        EvaIcons.filmOutline,
        color: accentColor,
      ),
      Text('Film',
          style: TextStyle(color: bgColor, fontWeight: FontWeight.bold)),
      1,
    ),
    NavItem(
      Icon(
        EvaIcons.bellOutline,
        color: accentColor,
      ),
      Text('Bell',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      2,
    ),
    NavItem(
      Icon(
        EvaIcons.videoOutline,
        color: accentColor,
      ),
      Text('Video',
          style: TextStyle(color: bgColor, fontWeight: FontWeight.bold)),
      3,
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  Widget buildNavItems(NavItem item, bool isSelected, int index) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(26),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOutBack,
        width: MediaQuery.of(context).size.width / 4 - 20,
        height: double.maxFinite,
        color: isSelected ? accentColor : Colors.transparent,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOutBack,
              bottom: -18.0 * (isSelected ? 1.0 : 5.0),
              child: Container(
                child: item.title,
                height: 46,
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOutBack,
              top: -5.0 * (isSelected ? 10.0 : 1.0),
              left: 28,
              child: Container(
                child: item.icon,
                height: 46,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 72,
      padding: EdgeInsets.only(top: 16, bottom: 16),
      decoration: BoxDecoration(
        color: bgColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.map((item) {
          var itemIndex = items.indexOf(item);
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = itemIndex;
              });
            },
            child: buildNavItems(item, selectedIndex == itemIndex, item.index),
          );
        }).toList(),
      ),
    );
  }
}

class NavItem {
  final Icon icon;
  final Text title;
  final int index;

  const NavItem(this.icon, this.title, this.index);
}

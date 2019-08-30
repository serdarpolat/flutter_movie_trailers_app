import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 560,
        height: 560,
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: FlareActor('assets/images/loader_circle.flr', animation: 'loading'),
        ),
      ),
    );
  }
}

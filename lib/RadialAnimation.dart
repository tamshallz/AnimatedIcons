import 'package:flutter/material.dart';

import 'dart:math';

import 'package:vector_math/vector_math.dart' show radians;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RadialAnimation extends StatelessWidget {
  RadialAnimation({Key key, this.controller})
      : scale = Tween<double>(begin: 1.5, end: 0.0).animate(CurvedAnimation(
          curve: Curves.fastOutSlowIn,
          parent: controller,
        )),
        translation = Tween<double>(begin: 0, end: 100).animate(CurvedAnimation(
          curve: Curves.easeInOut,
          parent: controller,
        )),
        rotation = Tween<double>(begin: 0, end: 360).animate(CurvedAnimation(
            parent: controller,
            curve: Interval(0, 0.7, curve: Curves.decelerate))),
        super(key: key);

  final AnimationController controller;
  final Animation<double> scale;
  final Animation<double> translation;
  final Animation<double> rotation;

  _open() {
    controller.forward();
  }

  _close() {
    controller.reverse();
  }

  _buildButton(double angle, {Color color, IconData icon}) {
    final double rad = radians(angle);
    return Transform(
      transform: Matrix4.identity()
        ..translate(
          (translation.value) * cos(rad),
          (translation.value) * sin(rad),
        ),
      child: FloatingActionButton(
        child: Icon(icon),
        backgroundColor: color,
        onPressed: _close,
      ),
    );
  }

  build(context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, builder) {
          return Transform.rotate(
            angle: radians(rotation.value),
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  _buildButton(0,
                      color: Colors.red, icon: FontAwesomeIcons.thumbtack),
                  _buildButton(45,
                      color: Colors.green, icon: FontAwesomeIcons.sprayCan),
                  _buildButton(90,
                      color: Colors.orange, icon: FontAwesomeIcons.foursquare),
                  _buildButton(135,
                      color: Colors.blue, icon: FontAwesomeIcons.kiwiBird),
                  _buildButton(180,
                      color: Colors.black, icon: FontAwesomeIcons.fulcrum),
                  _buildButton(225,
                      color: Colors.indigo,
                      icon: FontAwesomeIcons.funnelDollar),
                  _buildButton(270,
                      color: Colors.pink, icon: FontAwesomeIcons.bong),
                  _buildButton(315,
                      color: Colors.yellow, icon: FontAwesomeIcons.bolt),
                  _buildButton(360,
                      color: Colors.lime, icon: FontAwesomeIcons.node),
                  _buildButton(405,
                      color: Colors.cyan, icon: FontAwesomeIcons.napster),
                  Transform.scale(
                    scale: scale.value - 1,
                    child: FloatingActionButton(
                      onPressed: _close,
                      child: Icon(FontAwesomeIcons.timesCircle),
                      backgroundColor: Colors.red,
                    ),
                  ),
                  Transform.scale(
                    scale: scale.value,
                    child: FloatingActionButton(
                      onPressed: _open,
                      child: Icon(FontAwesomeIcons.music),
                      backgroundColor: Colors.teal,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

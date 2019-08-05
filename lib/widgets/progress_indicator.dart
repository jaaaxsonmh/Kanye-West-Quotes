import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class _LoadingIndicator extends AnimatedWidget {
  final Color color;
  final double fontSize;

  _LoadingIndicator(
      {Key key, Animation<double> animation, this.color, this.fontSize})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Container(
      height: animation.value + fontSize,
      child: Text(
        '.',
        style: TextStyle(color: color, fontSize: fontSize),
      ),
    );
  }
}

class LoadingIndicatorDots extends StatefulWidget {
  final int number;

  final double fontSize;

  final Color color;

  final double spacing;

  final int ms;

  final double beginTween = 0.0;
  final double endTween = 8.0;

  LoadingIndicatorDots({
    this.number = 3,
    this.fontSize = 10.0,
    this.color = Colors.black,
    this.spacing = 0.0,
    this.ms = 250
  });

  _LoadingIndicatorDotsState createState() =>
      _LoadingIndicatorDotsState(
        number: this.number,
        fontSize: this.fontSize,
        color: this.color,
        spacing: this.spacing,
        ms: this.ms,
      );
}

class _LoadingIndicatorDotsState extends State<LoadingIndicatorDots> with TickerProviderStateMixin {

  int number;
  int ms;
  double fontSize;
  double spacing;
  Color color;

  _LoadingIndicatorDotsState({
    this.number,
    this.fontSize,
    this.spacing,
    this.ms,
    this.color,
});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}

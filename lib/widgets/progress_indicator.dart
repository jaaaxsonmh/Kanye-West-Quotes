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

  LoadingIndicatorDots(
      {this.number = 3,
      this.fontSize = 10.0,
      this.color = Colors.black,
      this.spacing = 0.0,
      this.ms = 250});

  _LoadingIndicatorDotsState createState() => _LoadingIndicatorDotsState(
        number: this.number,
        fontSize: this.fontSize,
        color: this.color,
        spacing: this.spacing,
        ms: this.ms,
      );
}

class _LoadingIndicatorDotsState extends State<LoadingIndicatorDots>
    with TickerProviderStateMixin {
  int number;
  int ms;
  double fontSize;
  double spacing;
  Color color;

  List<AnimationController> _animationControllerList =
      new List<AnimationController>();
  List<Widget> _loadingWidgetList = new List<Widget>();
  List<Animation<double>> _animationList = new List<Animation<double>>();

  _LoadingIndicatorDotsState({
    this.number,
    this.fontSize,
    this.spacing,
    this.ms,
    this.color,
  });

  initState() {
    super.initState();
    for (int i = 0; i < number; i++) {
      //build controllers
      _animationControllerList.add(AnimationController(
          vsync: this, duration: Duration(milliseconds: ms)));
      // build animation
      _createAnimations(i);
      // add all dots
      _createDots(i);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 25.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _loadingWidgetList,
        ));
  }

  void _createDots(int i) {
    _loadingWidgetList.add(Padding(
        padding: EdgeInsets.only(right: spacing),
        child: _LoadingIndicator(
          //TODO:: Animator
          fontSize: fontSize,
          color: color,
        )));
  }

  void _createAnimations(int i) {
    _animationList.add(Tween(begin: widget.beginTween, end: widget.endTween)
        .animate(_animationControllerList[i])
          ..addStatusListener((AnimationStatus status) {
            if (status == AnimationStatus.completed)
              _animationControllerList[i].reverse();

            if (i == number - 1 && status == AnimationStatus.dismissed)
              _animationControllerList[0].forward();

            if (_animationList[i].value > widget.endTween / 2 && i < number - 1)
              _animationControllerList[i + 1].forward();
          }));
  }

  @override
  void dispose() {
    for (int i = 0; i < number; i++) _animationControllerList[i].dispose();
    super.dispose();
  }
}

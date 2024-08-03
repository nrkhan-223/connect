

import 'package:flutter/material.dart';

class DoubleBackToCloseWidget extends StatefulWidget {
  final Widget child; // Make Sure this child has a Scaffold widget as parent.

  const DoubleBackToCloseWidget({super.key,
    required this.child,
  });

  @override
  DoubleBackToCloseWidgetState createState() =>
      DoubleBackToCloseWidgetState();
}

class DoubleBackToCloseWidgetState extends State<DoubleBackToCloseWidget> {
  int ?_lastTimeBackButtonWasTapped;
  static const exitTimeInMillis = 2000;

  bool get _isAndroid => Theme.of(context).platform == TargetPlatform.android;

  @override
  Widget build(BuildContext context) {
    if (_isAndroid) {
      return WillPopScope(
        onWillPop: _handleWillPop,
        child: widget.child,
      );
    } else {
      return widget.child;
    }
  }

  Future<bool> _handleWillPop() async {
    final currentTime = DateTime.now().millisecondsSinceEpoch;

    if (_lastTimeBackButtonWasTapped != null &&
        (currentTime - _lastTimeBackButtonWasTapped!) < exitTimeInMillis) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      return true;
    } else {
      _lastTimeBackButtonWasTapped = DateTime.now().millisecondsSinceEpoch;
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        _getExitSnackBar(context),
      );
      return false;
    }
  }

  SnackBar _getExitSnackBar(
      BuildContext context,
      ) {
    return const SnackBar(
      content: Text(
        'Press BACK again to exit!',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.red,
      duration: Duration(
        seconds: 2,
      ),
      behavior: SnackBarBehavior.floating,
    );
  }
}
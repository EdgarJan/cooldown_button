import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badge;
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class CooldownButton extends StatefulWidget {
  final Function onConfirm;
  final String text;
  final String confirmText;

  const CooldownButton(
      {Key? key,
      required this.onConfirm,
      required this.text,
      required this.confirmText})
      : super(key: key);

  @override
  State<CooldownButton> createState() => _CooldownButtonState();
}

class _CooldownButtonState extends State<CooldownButton> {
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 5;
  bool onCooldown = false;
  CountdownTimerController? controller;

  @override
  void initState() {
    super.initState();
    controller =
        CountdownTimerController(endTime: endTime, onEnd: onEndCooldown);
  }

  @override
  Widget build(BuildContext context) {
    return badge.Badge(
      showBadge: onCooldown,
      badgeContent: CountdownTimer(
        controller: controller,
        widgetBuilder: (_, CurrentRemainingTime? time) {
          if (time == null) {
            return Container();
          } else {
            return Text('${time.sec}');
          }
        },
      ),
      child: ElevatedButton(
        onPressed: () {
          if (!onCooldown) {
            startCooldown();
          } else {
            controller?.dispose();
            widget.onConfirm();
          }
        },
        child: Text(onCooldown ? widget.confirmText : widget.text),
      ),
    );
  }

  void startCooldown() {
    setState(() {
      endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 5;
      onCooldown = true;
      controller =
          CountdownTimerController(endTime: endTime, onEnd: onEndCooldown);
    });
  }

  void onEndCooldown() {
    setState(() {
      onCooldown = false;
    });
  }
}

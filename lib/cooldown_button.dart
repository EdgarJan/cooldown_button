import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badge;
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class CooldownButton extends StatefulWidget {
  final Function onConfirm;
  final String text;
  final String confirmText;

  const CooldownButton({
    Key? key, 
    required this.onConfirm,
    required this.text,
    required this.confirmText
  }) : super(key: key);

  @override
  State<CooldownButton> createState() => _CooldownButtonState();
}

class _CooldownButtonState extends State<CooldownButton> {
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 5;
  bool onCooldown = false;

  @override
  Widget build(BuildContext context) {
    return badge.Badge(
      showBadge: onCooldown,
      badgeContent: CountdownTimer(
        endTime: endTime,
        onEnd: onEndCooldown,
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
    });
  }

  void onEndCooldown() {
    setState(() {
      onCooldown = false;
  }
}

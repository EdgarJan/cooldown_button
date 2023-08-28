import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badge;
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

enum ButtonType {
  elevated,
  text,
}

class CooldownButton extends StatefulWidget {
  final Function onConfirm;
  final Text text;
  final Text confirmText;
  final ButtonType buttonType;

  const CooldownButton(
      {Key? key,
      required this.onConfirm,
      required this.text,
      required this.confirmText,
      this.buttonType = ButtonType.elevated} // Default value
      )
      : super(key: key);

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
      child: widget.buttonType == ButtonType.elevated
          ? ElevatedButton(
              onPressed: onPressed,
              child: buttonText(),
            )
          : TextButton(
              onPressed: onPressed,
              child: buttonText(),
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
    if (mounted) {
      setState(() {
        onCooldown = false;
      });
    }
  }

  onPressed() {
    if (!onCooldown) {
      startCooldown();
    } else {
      widget.onConfirm();
    }
  }

  Text buttonText() {
    return onCooldown ? widget.confirmText : widget.text;
  }
}

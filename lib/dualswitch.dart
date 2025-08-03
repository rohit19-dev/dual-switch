library dualSwitch;

import 'package:dualswitch/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DualSwitch extends StatefulWidget {
  final ValueChanged<bool>? onChanged;
  final String? acceptText, rejectText, acceptedText, rejectedText, centerIcon;
  final Color? acceptColor,rejectColor;
  final bool? reset;
  const DualSwitch({super.key, 
    required this.onChanged, 
    this.acceptText,
    this.acceptedText,
    this.rejectText,
    this.rejectedText,
    this.acceptColor,
    this.rejectColor,
    this.centerIcon,
    this.reset = true
  });

  @override
  DualSwitchState createState() => DualSwitchState();
}

class DualSwitchState extends State<DualSwitch> {
  String? selected; // "approve" or "reject"
  double dragPosition = 0;
  double maxDrag = 80;
  double buttonSize = 40;

  void onEndDrag() {
    if (dragPosition > 40) {
      setState(() {
        selected = 'approve';
        dragPosition = maxDrag;
      });
      widget.onChanged?.call(true);
    } else if (dragPosition < -40) {
      setState(() {
        selected = 'reject';
        dragPosition = -maxDrag;
      });
      widget.onChanged?.call(false);
    } else {
      setState(() {
        dragPosition = 0;
      });
    }

    if(widget.reset ?? false){
      Future.delayed(const Duration(seconds: 1)).then((value) {
        setState(() {
          selected = null;
          dragPosition = 0;
        });
      },);
    }

  }

  @override
  Widget build(BuildContext context) {
    bool isLocked = (widget.reset ?? false) ? false : selected != null;
    Color backgroundColor = AppColor.lightTextColor;

    if (selected == 'approve') {
      backgroundColor = widget.acceptColor ?? AppColor.presentColor;
    } else if (selected == 'reject') {
      backgroundColor = widget.rejectColor ??AppColor.absentColor;
    }

    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: 180,
      height: 45,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (selected == null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text( widget.rejectText ?? "Reject", style: TextStyle(color: AppColor.fontColor, fontSize: 12, fontWeight: FontWeight.w600)),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text( widget.acceptText ?? "Approve", style: TextStyle(color: AppColor.fontColor, fontSize: 12, fontWeight: FontWeight.w600)),
                ),
              ],
            )
          else
            Text(
              selected == 'approve' ? (widget.acceptedText ?? "Approved") : (widget.rejectedText ?? "Rejected"),
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12),
            ),

          // Draggable Center Button
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            left: selected == null
                ? (dragPosition + 65) // 70 = half of 140 (button width)
                : selected == 'approve'
                    ? 140
                    : 0,
            child: GestureDetector(
              onHorizontalDragUpdate: isLocked
                  ? null
                  : (details) {
                      setState(() {
                        dragPosition += details.delta.dx;
                        dragPosition = dragPosition.clamp(-maxDrag, maxDrag);
                      });
                    },
              onHorizontalDragEnd: isLocked ? null : (_) => onEndDrag(),
              child: Container(
                width: buttonSize,
                height: buttonSize,
                decoration: BoxDecoration(
                  color: AppColor.whiteColor,
                  shape: BoxShape.circle,
                ),
                child: (widget.centerIcon != null) ? SvgPicture.asset(widget.centerIcon!, width: 32, height: 32,) : SvgPicture.asset("assets/icons/left_right.svg", width: 16, height: 16,),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

library dualSwitch;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DualSwitch extends StatefulWidget {
  final ValueChanged<bool>? onChanged;
  const DualSwitch({super.key, required this.onChanged});

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
  }

  @override
  Widget build(BuildContext context) {
    bool isLocked = selected != null;
    Color backgroundColor = Color(0x88d9d9d9);

    if (selected == 'approve') {
      backgroundColor = Color(0xff15C856);
    } else if (selected == 'reject') {
      backgroundColor = Color(0xffFF0004);
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
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text("Reject", style: TextStyle(color: Color(0xff908D8D), fontSize: 12, fontWeight: FontWeight.w600)),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text("Approve", style: TextStyle(color: Color(0xff908D8D), fontSize: 12, fontWeight: FontWeight.w600)),
                ),
              ],
            )
          else
            Text(
              selected == 'approve' ? "Approved" : "Rejected",
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
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset("assets/icons/left_right.svg", width: 16, height: 16,),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

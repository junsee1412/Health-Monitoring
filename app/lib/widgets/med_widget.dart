import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import '../MyColor.dart';

class MedObj {
  String name = 'No data';
  IconData icon = TablerIcons.bolt_off;
  Color color = yellowLatte;
  int value = 0;
  String unit = 'No data';

  MedObj(this.name, this.icon, this.color, this.value, this.unit);
}

class MedWidget extends StatefulWidget{
  final MedObj medObj;

  const MedWidget({
    super.key,
    required this.medObj,
  });

  @override
  State<StatefulWidget> createState() => _MedWidgetState();
}

class _MedWidgetState extends State<MedWidget> {

  refresh() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.medObj.value++;
        // print(widget.medObj.name);
        // print(widget.medObj.value);
        refresh();
      },
      child: Container(
        width: 137,
        height: 120,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Stack(
          children: [
            Opacity(
              opacity: 0.1,
              child: Container(
                decoration: ShapeDecoration(
                  color: widget.medObj.color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  )
                ),
              )
            ),
            Positioned(
              left: 16,
              top: 16,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(widget.medObj.icon, color: widget.medObj.color, size: 16),
                      const SizedBox(width: 7),
                      Text(widget.medObj.name, style: TextStyle(
                        color: widget.medObj.color,
                        fontSize: 16,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      )),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(widget.medObj.value.toString(), style: TextStyle(
                        color: widget.medObj.color,
                        fontSize: 40,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      )),
                      const SizedBox(width: 4),
                      Text(widget.medObj.unit, style: TextStyle(
                        color: widget.medObj.color,
                        fontSize: 16,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ))
                    ]
                  ),
                ],
              ),
            )
          ]
        ),
      ),
    );
  }
}
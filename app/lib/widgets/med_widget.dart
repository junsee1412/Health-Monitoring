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

class MedWidget extends StatelessWidget {
  final MedObj medObj;

  const MedWidget({
    super.key,
    required this.medObj,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: medObj.color,
              ),
            ),
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
                    Icon(medObj.icon, color: medObj.color, size: 32),
                    const SizedBox(width: 7),
                    Text(
                      medObj.name,
                      style: TextStyle(
                        color: medObj.color,
                        fontSize: 16,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16,),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      medObj.value.toString(),
                      style: TextStyle(
                        color: medObj.color,
                        fontSize: 40,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                    const SizedBox(width: 4,),
                    Text(
                      medObj.unit,
                      style: TextStyle(
                        color: medObj.color,
                        fontSize: 16,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

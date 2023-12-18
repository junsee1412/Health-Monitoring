import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:jellyfish/pages/setting.dart';

import '../../MyColor.dart';
import '../../models/user.dart';
import '../../widgets/bar_chart_sample1.dart';

class ProfilePage extends StatelessWidget {
  final User user;
  const ProfilePage({super.key, required this.user });

  @override
  Widget build(BuildContext context) {
    final String name = user.name;
    final int gender = user.gender;
    final int height = user.height;
    final int weight = user.weight;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Setting(isEdit: true,)),
                    );
                  },
                  child: Container(
                      height: 130,
                      decoration: ShapeDecoration(
                          color: blueLatte.withOpacity(0.1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(22.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  width: 85,
                                  height: 85,
                                  decoration: ShapeDecoration(
                                      color: blueLatte.withOpacity(0.1),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      )
                                  ),
                                  child: Icon(
                                    gender == 1 ? Icons.man : Icons.woman,
                                    size: 64,
                                    color: textLatte,
                                  )
                              ),
                              const SizedBox(width: 60),
                              Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(name, style: TextStyle(
                                      color: textLatte,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    )),
                                    Row(
                                        children: [
                                          Text('Height: ', style: TextStyle(
                                            color: textLatte,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          )),
                                          Text('$height cm', style: TextStyle(
                                            color: textLatte,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          )),
                                        ]
                                    ),
                                    Row(
                                        children: [
                                          Text('Weight: ', style: TextStyle(
                                            color: textLatte,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          )),
                                          Text('$weight kg', style: TextStyle(
                                            color: textLatte,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ))
                                        ]
                                    )
                                  ]
                              )
                            ],
                          )
                      )
                  )
              ),
              const SizedBox(height: 10),
              Container(
                height: 200,
                decoration: ShapeDecoration(
                    color: blueLatte.withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )
                ),
                child: const BarChartSample1(),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: ShapeDecoration(
                    color: blueLatte.withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )
                ),
                child: Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: Column(
                      children: List.generate(30, (index) {
                        return Container(
                            height: 72,
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: ShapeDecoration(
                                color: redLatte.withOpacity(0.1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )
                            ),
                            child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(TablerIcons.heart, color: redLatte),
                                      const SizedBox(width: 10),
                                      Text('Heart rate', style: TextStyle(
                                        color: textLatte,
                                        fontSize: 16,
                                      ))
                                    ]
                                )
                            )
                        );
                      })
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
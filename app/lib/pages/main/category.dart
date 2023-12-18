import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:jellyfish/common/bl_interface.dart';
import 'package:jellyfish/pages/bluetooth.dart';
import '../../MyColor.dart';
import '../../widgets/med_widget.dart';

List<MedObj> newLs = [
  MedObj('HR', TablerIcons.heart, redLatte, 75, 'bpm'),
  MedObj('SpO2', TablerIcons.flame, peachLatte, 90, '%'),
  // MedObj('ABP', TablerIcons.device_heart_monitor, lavenderLatte, 5, 'mmHg'),
  // MedObj('RR', TablerIcons.flag, blueLatte, 5, 'bpm'),
];

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> implements BluetoothInterface {

  List<Widget> _buildList(var ls) {
    List<Widget> heartWidget = [];
    for (MedObj item in ls) {
      heartWidget.add(
        MedWidget(
          medObj: item,
        ),
      );
    }
    return heartWidget;
  }
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Bluetooth()),
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
                                  Icons.bluetooth,
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
                                  Text('HC-05', style: TextStyle(
                                    color: textLatte,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  )),
                                  Row(
                                      children: [
                                        Text('MAC: ', style: TextStyle(
                                          color: textLatte,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        )),
                                        Text('00:00:00:00:00:00', style: TextStyle(
                                          color: textLatte,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        )),
                                      ]
                                  ),
                                  Row(
                                      children: [
                                        Text('Connected: ', style: TextStyle(
                                          color: textLatte,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        )),
                                        Text('true', style: TextStyle(
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
          Expanded(
            flex: 1,
            child: Wrap(
                  spacing: 15,
                  runSpacing: 15,
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.center,
                  children: _buildList(newLs),
                ),
          ),
          ],
        ),
      ),
    );
  }

  @override
  void onConnected(BluetoothDevice device) {
    BluetoothConnection.toAddress(device.address).then((connection) {
      connection.input!.listen((data) {
        print(data);
      }).onDone(() {
        print('Disconnecting...');
        connection.dispose();
      });
    });
  }
}
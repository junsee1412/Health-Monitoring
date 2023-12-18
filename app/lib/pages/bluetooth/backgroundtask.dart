import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:scoped_model/scoped_model.dart';

class DataSample {
  final int hr;
  final int spO2;
  final int rr;
  final int abp;

  DataSample({
    required this.hr,
    required this.spO2,
    required this.rr,
    required this.abp,
  });
}

class BackgroundTask extends Model {
  static BackgroundTask of(BuildContext context, {bool rebuild = false}) =>
      ScopedModel.of<BackgroundTask>(context, rebuildOnChange: rebuild);

  final BluetoothConnection connection;
  List<int> _buffer = List<int>.empty(growable: true);
  List<DataSample> samples = List<DataSample>.empty(growable: true);
  bool _inProgress = false;

  BackgroundTask._fromConnection(this.connection) {
    connection.input!.listen((data) {
      int index = data.indexOf('\n'.codeUnitAt(0));
      if (index == -1) {
        _buffer += data;
      } else {
        _buffer += data.sublist(0, index);
        String dataString = String.fromCharCodes(_buffer);
        print(_buffer.length);
        notifyListeners();
        _buffer.clear();
      }
    }).onDone(() {
      _inProgress = false;
      notifyListeners();
    });
  }
  static Future<BackgroundTask> connect(BluetoothDevice device) async {
    final BluetoothConnection connection = await BluetoothConnection.toAddress(device.address);
    return BackgroundTask._fromConnection(connection);
  }
  void dispose() {
    connection.dispose();
  }
}
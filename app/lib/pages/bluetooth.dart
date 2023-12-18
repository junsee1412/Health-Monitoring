import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:jellyfish/MyColor.dart';

import 'package:jellyfish/pages/bluetooth/device_list_entry.dart';

import '../common/bl_interface.dart';

class Bluetooth extends StatefulWidget {
  final bool checkAvailability;
  const Bluetooth({Key? key, this.checkAvailability = true}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Bluetooth();
}

enum _DeviceAvailability {
  maybe,
  yes,
}
class _DeviceWithAvailability {
  BluetoothDevice device;
  _DeviceAvailability availability;
  int? rssi;

  _DeviceWithAvailability(this.device, this.availability, [this.rssi]);
}

class _Bluetooth extends State<Bluetooth> {
  StreamSubscription<BluetoothDiscoveryResult>? _streamSubscription;
  List<_DeviceWithAvailability> devices = List<_DeviceWithAvailability>.empty(growable: true);
  bool isDiscovering = false;

  BluetoothInterface bluetoothInterface = BluetoothInterface();

  @override
  void initState() {
    super.initState();
    isDiscovering = widget.checkAvailability;
    if (isDiscovering) {
      _startDiscovery();
    }
    FlutterBluetoothSerial.instance.getBondedDevices().then(((List<BluetoothDevice> bondedDevices) {
      setState(() {
        devices = bondedDevices
            .map((device) => _DeviceWithAvailability(
          device,
          widget.checkAvailability ? _DeviceAvailability.maybe : _DeviceAvailability.yes,
        ),
        ).toList();
      });
    }));
  }

  void _restartDiscovery() {
    setState(() {
      isDiscovering = true;
    });
    _startDiscovery();
  }
  void _startDiscovery() {
    _streamSubscription =
    FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
      setState(() {
        Iterator i = devices.iterator;
        while (i.moveNext()) {
          var device = i.current;
          if (device.device == r.device) {
            device.availability = _DeviceAvailability.yes;
            device.rssi = r.rssi;
          }
        }
      });
    });
    _streamSubscription?.onDone(() {
      setState(() {
        isDiscovering = false;
      });
    });
  }
  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<BluetoothDeviceListEntry> list = devices.map((device) => BluetoothDeviceListEntry(
      device: device.device,
      rssi: device.rssi,
      enabled: device.availability == _DeviceAvailability.yes,
      onTap: () {
        bluetoothInterface.onConnected(device.device);
        Navigator.of(context).pop(device.device);
      },
      // onLongPress: () {},
    )).toList();
    return Scaffold(
      appBar: AppBar(
        title: isDiscovering
            ? const Text('Discovering devices')
            : const Text('Discovered devices'),
        actions: [
          isDiscovering
          ? FittedBox(
            child: Container(
              margin: const EdgeInsets.all(16.0),
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(baseLatte),
              ),
            ),
          )
          : IconButton(
            icon: const Icon(Icons.replay),
            onPressed: _restartDiscovery,
          ),
        ],
      ),
      body: ListView(children: list),
    );
  }
}
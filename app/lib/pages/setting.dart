import 'package:flutter/material.dart';
import 'package:jellyfish/common/db_provider.dart';
import 'package:jellyfish/main.dart';
import 'package:jellyfish/widgets/custome_radio.dart';
import '../MyColor.dart';
import '../models/user.dart';

class Setting extends StatefulWidget {
  final bool isEdit;
  const Setting({Key? key, required this.isEdit}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _SettingState();
}
class _SettingState extends State<Setting> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  double _heightValue = 150;
  double _weightValue = 60;
  int? _id;
  @override
  void initState() {
    fetchUser();
    super.initState();
  }
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }
  List<RadioModel> sampleData = [
    RadioModel(true, 'Male', Icons.man),
    RadioModel(false, 'Female', Icons.woman),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Information'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name', style: TextStyle(
                      color: textLatte,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    )),
                    TextField(
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        fillColor: baseLatte.withOpacity(0.1),
                        border: InputBorder.none,
                        filled: true,
                        hintText: 'Your Name',
                        hintStyle: TextStyle(
                          color: textLatte,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Age', style: TextStyle(
                      color: textLatte,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    )),
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: _ageController,
                      decoration: InputDecoration(
                        fillColor: baseLatte.withOpacity(0.1),
                        border: InputBorder.none,
                        filled: true,
                        hintText: 'Your Age',
                        hintStyle: TextStyle(
                          color: textLatte,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Gender', style: TextStyle(
                      color: textLatte,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    )),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              sampleData[0].isSelected = true;
                              sampleData[1].isSelected = false;
                            });
                          },
                          child: RadioItem(sampleData[0]),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              sampleData[0].isSelected = false;
                              sampleData[1].isSelected = true;
                            });
                          },
                          child: RadioItem(sampleData[1]),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Height', style: TextStyle(
                      color: textLatte,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    )),
                    Text(
                      '$_heightValue cm',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: textLatte,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Slider(
                      value: _heightValue,
                      min: 50,
                      max: 250,
                      divisions: 200,
                      activeColor: overlay1Latte,
                      // label: '$_heightValue cm',
                      onChanged: (double value) {
                        setState(() {
                          _heightValue = value;
                        });
                      }
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            '50 cm',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: textLatte,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const Expanded(
                          flex: 3,
                          child: SizedBox(),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '250 cm',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: textLatte,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        )
                      ],
                    )
                  ]
                ),
                Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Weight', style: TextStyle(
                        color: textLatte,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      )),
                      Text(
                        '$_weightValue kg',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: textLatte,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Slider(
                          value: _weightValue,
                          min: 20,
                          max: 250,
                          divisions: 230,
                          activeColor: overlay1Latte,
                          // label: '$_weightValue kg',
                          onChanged: (double value) {
                            setState(() {
                              _weightValue = value;
                            });
                          }
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              '20 kg',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: textLatte,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          const Expanded(
                            flex: 3,
                            child: SizedBox(),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              '250 kg',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: textLatte,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          )
                        ],
                      )
                    ]
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          User row = User(
            id: _id,
            name: _nameController.text,
            age: int.parse(_ageController.text),
            gender: sampleData[0].isSelected ? 1 : 0,
            height: _heightValue.toInt(),
            weight: _weightValue.toInt(),
          );
          if (widget.isEdit) {
            DBProvider.updateUser(row);
          } else {
            DBProvider.insertUser(row);
          }
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MyHomePage(user: row,)),
          );
        },
        backgroundColor: overlay1Latte,
        child: Icon(Icons.save, color: textLatte),
      ),
    );
  }
  void fetchUser() async {
    List<User>? users = await DBProvider.getUsers();
    if (users != null) {
      setState(() {
        _id = users[0].id;
        _nameController.text = users[0].name;
        _ageController.text = users[0].age.toString();
        if (users[0].gender == 0) {
          sampleData[0].isSelected = false;
          sampleData[1].isSelected = true;
        } else {
          sampleData[0].isSelected = true;
          sampleData[1].isSelected = false;
        }
        _heightValue = users[0].height.toDouble();
        _weightValue = users[0].weight.toDouble();
      });
    }
  }
}
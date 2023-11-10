import 'package:flutter/cupertino.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import '../MyColor.dart';
import '../widgets/med_widget.dart';

List<MedObj> newLs = [
  MedObj('Heart rate', TablerIcons.heart, redLatte, 75, 'bpm'),
  MedObj('SpO2', TablerIcons.flame, peachLatte, 90, '%'),
  MedObj('Resting', TablerIcons.flag, blueLatte, 5, 'hrs'),
];

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

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
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Center(
              child: FractionallySizedBox(
                widthFactor: 0.8,
                child: Wrap(
                  spacing: 2,
                  runSpacing: 4,
                  direction: Axis.vertical,
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.start,
                  children: [
                    Text('Hello', style: TextStyle(
                      color: textLatte,
                      fontSize: 40,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w500,
                    )),
                    const SizedBox(height: 4),
                    Text('Junsee', style: TextStyle(
                      color: textLatte,
                      fontSize: 48,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w700,
                    ))
                  ]
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child:
              Center(
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.center,
                  children: _buildList(newLs),
                ),
              ),
          ),
          const Expanded(
            flex: 2, child: SizedBox(),
          )
        ],
      ),
    );
  }
}
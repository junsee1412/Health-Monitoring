import 'package:flutter/cupertino.dart';
import '../MyColor.dart';

class RadioItem extends StatelessWidget {
  final RadioModel _item;
  const RadioItem(this._item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 12.0),
            child: Container(
              width: 132,
              height: 132,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: _item.isSelected ? overlay0Latte : overlay0Latte.withOpacity(0.1),
              ),
              child: Icon(
                _item.icon,
                color: textLatte,
                size: 85,
              ),
            ),
          ),
          Text(_item.buttonText),
        ],
      ),
    );
  }
}


class RadioModel {
  bool isSelected;
  final String buttonText;
  final IconData icon;

  RadioModel(this.isSelected, this.buttonText, this.icon);
}
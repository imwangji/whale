import 'package:flutter/cupertino.dart';
import 'package:whale/component/base_padding.dart';

// ignore: must_be_immutable
class TextLabelArrow extends StatefulWidget {
  String text;
  String label;
  Function onTap;
  TextLabelArrow({
    @required String text,
    @required String label,
    Function onTap
  }) {
    this.text = text;
    this.label = label;
    this.onTap = onTap;
  }

  @override
  _TextLabelArrowState createState() => _TextLabelArrowState();
}

class _TextLabelArrowState extends State<TextLabelArrow> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.widget.onTap,
      child: Container(
        color: CupertinoColors.white,
        child: BasePadding(
          child: Row(
            children: [
              Expanded(
                child: Text(this.widget.text),
              ),
              Padding(
                padding: EdgeInsets.only(right: 12, left: 12),
                child: Text(
                  this.widget.label,
                  style: TextStyle(
                    color: CupertinoColors.secondaryLabel,
                  ),
                ),
              ),
              Icon(
                CupertinoIcons.right_chevron,
                size: 16,
                color: CupertinoColors.systemGrey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

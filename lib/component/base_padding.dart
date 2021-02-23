import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BasePadding extends StatelessWidget {
  Widget child;
  BasePadding({child}){
    this.child = child;
  }
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(16),child: this.child,);
  }
}

import 'package:bloc_getit_sample/bloc/word_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CountLabel extends StatefulWidget {
  @override
  CountLabelState createState() {
    return CountLabelState();
  }
}

class CountLabelState extends State<CountLabel> {
  int favoriteCount;
  @override
  void initState() {
    super.initState();
    GetIt.I<WordBloc>().itemCount.listen((count) {
      setState(() {
        favoriteCount = count;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      favoriteCount.toString(),
      style: new TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 35.0, //目立つようにでかくしてある
          color: Colors.pink),
    );
  }
}

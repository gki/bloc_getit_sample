import 'package:bloc_getit_sample/bloc/word_bloc.dart';
import 'package:bloc_getit_sample/widgets/bloc_favorite_page.dart';
import 'package:bloc_getit_sample/widgets/random_words_home_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void main() {
  _setup();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      theme: new ThemeData(primaryColor: Colors.white),
      home: RandomWordsHomePage(),
      routes: <String, WidgetBuilder>{
        // 「./favorite」に、BlocFavoritePageを登録
        BlocFavoritePage.routeName: (context) => BlocFavoritePage()
      },
    );
  }
}

_setup() {
  GetIt.I.registerSingleton<WordBloc>(WordBloc());
}

import 'package:bloc_getit_sample/bloc/word_provider.dart';
import 'package:bloc_getit_sample/widgets/bloc_favorite_page.dart';
import 'package:bloc_getit_sample/widgets/random_words_home_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WordProvider(
      child: MaterialApp(
        title: 'Startup Name Generator',
        theme: new ThemeData(primaryColor: Colors.white),
        home: RandomWordsHomePage(),
        routes: <String, WidgetBuilder>{
          // 「./favorite」に、BlocFavoritePageを登録
          BlocFavoritePage.routeName: (context) => BlocFavoritePage()
        },
      ),
    );
  }
}

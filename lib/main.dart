import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/blocs/newsbloc/news_bloc.dart';
import 'package:weatherapp/blocs/newsbloc/news_state.dart';
import 'package:weatherapp/repository/news_repository.dart';
import 'package:weatherapp/views/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:[
            BlocProvider<NewsBloc>(create: (context)=> NewsBloc(
              initialState:NewsInitState(), newsRepository: NewsRepository()),
            )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          textTheme: GoogleFonts.latoTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: SplashScreen(),
      ),
    );
  }
}

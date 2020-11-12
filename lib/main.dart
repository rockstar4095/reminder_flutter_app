import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder_flutter_app/bloc/main_bloc/main_bloc.dart';
import 'package:reminder_flutter_app/screens/mainscreen/main_screen.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBlocProvider(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MainScreen(),
      ),
    );
  }
}

class AppBlocProvider extends StatelessWidget {
  final Widget child;

  AppBlocProvider({this.child});

  @override
  Widget build(BuildContext context) {
    Widget provider = BlocProvider(
      create: (context) => MainBloc(),
      child: child,
    );

    return provider;
  }
}

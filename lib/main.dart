import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:reminder_flutter_app/bloc_builder.dart';
import 'package:reminder_flutter_app/repository_builder.dart';
import 'package:reminder_flutter_app/screens/mainscreen/main_screen.dart';

import 'entity/reminder_entity.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHive();
  runApp(App());
}

Future<void> initHive() async {
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(ReminderEntityAdapter());
}

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
      create: (context) => Blocs.mainBloc(context),
      child: child,
    );

    provider = RepositoryProvider(
      create: (context) => Repositories.mainRepository(),
      child: provider,
    );

    return provider;
  }
}

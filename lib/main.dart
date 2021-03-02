import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:reminder_flutter_app/app_theme.dart';
import 'package:reminder_flutter_app/bloc/main/main_bloc.dart';
import 'package:reminder_flutter_app/bloc/viewreminder/view_reminder_bloc.dart';
import 'package:reminder_flutter_app/bloc_builder.dart';
import 'package:reminder_flutter_app/entity/product_entity.dart';
import 'package:reminder_flutter_app/generated/l10n.dart';
import 'package:reminder_flutter_app/repository/main_repository.dart';
import 'package:reminder_flutter_app/repository_builder.dart';
import 'package:reminder_flutter_app/screens/mainscreen/main_screen.dart';
import 'package:reminder_flutter_app/utils/notifications.dart';
import 'package:reminder_flutter_app/utils/wakelock.dart';

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
  Hive.registerAdapter(ProductEntityAdapter());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBlocProvider(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: lightTheme,
        localizationsDelegates: _localizationDelegates,
        supportedLocales: S.delegate.supportedLocales,
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
    Widget provider = MultiBlocProvider(
      providers: [
        BlocProvider<ViewReminderBloc>(
          create: (context) => Blocs.viewReminderBloc(context),
        ),
        BlocProvider<MainBloc>(
          create: (context) => Blocs.mainBloc(context),
        )
      ],
      child: child,
    );

    provider = RepositoryProvider<MainRepository>(
      create: (context) => Repositories.mainRepository(),
      child: provider,
    );

    provider = RepositoryProvider<WakeLock>(
      create: (context) => Repositories.wakeLock(),
      child: provider,
    );

    provider = RepositoryProvider<Notifications>(
      create: (context) => Repositories.notifications(),
      child: provider,
    );

    return provider;
  }
}

final List<LocalizationsDelegate<dynamic>> _localizationDelegates = [
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
  S.delegate,
];

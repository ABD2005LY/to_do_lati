import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_lati/screens/home_screen.dart';
import 'package:to_do_lati/providers/tasks_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do_lati/providers/dark_mode_provider.dart';
import 'package:to_do_lati/providers/localization_provicder.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TasksProvider>(
            create: (context) => TasksProvider()..getTasks()),
        ChangeNotifierProvider<DarkModeProvider>(
            create: (context) => DarkModeProvider()..getMode()),
        ChangeNotifierProvider<LocalizationProvider>(
            create: (context) => LocalizationProvider()..getlanguage())
      ],
      child:
          Consumer<DarkModeProvider>(builder: (context, darkModeConsumer, _) {
        return Consumer<LocalizationProvider>(
            builder: (context, _languageConsumer, _) {
          return MaterialApp(
            locale: Locale(_languageConsumer.language ?? "en"),
            localizationsDelegates: [
              AppLocalizations.delegate, // Add this line
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              Locale('en'), // English
              Locale('es'), // Spanish
              Locale('ar'),
            ],
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              dividerTheme: DividerThemeData(
                color:
                    darkModeConsumer.isDark ? Colors.white24 : Colors.black26,
              ),
              tabBarTheme: TabBarTheme(
                  labelColor:
                      darkModeConsumer.isDark ? Colors.white : Colors.blueGrey),
              appBarTheme: const AppBarTheme(
                  centerTitle: true, backgroundColor: Colors.blue),
              drawerTheme: DrawerThemeData(
                  backgroundColor:
                      darkModeConsumer.isDark ? Colors.black : Colors.white),
              scaffoldBackgroundColor:
                  darkModeConsumer.isDark ? Colors.black : Colors.white,
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
              useMaterial3: false,
            ),
            home: const HomeScreen(),
          );
        });
      }),
    );
  }
}

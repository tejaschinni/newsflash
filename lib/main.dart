import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:newsflash/provider/news_provider.dart';
import 'package:newsflash/provider/theme_provider.dart';
import 'package:newsflash/router/router.dart';
import 'package:newsflash/utils/themes.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: EasyLocalization(
        supportedLocales: const [Locale('en', 'US'), Locale('es', 'ES')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en', 'US'),
        child: const MyApp(),
      )));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeprovider, _) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => NewsProvider(),
          )
        ],
        child: MaterialApp.router(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          title: 'Flutter Demo',
          themeMode:
              themeprovider.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          routerConfig: AppRouter.router,
        ),
      );
    });
  }
}

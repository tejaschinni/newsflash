import 'package:go_router/go_router.dart';
import 'package:newsflash/model/news_model.dart';
import 'package:newsflash/screens/home_screen.dart';
import 'package:newsflash/screens/news_detail_screen.dart';
import 'package:newsflash/screens/setting_screen.dart';

class RequiredArguments {
  NewDetailArgus? detailArgus;
  RequiredArguments({this.detailArgus});
}

class NewDetailArgus {
  int? index;
  List<NewsModel>? allNews;
  NewDetailArgus({this.allNews, this.index});
}

class AppRouter {
  static final router = GoRouter(initialLocation: '/', routes: [
    GoRoute(
        path: '/',
        builder: ((context, state) => const HomeScreen()),
        routes: [
          GoRoute(
              path: 'newDetail',
              builder: ((context, state) {
                final argus = state.extra as RequiredArguments;
                final detail = argus.detailArgus;
                return NewsDetailScreen(
                  arguments: detail!,
                );
              })),
          GoRoute(
              path: 'setting',
              builder: ((context, state) {
                return const SettingScreen();
              }))
        ]),
  ]);
}

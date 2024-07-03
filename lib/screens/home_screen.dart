import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newsflash/model/news_model.dart';
import 'package:newsflash/provider/news_provider.dart';
import 'package:newsflash/widgets/home_widgets/all_new_widget.dart';
import 'package:newsflash/widgets/home_widgets/top_newswidget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<NewsProvider>(context, listen: false).getTopNews();
    Provider.of<NewsProvider>(context, listen: false).getAllNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr('NewsFlash'),
          style: themeData.textTheme.displayLarge,
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                context.go('/setting');
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      body: Consumer<NewsProvider>(builder: (context, provder, _) {
        List<NewsModel> section1 = provder.allNews.take(10).toList();
        List<NewsModel> section2 = provder.allNews.skip(10).toList();
        return provder.allStatus == AllNewsStatus.loading ||
                provder.allStatus == AllNewsStatus.initial
            ? const CircularProgressIndicator()
            : provder.topStatus == TopNewsStatus.success
                ? SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          provder.allStatus != AllNewsStatus.noNews
                              ? TopNewsWidget(newslist: section1)
                              : const Text("No News"),
                          const SizedBox(
                            height: 15,
                          ),
                          provder.allStatus == AllNewsStatus.success
                              ? AllNewsWidget(
                                  newslist: section2,
                                )
                              : const SizedBox()
                        ],
                      ),
                    ),
                  )
                : const Text("Something went wrong");
      }),
    );
  }
}

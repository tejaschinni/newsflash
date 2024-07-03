import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:newsflash/model/news_model.dart';
import 'package:newsflash/widgets/shared_widgets/new_article_widget.dart';

class AllNewsWidget extends StatelessWidget {
  List<NewsModel> newslist;
  AllNewsWidget({super.key, required this.newslist});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.tr("News"),
                style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 24),
              ),
            ],
          ),
        ),
        SizedBox(
          child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: newslist.length,
              itemBuilder: (context, index) {
                return NewsArticleTile(
                  news: newslist[index],
                  allNews: newslist,
                  currentindex: index,
                );
              }),
        )
      ],
    );
  }
}

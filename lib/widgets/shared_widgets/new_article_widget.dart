import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:newsflash/model/news_model.dart';
import 'package:newsflash/router/router.dart';

// ignore: must_be_immutable
class NewsArticleTile extends StatelessWidget {
  final NewsModel? news;
  final List<NewsModel> allNews;
  int currentindex;
  NewsArticleTile(
      {super.key,
      required this.allNews,
      required this.news,
      required this.currentindex});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go("/newDetail",
            extra: RequiredArguments(
                detailArgus:
                    NewDetailArgus(allNews: allNews, index: currentindex)));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
        margin: const EdgeInsets.only(top: 15, left: 0, right: 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Left part: Image
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  imageUrl: news!.urlToImage.toString(),
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  errorWidget: (context, error, stackTrace) {
                    return Container(
                      width: 100,
                      height: 100,
                      color: Colors.black12,
                      child: const Icon(Icons.error_outline, size: 30),
                    );
                  },
                )),
            const SizedBox(width: 6),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    news!.title.toString(),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          news!.author.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                          // style: const TextStyle(
                          //     fontSize: 12.5, color: Colors.grey),
                        ),
                      ),
                      Text(
                        DateFormat("MMMM dd yyyy").format(news!.publishedAt!),
                        style:
                            const TextStyle(fontSize: 12.5, color: Colors.grey),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newsflash/model/news_model.dart';
import 'package:newsflash/router/router.dart';

class TopNewsWidget extends StatefulWidget {
  List<NewsModel> newslist;
  TopNewsWidget({super.key, required this.newslist});

  @override
  State<TopNewsWidget> createState() => _TopNewsWidgetState();
}

class _TopNewsWidgetState extends State<TopNewsWidget> {
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.tr("Top Headlines"),
                style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 24),
              ),
            ],
          ),
        ),
        CarouselSlider.builder(
          itemCount: widget.newslist.length,
          options: CarouselOptions(
            height: MediaQuery.of(context).size.width > 850
                ? MediaQuery.of(context).size.height * 0.42
                : MediaQuery.of(context).size.height * 0.45,
            enlargeCenterPage: false,
            autoPlay: false,
            viewportFraction: 0.7,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
          itemBuilder: (context, index, realIndex) {
            NewsModel currentNews = widget.newslist[index];

            return InkWell(
              onTap: () {
                context.go("/newDetail",
                    extra: RequiredArguments(
                        detailArgus: NewDetailArgus(
                            allNews: widget.newslist, index: index)));
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: CachedNetworkImage(
                        imageUrl: currentNews.urlToImage.toString(),
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).size.height * 0.27,
                        fit: BoxFit.cover,
                        errorWidget: (context, error, stackTrace) {
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.black12,
                            child: const Icon(Icons.error_outline, size: 30),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.65,
                      child: Text(
                        currentNews.title.toString(),
                        maxLines: 2,
                        // style: MyTheme.myTheme.textTheme.displayMedium,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.65,
                      child: Text(currentNews.author.toString()),
                    )
                  ],
                ),
              ),
            );
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.newslist.map((NewsModel currentPost) {
            int index = widget.newslist.indexOf(currentPost);
            return Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: index == _current
                    ? const Color.fromARGB(214, 1, 0, 2)
                    : const Color.fromARGB(107, 107, 54, 137),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

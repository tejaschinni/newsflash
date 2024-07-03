import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newsflash/model/news_model.dart';

class PageWidget extends StatefulWidget {
  final NewsModel news;
  final ScrollController scrollController;
  const PageWidget(
      {super.key, required this.news, required this.scrollController});

  @override
  State<PageWidget> createState() => _PageWidgetState();
}

class _PageWidgetState extends State<PageWidget> {
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final h = MediaQuery.sizeOf(context).height;
    return Scrollbar(
      controller: widget.scrollController,
      thickness: 6.5,
      interactive: true,
      thumbVisibility: true,
      radius: const Radius.circular(20),
      child: ListView(
        controller: widget.scrollController,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.news.title.toString(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    height: 1,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Text(
                      "By ",
                      // style: MyTheme.myTheme.textTheme.displaySmall,
                    ),
                    Text(
                      widget.news.author.toString(),
                    ),
                    SizedBox(
                      width: w * 0.05,
                    ),
                    Text(
                      DateFormat("MMMM dd yyyy")
                          .format(widget.news.publishedAt!),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: widget.news.urlToImage != null
                      ? CachedNetworkImage(
                          imageUrl: widget.news.urlToImage.toString(),
                          // height: MediaQuery.of(context).size.height * 0.32,
                          width: MediaQuery.of(context).size.width,
                          // fit: BoxFit.fill,

                          errorWidget: (context, error, stackTrace) {
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.3,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.black12,
                              child: const Icon(Icons.error_outline, size: 30),
                            );
                          },
                        )
                      : Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.black12,
                          child: const Icon(Icons.photo, size: 40),
                        ),
                ),
                SizedBox(height: h * 0.01),
                Text(
                  widget.news.description.toString(),
                  style: const TextStyle(
                    fontSize: 18,
                    // fontWeight: FontWeight.w600,
                    height: 1,
                  ),
                ),
                SizedBox(height: h * 0.08),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

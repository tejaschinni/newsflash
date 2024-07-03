import 'package:flutter/material.dart';
import 'package:newsflash/router/router.dart';
import 'package:newsflash/widgets/news_detail_widget/page_widget.dart';

class NewsDetailScreen extends StatefulWidget {
  NewDetailArgus? arguments;
  NewsDetailScreen({super.key, this.arguments});

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  late final PageController _pageController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: widget.arguments!.index!);
  }

  void _resetScrollPosition() {
    _scrollController.jumpTo(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Detail Screen '),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: PageView.builder(
            controller: _pageController,
            onPageChanged: (val) {
              setState(() {
                widget.arguments!.index = val;
              });

              _resetScrollPosition();
            },
            itemCount: widget.arguments!.allNews!.length,
            itemBuilder: (context, index) {
              index = widget.arguments!.index!;
              return PageWidget(
                news: widget.arguments!.allNews![index],
                scrollController: _scrollController,
              );
            }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.arguments!.index! > 0
              ? FloatingActionButton(
                  heroTag: 'floatingActionButtonLeft',
                  onPressed: widget.arguments!.index! > 0
                      ? () {
                          setState(() {
                            widget.arguments!.index =
                                widget.arguments!.index! - 1;
                          });
                          _resetScrollPosition();
                        }
                      : null,
                  child: const Icon(Icons.chevron_left_rounded),
                )
              : const SizedBox.shrink(),
          const SizedBox(width: 20),
          widget.arguments!.allNews!.length - 1 != widget.arguments!.index
              ? FloatingActionButton(
                  heroTag: 'floatingActionButtonRight',
                  onPressed: () {
                    setState(() {
                      widget.arguments!.index = widget.arguments!.index! + 1;
                    });
                    _resetScrollPosition();
                  },
                  child: const Icon(Icons.chevron_right_rounded),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}

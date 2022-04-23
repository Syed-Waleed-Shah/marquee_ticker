import 'package:flutter/material.dart';

class MarqueeTicker extends StatefulWidget {
  final Widget Function(BuildContext, int) itemBuilder;
  final Axis scrollDirection;
  final int itemCount;
  final EdgeInsets? padding;
  final bool repeat;
  final int speed;
  final double height;
  final Color? color;
  const MarqueeTicker(
      {Key? key,
      required this.itemBuilder,
      required this.itemCount,
      required this.height,
      this.color,
      this.padding,
      this.repeat = true,
      this.speed = 10,
      this.scrollDirection = Axis.horizontal})
      : super(key: key);

  @override
  State<MarqueeTicker> createState() => _MarqueeTickerState();
}

class _MarqueeTickerState extends State<MarqueeTicker> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollList();
  }

  Future<void> scrollList({Duration? delay}) async {
    Future.delayed(delay ?? const Duration(seconds: 1)).then((value) {
      _scrollController
          .animateTo(_scrollController.position.maxScrollExtent,
              duration: Duration(seconds: widget.itemCount * widget.speed),
              curve: Curves.linear)
          .then(
        (value) {
          if (widget.repeat) {
            Future.delayed(const Duration(seconds: 1)).then((value) {
              if (_scrollController.offset >=
                  _scrollController.position.maxScrollExtent) {
                _scrollController.jumpTo(0);
              }
              scrollList(delay: const Duration(milliseconds: 500));
            });
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      color: widget.color,
      child: ListView.builder(
        controller: _scrollController,
        itemCount: widget.itemCount,
        scrollDirection: widget.scrollDirection,
        padding: widget.padding,
        itemBuilder: widget.itemBuilder,
      ),
    );
  }
}

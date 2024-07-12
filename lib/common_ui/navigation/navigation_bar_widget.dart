import 'package:flutter/material.dart';
import 'package:flutter_demo/common_ui/navigation/navigation_bar_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NavigationBarWidget extends StatefulWidget {

  //页面数组
  final List<Widget> pages;

  //底部标题数组
  final List<String> labels;

  //导航栏的icon数组：切换前
  final List<Widget> icons;

  //导航栏的icon数组：切换后
  final List<Widget> activeIcons;

  final ValueChanged<int>? onTabChange;

  int? currentIndex;

  NavigationBarWidget({super.key, required this.pages, required this.labels, required this.icons, required this.activeIcons, this.onTabChange, this.currentIndex, }) {
    if (pages.length != labels.length ||
        pages.length != icons.length ||
        pages.length != activeIcons.length) {
      throw Exception("数组长度必须保持一致");
    }
  }

  @override
  State<NavigationBarWidget> createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: IndexedStack(
            index: widget.currentIndex,
            children: widget.pages,
          ),
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 0.5.w,
              color: Colors.grey,
            ),
            Theme(
              child: BottomNavigationBar(
                items: _barItemList(),
                currentIndex: widget.currentIndex ?? 0,
                type: BottomNavigationBarType.fixed,
                selectedLabelStyle: TextStyle(fontSize: 14.sp, color: Colors.black),
                unselectedLabelStyle: TextStyle(fontSize: 12.sp, color: Colors.blueGrey),
                onTap: (value) {
                  setState(() {
                    widget.currentIndex = value;
                    widget.onTabChange?.call(value);
                  });
                },
              ),
              data: Theme.of(context).copyWith(splashColor: Colors.transparent, highlightColor: Colors.transparent,),
            )
          ],
        )
    );
  }

  List<BottomNavigationBarItem> _barItemList() {
    List<BottomNavigationBarItem> items = [];

    for (int i = 0; i < widget.pages.length; i++) {
      items.add(BottomNavigationBarItem(
          icon: widget.icons[i],
          activeIcon: NavigationBarItem(builder: (context) {
            return widget.activeIcons[i];
          },
          ),
          label: widget.labels[i]));
    }
    return items;
  }
}

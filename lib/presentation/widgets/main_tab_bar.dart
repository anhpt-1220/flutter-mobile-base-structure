import 'package:animator/animator.dart';
import 'package:flutter/material.dart';
import 'package:base/presentation/resources/icons/app_images.dart';
import 'package:base/presentation/styles/styles.dart';
import 'package:rxdart/rxdart.dart';

import 'app_widgets.dart';

class MainTabBar extends StatefulWidget {
  final double height;
  final double topRightRadius;
  final List<TabbarItem> items;
  final TabbarItem initSelected;
  final Function onItemClicked;
  final Color highlightColor;

  MainTabBar({
    @required this.items,
    this.height = 60,
    this.topRightRadius = 0,
    this.onItemClicked,
    this.highlightColor = Colors.white,
    @required this.initSelected,
  });

  @override
  State<StatefulWidget> createState() => MainTabBarState();
}

class MainTabBarState extends State<MainTabBar> {
  final _selectedItemController = BehaviorSubject<TabbarItem>();
  TabbarItem selectedItem;

  @override
  void initState() {
    super.initState();
    selectedItem = widget.initSelected;
  }

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      shadows: [
        BoxShadow(
          offset: Offset(0.0, -3.0),
          color: AppColors.lightGrey,
        ),
      ],
      height: this.widget.height,
      backgroundColor: AppColors.white,
      topRightRadius: this.widget.topRightRadius,
      child: _buildListItem(),
    );
  }

  _buildListItem() {
    List<Widget> listItem =
        this.widget.items.map((item) => _buildItem(item)).toList();
    return Padding(
      padding: const EdgeInsets.only(
        left: 0,
        right: 0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: listItem,
      ),
    );
  }

  Widget _buildItem(TabbarItem item) {
    return _buildItemIcon(item);
  }

  _buildItemIcon(TabbarItem item) {
    return Expanded(
      child: StreamBuilder<TabbarItem>(
          stream: _selectedItemController.stream,
          builder: (context, snapshot) {
            final selected =
                item.type == (selectedItem?.type ?? TabbarItemType.none);
            final icon = selected ? item.selectedIcon : item.unselectedIcon;

            final button = ImageButton(
              58,
              58,
              () {
                _updateSelectedItem(item);
                if (widget.onItemClicked != null) widget.onItemClicked(item);
              },
              icon,
              iconColor: selected ? widget.highlightColor : Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              iconHeight: 25,
              iconWidth: 25,
              boxfit: BoxFit.contain,
            );
            return selected
                ? Column(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          color: this.widget.highlightColor,
                          height: 2,
                        ),
                      ),
                      _buildAnimator(button)
                    ],
                  )
                : button;
          }),
    );
  }

  _buildItemBadgetNumber(TabbarItem item) {
    return Positioned(
        top: 10,
        right: 10,
        child: Container(
            // width: 15,
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Text('99+',
                    style: getTextStyle(
                        color: AppColors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.w300)),
              ),
            ),
            height: 15,
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(10)))));
  }

  _updateSelectedItem(TabbarItem item) {
    selectedItem = item;
    _selectedItemController.add(item);
  }

  _buildAnimator(Widget child) {
    return Animator(
        duration: Duration(milliseconds: 300),
        tween: Tween<double>(begin: 0.8, end: 1.0),
        builder: (anim) => Transform.scale(
              scale: anim.value,
              child: child,
            ));
  }
}

enum TabbarItemType { home, wallet, notification, setting, none }

class TabbarItem {
  int index = -1;
  TabbarItemType type = TabbarItemType.none;
  AssetImage selectedIcon;
  AssetImage unselectedIcon;
  TabbarItem({this.type, this.selectedIcon, this.unselectedIcon, this.index});
}

getDefaultTabItems() {
  List<TabbarItem> items = [];
  items.add(TabbarItem(
      index: 0,
      type: TabbarItemType.home,
      selectedIcon: AppImages.iconSelectednHome,
      unselectedIcon: AppImages.icoUnselectednHome));
  items.add(TabbarItem(
      index: 1,
      type: TabbarItemType.wallet,
      selectedIcon: AppImages.iconSelectedWallet,
      unselectedIcon: AppImages.iconUnselectedWallet));
  items.add(TabbarItem(
      index: 2,
      type: TabbarItemType.notification,
      selectedIcon: AppImages.iconSelectedNotification,
      unselectedIcon: AppImages.iconUnselectedNotification));
  items.add(TabbarItem(
      index: 3,
      type: TabbarItemType.setting,
      selectedIcon: AppImages.iconSelectedSetting,
      unselectedIcon: AppImages.iconUnselectedSetting));
  return items;
}

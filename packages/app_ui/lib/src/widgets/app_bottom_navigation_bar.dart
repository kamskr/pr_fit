// ignore_for_file: public_member_api_docs,

import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppMenuItem {
  const AppMenuItem({
    required this.icon,
    required this.label,
  });

  final Widget icon;
  final String label;
}

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({
    required this.menuItems,
    required this.currentIndex,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final List<AppMenuItem> menuItems;
  final int currentIndex;
  final void Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: menuItems
          .map(
            (menuItem) => BottomNavigationBarItem(
              icon: menuItem.icon,
              label: menuItem.label,
            ),
          )
          .toList(),
      selectedItemColor: context.colorScheme.onBackground,
      unselectedItemColor: context.colorScheme.onBackground.withOpacity(0.5),
      currentIndex: currentIndex,
      onTap: (index) {
        HapticFeedback.lightImpact();
        onTap.call(index);
      },
    );
  }
}

import 'package:bank/properties.dart';
import 'package:flutter/material.dart';

class BottomBarItem {
  String? label;
  IconData? icon;
  Function? action;

  BottomBarItem({this.label, this.icon, this.action});
}

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    var bottomItems = Properties.getBottomBarItems();
    return Container(
      height: 100,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Properties.mainColor.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: Offset.zero,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(bottomItems.length, (index) {
          BottomBarItem bottomItem = bottomItems[index];

          return Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              highlightColor: Properties.mainColor.withValues(alpha: 0.2),
              splashColor: Properties.mainColor.withValues(alpha: 0.1),
              onTap: () {
                bottomItem.action!;
              },
              child: Container(
                constraints: BoxConstraints(minWidth: 80),
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      bottomItem.icon,
                      color: Properties.mainColor,
                      size: 20,
                    ),
                    Text(
                      bottomItem.label!,
                      style: TextStyle(
                        color: Properties.mainColor,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

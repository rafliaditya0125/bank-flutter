import 'package:bank/properties.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Function? onTap;
  final String? label;
  final bool? enabled;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? labelColor;

  const Button({
    super.key,
    this.label,
    this.onTap,
    this.enabled = true,
    this.icon,
    this.backgroundColor = Properties.mainColor,
    this.iconColor = Properties.backgroundColor,
    this.labelColor = Properties.backgroundColor,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Material(
            color: enabled!
                ? backgroundColor
                : backgroundColor!.withValues(alpha: 0.5),
            child: InkWell(
              onTap: enabled!
                  ? () {
                      onTap!();
                    }
                  : null,
              highlightColor: Colors.white.withValues(alpha: 0.2),
              splashColor: Colors.white.withValues(alpha: 0.1),
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: icon != null,
                      child: Container(
                        margin: EdgeInsets.only(right: 20),
                        child: Icon(icon, color: iconColor, size: 20),
                      ),
                    ),
                    Text(
                      label!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: labelColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

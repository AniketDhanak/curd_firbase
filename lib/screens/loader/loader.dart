import 'package:curd/constants/app_colors.dart';
import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  final Widget child;
  final bool isCallInProgress;
  final double opacity;
  final Color color;
  final Animation<Color>? valueColor;

  const Loader({
    super.key,
    required this.child,
    required this.isCallInProgress,
    this.color = AppColors.white,
    this.opacity = 0.3,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = <Widget>[];
    widgetList.add(child);
    if (isCallInProgress) {
      final modal = Stack(
        children: [
          Opacity(
            opacity: opacity,
            child: ModalBarrier(
              dismissible: false,
              color: color,
            ),
          ),
           const Center(
            child: CircularProgressIndicator(color: AppColors.primary1),
          )
        ],
      );
      widgetList.add(modal);
    }
    return Stack(
      children: widgetList,
    );
  }
}
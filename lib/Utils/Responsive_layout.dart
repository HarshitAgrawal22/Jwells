import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget MobileScaffold;
  final Widget TabletScaffold;
  final Widget DesktopScaffold;

  ResponsiveLayout({
    required this.MobileScaffold,
    required this.TabletScaffold,
    required this.DesktopScaffold,
  });

  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1024) {
          return DesktopScaffold;
        } else if (constraints.maxWidth >= 600) {
          return TabletScaffold;
        } else {
          return MobileScaffold;
        }
      },
    );
  }
}

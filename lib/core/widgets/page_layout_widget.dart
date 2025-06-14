import 'package:flutter/material.dart';

class PageLayoutWidget extends StatelessWidget {
  final Widget bottomChild;
  final Widget children;

  const PageLayoutWidget({
    super.key,
    required this.bottomChild,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (context, constrains) {
                return (SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constrains.minHeight,
                    ),
                    child: children,
                  ),
                ));
              },
            ),
          ),
          bottomChild,
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';

class NavbarItem{
  final Widget page;
  final IconData icon;
  final String pageName;
  final String label;

  NavbarItem({
    required this.page,
    required this.icon,
    required this.pageName,
    required this.label,
  });
}
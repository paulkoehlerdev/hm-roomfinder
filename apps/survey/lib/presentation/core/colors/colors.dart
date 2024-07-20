import 'package:flutter/material.dart';

enum FacultyColor {
  hm(color: Color(0xFFfb5454)),
  fac01(color: Color(0xFF89aa9f)),
  fac02(color: Color(0xFF0033cc)),
  fac03(color: Color(0xFF008dd0)),
  fac04(color: Color(0xFF33cccc)),
  fac05(color: Color(0xFF80de27)),
  fac06(color: Color(0xFF3366cc)),
  fac07(color: Color(0xFF5555fc)),
  fac08(color: Color(0xFF003333)),
  fac09(color: Color(0xFF3e46d9)),
  fac10(color: Color(0xFFd6e644)),
  fac11(color: Color(0xFFff9900)),
  fac12(color: Color(0xFF000000)),
  fac13(color: Color(0xFF73f1a2)),
  fac14(color: Color(0xFFa1e3b8)),
  facMucDai(color: Color(0xFF6200ff));

  final Color color;

  const FacultyColor({
    required this.color,
  });
}

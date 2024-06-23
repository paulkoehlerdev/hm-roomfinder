import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HmLogoIcon extends StatelessWidget {
  const HmLogoIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
        'assets/logo.svg',
        semanticsLabel: 'Acme Logo'
    );
  }
}

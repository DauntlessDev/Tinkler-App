import 'package:flutter/material.dart';
import 'package:tinkler/theme/app_theme_service.dart';

class TopBackground extends StatelessWidget {
  const TopBackground({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: MediaQuery.of(context).viewInsets.bottom < 50 ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      child: Image(
        image: AppThemeService.isDarkModeOn
            ? const AssetImage('assets/images/blacktop_background.png')
            : const AssetImage('assets/images/top_background.png'),
        fit: BoxFit.fill,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}

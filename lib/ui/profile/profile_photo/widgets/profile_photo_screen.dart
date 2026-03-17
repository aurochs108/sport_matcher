import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sport_matcher/ui/core/theme/app_theme.dart';

class ProfilePhotoView extends StatelessWidget {
  final String imagePath;

  const ProfilePhotoView({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppTheme.borderRadius),
      child: SizedBox.expand(
        child: Image.file(
          File(imagePath),
          fit: BoxFit.cover,
          errorBuilder:
              (context, error, stackTrace) => Container(
                color: Colors.pink,
                width: double.infinity,
                height: double.infinity,
              ),
        ),
      ),
    );
  }
}

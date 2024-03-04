import 'package:core/app/constants/app_assets.dart';
import 'package:core/app/extensions/context.dart';
import 'package:core/app/extensions/screen_util.dart';
import 'package:core/app/services/routes/app_routes.dart';
import 'package:core/presentation/widgets/buttons/app_button.dart';
import 'package:core/presentation/widgets/language_switcher/language_button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.title,
    required this.imageName,
  });

  final String title;
  final String imageName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [LanguageButton()],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 19.0,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                  image: const AssetImage(AppAssets.clientAppImage),
                  width: context.screenWidth * 0.7,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Lumin Maps $title',
                        style: context.textTheme.titleLarge?.copyWith(
                          fontSize: 25.toFont,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      AppButton(
                        width: double.infinity,
                        onPressed: () =>
                            context.navigator.pushNamed(AppRoutes.authRoute),
                        label: context.getText('getStarted'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

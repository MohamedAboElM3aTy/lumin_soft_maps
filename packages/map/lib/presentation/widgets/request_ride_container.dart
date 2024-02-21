import 'package:core/app/constants/app_colors.dart';
import 'package:core/app/extensions/context.dart';
import 'package:core/app/extensions/screen_util.dart';
import 'package:core/presentation/widgets/buttons/app_button.dart';
import 'package:core/presentation/widgets/text_fields/rounded_text_field.dart';
import 'package:flutter/material.dart';
import 'package:map/presentation/widgets/build_row.dart';

class RequestRideContainer extends StatelessWidget {
  const RequestRideContainer({
    super.key,
    required this.locationController,
  });

  final TextEditingController locationController;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      left: 0,
      bottom: 20,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7.0),
        child: Container(
          width: double.infinity,
          height: context.screenHeight * 0.32,
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RoundedTextField(
                  isMap: true,
                  changed: (location) => locationController.text = location,
                  validator: (location) => location!.isEmpty
                      ? context.getText('locationRequired')
                      : null,
                  hintText: context.getText('whereTo'),
                  hintStyle: context.textTheme.labelMedium?.copyWith(
                    fontSize: 20.toFont,
                    fontWeight: FontWeight.w600,
                  ),
                  icon: Icons.search,
                  controller: locationController,
                ),
                BuildRow(labelText: context.getText('egypt')),
                const Divider(thickness: 0.4),
                BuildRow(labelText: context.getText('london')),
                AppButton(
                  width: context.screenWidth * 0.9,
                  borderRadius: 20,
                  textStyle: context.textTheme.labelLarge?.copyWith(
                    fontSize: 20.toFont,
                    fontWeight: FontWeight.w400,
                    color: AppColors.whiteColor,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  onPressed: () {},
                  label: context.getText('requestRide'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

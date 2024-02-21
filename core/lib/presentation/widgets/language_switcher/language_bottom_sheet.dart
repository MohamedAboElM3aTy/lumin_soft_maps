import 'package:core/app/extensions/context.dart';
import 'package:core/app/locale/cubit/locale_cubit.dart';
import 'package:core/presentation/widgets/buttons/app_button.dart';
import 'package:core/presentation/widgets/language_switcher/language_switch_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({super.key});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  late Locale _selectedLang;
  late final LocaleCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<LocaleCubit>(context);
    _selectedLang = const Locale('en');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 34, horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.getText('changeLanguage'),
            style: context.textTheme.titleSmall,
          ),
          24.verticalSpace,
          LanguageSwitchItem(
            locale: englishLocale,
            selectedLocale: _selectedLang,
            onTap: () => setState(() => _selectedLang = englishLocale),
          ),
          16.verticalSpace,
          LanguageSwitchItem(
            locale: arabicLocale,
            selectedLocale: _selectedLang,
            onTap: () => setState(() => _selectedLang = arabicLocale),
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  label: context.getText('cancel'),
                  isPrimary: false,
                  onPressed: () => context.navigator.pop(),
                ),
              ),
              17.horizontalSpace,
              Expanded(
                child: AppButton(
                  label: context.getText('confirm'),
                  onPressed: () {
                    _cubit.changeLocale(_selectedLang, context);
                    context.navigator.pop();
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
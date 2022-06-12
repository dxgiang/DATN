import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/commons/l10n/generated/l10n.dart';
import 'package:social_media/ui/themes/color_custom.dart';
import 'package:social_media/ui/widgets/widgets.dart';

enum Lang { en, vi }

class LanguagePage extends StatefulWidget {
  const LanguagePage({Key? key}) : super(key: key);

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  Lang? _languageToggle = Lang.en;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const TextCustom(
            text: 'Change Language', fontWeight: FontWeight.w500),
        elevation: 0,
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          child: Column(
            children: <Widget>[
              RadioListTile<Lang>(
                title: Text(S.of(context).language),
                value: Lang.en,
                groupValue: _languageToggle,
                onChanged: (Lang? value) {
                  setState(() {
                    _languageToggle = value;
                  });
                },
              ),
              SizedBox(height: 20.h),
              RadioListTile<Lang>(
                title: Text(S.of(context).language),
                value: Lang.vi,
                groupValue: _languageToggle,
                onChanged: (Lang? value) {
                  setState(() {
                    _languageToggle = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

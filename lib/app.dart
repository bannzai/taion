import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:taion/features/root/page.dart';
import 'package:taion/style/color.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: AppColor.primary,
          primarySwatch: AppColor.primaryMaterialColor,
          inputDecorationTheme: const InputDecorationTheme(
            border: UnderlineInputBorder(
              borderSide: BorderSide(width: 1, color: AppColor.primary),
            ),
          ),
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: AppColor.primary,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              foregroundColor: AppColor.primary,
              disabledForegroundColor: Colors.grey,
              backgroundColor: Colors.transparent,
              padding: EdgeInsets.zero,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.primary,
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(width: 1.0, color: Colors.black),
              foregroundColor: AppColor.textMain,
            ),
          ),
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.dark,
              statusBarColor: Colors.white,
            ),
          ),
        ).copyWith(
          appBarTheme: const AppBarTheme(
            color: Colors.white,
            foregroundColor: AppColor.textMain,
          ),
          inputDecorationTheme: const InputDecorationTheme(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: AppColor.primary,
              ),
            ),
          ),
        ),
        home: const Root(),
      ),
    );
  }
}

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
          inputDecorationTheme: const InputDecorationTheme(
            border: UnderlineInputBorder(
              borderSide: BorderSide(width: 1, color: AppColor.primary),
            ),
          ),
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: AppColor.primary,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(AppColor.primary),
            ),
          ),
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.dark,
              statusBarColor: Colors.white,
            ),
          ),
        ),
        home: const Root(),
      ),
    );
  }
}

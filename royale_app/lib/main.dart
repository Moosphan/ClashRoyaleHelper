// Copyright 2019 Ucardstore LLC. All rights reserved.
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'application.dart';
import 'core/pages/home/home_page.dart';
import 'core/pages/splash_page.dart';
import 'core/provider/locale_model.dart';
import 'core/resource/locale/chinese_cupertino_localizations.dart';
import 'core/resource/style.dart';
import 'core/util/screen_adapt.dart';
import 'generated/i18n.dart';

/// Program launcher
void main() async {
  // App initializations.
  WidgetsFlutterBinding.ensureInitialized();
  await Application.initialize();
  AutoSize.init(

    /// 设计尺寸：375x667
    /// 对应屏幕实际尺寸：750x1334, devicePixelRatio => 2
    /// 所以从设计图上拉取的尺寸其实是dp单位
      designWidth: 750,
      designHeight: 1334,
      designDevicePixelRatio: 2,
      aspect: Aspect.aspectWidth
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LocaleModel>.value(
      value: LocaleModel(),
      child: Consumer<LocaleModel>(
        builder: (context, localeModel, child) => MaterialApp(
          title: 'Timeory',
          // 全局主题配置
          theme: ThemeData(
            // This is the theme of Timeory application.
            textTheme: AppTheme.textTheme,
            primaryColor: AppTheme.primaryColor,
            canvasColor: AppTheme.surfaceColor,
            scaffoldBackgroundColor: AppTheme.surfaceColor,
            inputDecorationTheme: AppTheme.inputDecorationTheme,
            appBarTheme: AppTheme.appBarTheme,
          ),
          locale: localeModel.locale,
          // 国际化的配置
          localizationsDelegates: const [
            // 配置Cupertino组件支持中文
            ChineseCupertinoLocalizations.delegate,
            DefaultCupertinoLocalizations.delegate,
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
          supportedLocales: S.delegate.supportedLocales,
          debugShowCheckedModeBanner: false,
          // launcher页面配置
          home: SplashPage(),
          routes: {
            '/homePage' : (context) => HomePage()
          },
          //home: TestPage(),
          //onGenerateRoute: Application.router.generator,
        ),
      ),
    );
  }
}

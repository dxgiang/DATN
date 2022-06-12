// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:social_media/commons/l10n/generated/l10n.dart';
// // import 'package:social_media/commons/services/user_config_service.dart';
// // import 'package:social_media/domain/blocs/blocs.dart';
// // import 'package:social_media/domain/blocs/post/post_bloc.dart';

// // class SocialMediaApp extends StatefulWidget {
// //   const SocialMediaApp({Key? key}) : super(key: key);

// //   @override
// //   State<SocialMediaApp> createState() => _SocialMediaAppState();
// // }

// // class _SocialMediaAppState extends State<SocialMediaApp> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MultiBlocProvider(
// //       providers: [
// //         BlocProvider(create: (_) => AuthBloc()..add(OnCheckingLoginEvent())),
// //         BlocProvider(create: (_) => UserBloc()),
// //         BlocProvider(create: (_) => PostBloc()),
// //         BlocProvider(create: (_) => StoryBloc()),
// //         BlocProvider(create: (_) => ChatBloc()),
// //       ],

// //       child: ScreenUtilInit(

// //         builder: (_) {        final _userConfig = BlocProvider.of<UserConfigService>(context);

// //           return MaterialApp(
// //             debugShowCheckedModeBanner: false,
// //             title: 'Social Media App',
// //             supportedLocales: S.delegate.supportedLocales,
// //             locale: ,
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get_it/get_it.dart';
// import 'package:provider/provider.dart';
// import 'package:slivingapp/commons/env.dart';
// import 'package:slivingapp/commons/services/session_service.dart';

// import 'commons/l10n/generated/l10n.dart';
// import 'commons/navigators/navigate_routes.dart';
// import 'commons/themes/custom_theme.dart';
// import 'commons/services/user_config_service.dart';

// class SocialMediaApp extends StatefulWidget {
//   const SocialMediaApp({Key? key}) : super(key: key);

//   @override
//   _SocialMediaAppState createState() => _SocialMediaAppState();
// }

// class _SocialMediaAppState extends State<SocialMediaApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider<UserConfigService>(
//           create: (_) => GetIt.I.getUserConfigService(),
//         ),
//         ChangeNotifierProvider<Environment>(
//             create: (_) => GetIt.I.getSessionService().currentEnv)
//       ],
//       builder: (context, child) {
//         final _userConfig = Provider.of<UserConfigService>(context);
//         final _env = Provider.of<Environment>(context);
//         return ScreenUtilInit(
//             designSize: Size(375, 812),
//             minTextAdapt: true,
//             builder: (_) {
//               return MaterialApp(
//                 navigatorKey: NavigateRoutes.rootNav,
//                 debugShowCheckedModeBanner: false,
//                 title: 'Sliving App',
//                 supportedLocales: S.delegate.supportedLocales,
//                 locale: _userConfig.locale,
//                 theme: CustomTheme.light,
//                 darkTheme: CustomTheme.dark,
//                 themeMode: _userConfig.themeMode,
//                 routes: NavigateRoutes.initialRoutes,
//                 useInheritedMediaQuery: true,
//                 onGenerateRoute: NavigateRoutes.generate,
//                 onUnknownRoute: (settings) {
//                   print(settings);
//                 },
//                 localizationsDelegates: [
//                   S.delegate,
//                   GlobalMaterialLocalizations.delegate,
//                   GlobalCupertinoLocalizations.delegate,
//                   GlobalWidgetsLocalizations.delegate,
//                 ],
//                 initialRoute: NavigateRoutes.root,
//                 builder: (context, widget) {
//                   Widget result = widget!;
//                   if (_env.isDebug) {
//                     result = Banner(
//                       message: 'DEBUG',
//                       textDirection: TextDirection.ltr,
//                       location: BannerLocation.topEnd,
//                       child: result,
//                     );
//                   }
//                   return MediaQuery(
//                     data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
//                     child: result,
//                   );
//                 },
//               );
//             });
//       },
//     );
//   }
// }

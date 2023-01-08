import 'package:flutter/material.dart';
import 'package:go_green_extended/screens/home_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_green_extended/screens/upload_page.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final goRouter = GoRouter(initialLocation: "/", routes: [
    GoRoute(
        path: "/",
        builder: ((context, state) {
          return const HomePage();
        })),
    GoRoute(
      path: "/upload_spot",
      builder: (context, state) {
        return UploadPage(image: state.extra as XFile);
      },
    )
  ]);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.lightGreen,
      ),
      // home: const HomePage(),
    );
  }
}

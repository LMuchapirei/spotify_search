import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spotify_search/search/search_screen.dart';
import 'package:spotify_search/service.dart';
import 'env/env.dart';
import 'global.dart';

void main() {
  Global.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context,child) {
        return MaterialApp(
          title: 'Not Quite Spotify',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const MyHomePage(),
        );
      }
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key,});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

@override
void initState() {
  super.initState();
  fetchToken();
}

  void fetchToken() async {
     final result  = await fetchSpotifyToken(Env.client_ID, Env.client_Secret);
     Global.storageService.saveSpotifyToken(result!);
  }

  @override
  Widget build(BuildContext context) {
    return const SearchScreen();
  }
}

import 'package:flutter/material.dart';
import 'package:netflix/application/downloads/downloads_bloc.dart';
import 'package:netflix/application/home/home_bloc.dart';
import 'package:netflix/application/hot_and_new/hot_and_new_bloc.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix/domain/core/di/injectable.dart';
import 'application/fast_laugh/fast_laugh_bloc.dart';
import 'application/search/search_bloc.dart';
import 'presentation/main_page/screen_main_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<DownloadsBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<SearchBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<FastLaughBloc>(),
        ),
         BlocProvider(
          create: (context) => getIt<HotAndNewBloc>(),
        ),
         BlocProvider(
          create: (context) => getIt<HomeBloc>(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Netflix',
          theme: ThemeData(
              appBarTheme: AppBarTheme(backgroundColor: kBlackColor),
              primarySwatch: Colors.blue,
              scaffoldBackgroundColor: backgroundColor,
              fontFamily: GoogleFonts.montserrat().fontFamily,
              textTheme: const TextTheme(
                bodyLarge: TextStyle(color: Colors.white),
                bodyMedium: TextStyle(color: Colors.white),
              )),
          home: ScreenMainPage()),
    );
  }
}

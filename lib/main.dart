import 'package:flutter/material.dart';

import 'about_page.dart';
import 'main_page.dart';

void main() => runApp(const BaggageApp());

class AppColors {
  static const cream = Color(0xFFECE9D5);
  static const olive = Color(0xFF667547);
  static const dark = Color(0xFF475032);
  static const sage = Color(0xFF9AA384);
}

class BaggageApp extends StatelessWidget {
  const BaggageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Excess Baggage Fee Calculator',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: AppColors.olive,
        scaffoldBackgroundColor: AppColors.cream,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.dark,
          foregroundColor: AppColors.cream,
          centerTitle: true,
        ),
      ),

      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;

  final _pages = const [
    //Center(child: Text('Home page')),
    MainPage(),
    //Center(child: Text('About page')),
    AboutPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Excess Baggage Fee Calculator'),
        actions: [
          PopupMenuButton<int>(
            tooltip: 'Menu',
            color: AppColors.cream,
            onSelected: (value) => setState(() => _index = value),
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: 0,
                child: Row(
                  children: [
                    Icon(Icons.home, color: AppColors.dark),
                    SizedBox(width: 8),
                    Text('Home', style: TextStyle(color: AppColors.dark)),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: [
                    Icon(Icons.info, color: AppColors.dark),
                    SizedBox(width: 8),
                    Text('About', style: TextStyle(color: AppColors.dark)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: _pages[_index],
    );
  }
}

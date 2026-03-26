import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/home_screen.dart';

void main() {
  // Ensure the status bar (battery/time icons) matches our luxury theme
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark, // Dark icons for the creamy background
  ));

  runApp(const ObasClosetApp());
}

class ObasClosetApp extends StatelessWidget {
  const ObasClosetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OBA’S Closet',
      debugShowCheckedModeBanner: false,

      // PROFESSIONAL THEME ENGINE
      theme: ThemeData(
        useMaterial3: true, // Enables latest UI components
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6D4C41),
          primary: const Color(0xFF6D4C41), // Deep luxury brown
          secondary: const Color(0xFFA1887F), // Lighter accent brown
          surface: const Color(0xFFFDF8F5), // Creamy background
        ),

        // Background color for all screens
        scaffoldBackgroundColor: const Color(0xFFFDF8F5),

        // Custom AppBar Style
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFDF8F5),
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Color(0xFF3E2723),
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
          iconTheme: IconThemeData(color: Color(0xFF3E2723)),
        ),

        // Global Button Styles
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6D4C41),
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 50),
            textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
        ),

        // FIXED: Card Style using CardThemeData
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 2,
          surfaceTintColor: Colors.white, // Prevents unwanted tinting in Material 3
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),

        // Input Decoration (Great for the upcoming Search Bar)
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          hintStyle: const TextStyle(color: Colors.grey),
        ),
      ),

      home: const HomeScreen(),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:responsi1/helpers/user_info.dart';
import 'package:responsi1/ui/login_page.dart';
import 'package:responsi1/ui/produk_page.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  Widget page = const CircularProgressIndicator();
  @override
  void initState() {
    super.initState();
    isLogin();
  }
  void isLogin() async {
    var token = await UserInfo().getToken();
    if (token != null) {
      setState(() {
        page = const ProdukPage();
      });
    } else {
      setState(() {
        page = const LoginPage();
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Manajemen Keuangan',
      theme: ThemeData(
  brightness: Brightness.dark,  // This affects overall app brightness
  primaryColor: Colors.blue[900],
  scaffoldBackgroundColor: Colors.blue[900],
  colorScheme: ColorScheme.dark(
    primary: Colors.blue[800]!,
    secondary: Colors.blue[600]!,
    surface: Colors.blue[900]!,
    onPrimary: const Color.fromARGB(255, 249, 249, 249),  // Set onPrimary to black for text color
    onSecondary: const Color.fromARGB(255, 252, 252, 252),  // Set onSecondary to black for text color
    onSurface: const Color.fromARGB(255, 249, 249, 249),  // Set onSurface to black for general surface text color
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.blue[800],
    foregroundColor: const Color.fromARGB(255, 255, 255, 255),  // This affects AppBar text color
  ),
  textTheme: Typography.blackMountainView,  // Use black text styles
  inputDecorationTheme: InputDecorationTheme(
    fillColor: Colors.blue[800],
    filled: true,
    labelStyle: TextStyle(color: Colors.blue[100]),
    hintStyle: TextStyle(color: Colors.blue[200]),
    floatingLabelStyle: TextStyle(color: Colors.black),  // Set floating label to black
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue[600]!),
      borderRadius: BorderRadius.circular(8),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue[400]!),
      borderRadius: BorderRadius.circular(8),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue[300]!),
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blue[600],
      foregroundColor: const Color.fromARGB(255, 245, 245, 245),  // Button text color set to black
    ),
  ),
  cardTheme: CardTheme(
    color: Colors.blue[800],
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
  fontFamily: 'Roboto',
),
      debugShowCheckedModeBanner: false,
      home: page,
    );
  }
}
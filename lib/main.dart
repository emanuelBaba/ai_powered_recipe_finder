import 'package:ai_powered_recipe_finder/screens/recipes_list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
        searchBarTheme: SearchBarThemeData(
          backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
          hintStyle: WidgetStateProperty.all<TextStyle>(
            const TextStyle(
              color: Colors.grey,
            ),
          ),
          shadowColor: const WidgetStatePropertyAll(Colors.transparent),
          shape: WidgetStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              side: const BorderSide(
                  color: Color.fromRGBO(217, 217, 217, 1), width: 1),
              borderRadius: BorderRadius.circular(45),
            ),
          ),
        ),
      ),
      home: const RecipesListScreen(),
    );
  }
}

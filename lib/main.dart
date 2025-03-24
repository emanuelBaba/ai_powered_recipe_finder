import 'package:ai_powered_recipe_finder/providers/generated_recipes_provider.dart';
import 'package:ai_powered_recipe_finder/screens/recipes_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:provider/provider.dart';

void main() {
  Gemini.init(
      apiKey: 'AIzaSyDS-spFaMR3_1ByuqJgtLBCpzo6SeC4Zig');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: GeneratedRecipesProvider(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
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
        ),
      );
}

import 'package:ai_powered_recipe_finder/widgets/list_card_widget.dart';
import 'package:flutter/material.dart';

class RecipeDetailsScreen extends StatefulWidget {
  const RecipeDetailsScreen({super.key});

  @override
  State<RecipeDetailsScreen> createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<RecipeDetailsScreen> {
  bool isSaved = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(children: [
                  const Image(
                    image: AssetImage('app_assets/images/eating.png'),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Image(
                        image: AssetImage('app_assets/images/back_arrow.png'),),
                  )
                ]),
              ],
            ),
          )),
    );
  }
}

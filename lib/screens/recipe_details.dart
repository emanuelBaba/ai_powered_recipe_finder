import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/recipe.dart';
import '../providers/generated_recipes_provider.dart';

class RecipeDetailsScreen extends StatefulWidget {
  final Recipe recipe;
  const RecipeDetailsScreen({required this.recipe, super.key});

  @override
  State<RecipeDetailsScreen> createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<RecipeDetailsScreen> {
  bool isSaved = false;
  void addRemoveRecipeFromFavourites() {
    if (isSaved == false) {
      Provider.of<GeneratedRecipesProvider>(context, listen: false)
          .addFavoriteRecipe(widget.recipe);
    } else {
      Provider.of<GeneratedRecipesProvider>(context, listen: false)
          .removeFavoriteRecipe(widget.recipe);
    }
    setState(() {
      isSaved = Provider.of<GeneratedRecipesProvider>(context, listen: false)
          .containsRecipe(widget.recipe);
    });
  }

  @override
  Widget build(BuildContext context) {
    isSaved =  Provider.of<GeneratedRecipesProvider>(context)
        .containsRecipe(widget.recipe);
    return Scaffold(
      body: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      image: AssetImage('app_assets/images/back_arrow.png'),
                    ),
                  )
                ]),
                ListTile(
                  visualDensity: const VisualDensity(
                    horizontal: VisualDensity.maximumDensity,
                  ),
                  title: Text(
                    widget.recipe.name ?? '',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  subtitle: Text(widget.recipe.cookingTime ?? ''),
                  trailing: IconButton(
                    onPressed: addRemoveRecipeFromFavourites,
                    icon: Image.asset(isSaved
                        ? 'app_assets/images/colored_heart.png'
                        : 'app_assets/images/heart.png'),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Ingredients:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                ...?widget.recipe.ingredients
                    ?.map((final i) => Text('  • $i'))
                    .toList(),
                const SizedBox(height: 10),
                const Text(
                  'Instructions:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                ...?widget.recipe.instructions
                    ?.indexed.map((final i) => Text('  ${i.$1}. ${i.$2}'))
                    .toList(),
              ],
            ),
          )),
    );
  }
}

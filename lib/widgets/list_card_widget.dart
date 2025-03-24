import 'package:ai_powered_recipe_finder/providers/generated_recipes_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/recipe.dart';
import '../screens/recipe_details.dart';

class ListCardWidget extends StatefulWidget {
  final Recipe recipe;
  const ListCardWidget({required this.recipe, super.key});

  @override
  State<ListCardWidget> createState() => _ListCardState();
}

class _ListCardState extends State<ListCardWidget> {
  bool isSaved = false;

  void addRemoveRecipeFromFavourites(){
    if (isSaved == false) {
      Provider.of<GeneratedRecipesProvider>(context, listen: false)
          .addFavoriteRecipe(widget.recipe);
    } else {
      Provider.of<GeneratedRecipesProvider>(context, listen: false)
          .removeFavoriteRecipe(widget.recipe);
    }
    setState(() {
      isSaved = Provider.of<GeneratedRecipesProvider>(context,
          listen: false)
          .containsRecipe(widget.recipe);
    });
  }

  @override
  Widget build(BuildContext context) {
    isSaved = Provider.of<GeneratedRecipesProvider>(context)
        .containsRecipe(widget.recipe);
    return Card(
      color: Colors.white,
      child: SizedBox(
        height: 100,
        child: ListTile(
          visualDensity: const VisualDensity(
              horizontal: VisualDensity.maximumDensity,
              vertical: VisualDensity.maximumDensity),
          leading: const Image(
            image: AssetImage('app_assets/images/eating.png'),
          ),
          title: Text(
            widget.recipe.name ?? '',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(widget.recipe.cookingTime ?? ''),
          trailing: IconButton(
            onPressed: addRemoveRecipeFromFavourites,
            icon: Image.asset(isSaved
                ? 'app_assets/images/colored_heart.png'
                : 'app_assets/images/heart.png'),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RecipeDetailsScreen(
                          recipe: widget.recipe,
                        )));
          },
        ),
      ));}
}

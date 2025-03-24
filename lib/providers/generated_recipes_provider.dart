import 'dart:convert';

import 'package:ai_powered_recipe_finder/models/recipe.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class GeneratedRecipesProvider extends ChangeNotifier {
  List<Recipe>? _listOfGeneratedRecipes;
  List<Recipe>? get listOfRecipes => _listOfGeneratedRecipes;

  final List<Recipe> _listOfFavorites = [];
  List<Recipe> get listOfFavorites => _listOfFavorites;

  Future<List<Recipe>?> generateRecipes(final String input) async {
    try {
      final candidates = await Gemini.instance.prompt(parts: [
        Part.text('Generate a list of recipes for $input, including only'
            ' the name, total time, ingredients and instructions. The output should be in json format'),
      ]);
      if (candidates == null || candidates.output == null) {
        return null;
      }
      final recipes = _parseResult(candidates.output!);
      _listOfGeneratedRecipes = recipes;
      notifyListeners();
      return recipes;
    } catch (error) {
      _listOfGeneratedRecipes = null;
      return Future.value(null);
    }
  }

  List<Recipe> _parseResult(final String input) {
    final json = jsonDecode((input.split('json')[1]).split('`')[0]);
    final parsedRecipes = json
        .map<Recipe>((final r) => Recipe.fromJson(r as Map<String, dynamic>))
        .toList();

    return parsedRecipes;
  }

  void addFavoriteRecipe(final Recipe recipe) {
    if (!_listOfFavorites.contains(recipe)) {
      _listOfFavorites.add(recipe);
      notifyListeners();
    }
  }

  void removeFavoriteRecipe(final Recipe recipe) {
    if (_listOfFavorites.contains(recipe)) {
      _listOfFavorites.remove(recipe);
      notifyListeners();
    }
  }

  bool containsRecipe(final Recipe recipe) => _listOfFavorites.contains(recipe);
}

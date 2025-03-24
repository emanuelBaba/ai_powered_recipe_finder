import 'package:ai_powered_recipe_finder/widgets/list_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/generated_recipes_provider.dart';

class RecipesListScreen extends StatefulWidget {
  const RecipesListScreen({super.key});

  @override
  State<RecipesListScreen> createState() => _RecipesListState();
}

class _RecipesListState extends State<RecipesListScreen> {
  final searchBarController = SearchController();
  bool isLoading = false;

  void _getRecipes(String value) {
    if (value.isEmpty) {
      setState(() {
        isLoading = false;
      });
      return;
    }
    setState(() {
      isLoading = true;
    });
    Provider.of<GeneratedRecipesProvider>(context, listen: false)
        .generateRecipes(value)
        .then((final _) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SearchBar(
              controller: searchBarController,
              hintText: 'What do you feel like eating?',
              trailing: const [
                Icon(
                  Icons.search,
                  color: Colors.black,
                )
              ],
              onSubmitted: (final value) => _getRecipes(value),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                searchBarController.text.isEmpty
                    ? 'Favorites'
                    : 'Suggested Recipes',
                style:
                    const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            !isLoading
                ? Expanded(child: Consumer<GeneratedRecipesProvider>(
                    builder: (final context, final data, final child) {
                    final listOfRecipes = searchBarController.text.isNotEmpty
                        ? data.listOfRecipes
                        : data.listOfFavorites;
                    return listOfRecipes != null && listOfRecipes.isNotEmpty
                        ? ListView.builder(
                            itemCount: listOfRecipes.length,
                            itemBuilder: (final listCtx, final index) =>
                                ListCardWidget(
                              recipe: listOfRecipes[index],
                            ),
                          )
                        : const Text('\nNo recipes...');
                  }))
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
            if (searchBarController.text.isNotEmpty && !isLoading)
              FilledButton(
                onPressed: () {
                  final input = searchBarController.text;
                  if (input.isNotEmpty) {
                    _getRecipes(input);
                  }
                },
                style: ButtonStyle(
                    backgroundColor: const WidgetStatePropertyAll(
                        Color.fromRGBO(101, 85, 143, 1)),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)))),
                child: const Text('I don\'t like these'),
              )
          ],
        ),
      ),
    );
  }
}

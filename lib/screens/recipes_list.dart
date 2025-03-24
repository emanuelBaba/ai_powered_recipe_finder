import 'package:ai_powered_recipe_finder/screens/recipe_details.dart';
import 'package:ai_powered_recipe_finder/widgets/list_card_widget.dart';
import 'package:flutter/material.dart';

class RecipesListScreen extends StatefulWidget {
  const RecipesListScreen({super.key});

  @override
  State<RecipesListScreen> createState() => _RecipesListState();
}

class _RecipesListState extends State<RecipesListScreen> {
  final searchBarController = SearchController();

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
              onSubmitted: (final value) {
                setState(() {});
              },
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
            Expanded(
              child: ListView.builder(
                  itemCount: 2,
                  itemBuilder: (final listCtx, final index) =>
                      const ListCardWidget()),
            ),
            if (searchBarController.text.isNotEmpty)
              FilledButton(
                onPressed: () {

                },
                style: ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(Color.fromRGBO(101, 85, 143, 1)),
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

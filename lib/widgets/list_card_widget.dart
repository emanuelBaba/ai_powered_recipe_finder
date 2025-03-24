import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/recipe_details.dart';

class ListCardWidget extends StatefulWidget {
  const ListCardWidget({super.key});

  @override
  State<ListCardWidget> createState() => _ListCardState();
}

class _ListCardState extends State<ListCardWidget> {
  bool isSaved = false;

  @override
  Widget build(BuildContext context) => Card(
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
          title: const Text(
            'Recipe 1535',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text('10 minutes'),
          trailing: IconButton(
            onPressed: () {
              setState(() {
                isSaved = !isSaved;
              });
            },
            icon: Image.asset(isSaved
                ? 'app_assets/images/colored_heart.png'
                : 'app_assets/images/heart.png'),
          ),
          onTap: (){Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RecipeDetailsScreen()));},
        ),
      ));
}

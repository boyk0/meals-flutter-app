import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoriteScreen extends StatelessWidget {
  static const routeName = '/favorites';

  final List<Meal> favoriteList;

  FavoriteScreen(this.favoriteList);

  @override
  Widget build(BuildContext context) {
    if(favoriteList.isEmpty) {
      return Center(
        child: Text('You have no favorites yet - start add something'),
      );
    }
    return ListView.builder(
      itemBuilder: (BuildContext ctx, int i) {
        return MealItem(favoriteList[i]);
      },
      // itemCount: favoriteList.length,
      //Text('${categoryMeals[i].title}');
    );
  }
}
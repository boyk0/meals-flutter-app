import 'package:flutter/material.dart';

import './screen/categories_screen.dart';
import './screen/category_meals_screen.dart';
import './screen/meal_detail_screen.dart';
import './screen/tabs_screen.dart';
import './screen/filters_screen.dart';
import './dummy_data.dart';
import './models/meal.dart';
import './screen/favorite_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'glutene': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availiableMeals = DUMMY_MEALS;
  List<Meal> _favoriteList = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availiableMeals = DUMMY_MEALS.where((meal) {
        if ((_filters['glutene'] as bool) && !meal.isGlutenFree) {
          return false;
        }
        if ((_filters['lactose'] as bool) && !meal.isLactoseFree) {
          return false;
        }
        if ((_filters['vegan'] as bool) && !meal.isVegan) {
          return false;
        }
        if ((_filters['vegetarian'] as bool) && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex = _favoriteList.indexWhere((meal) => meal.id == mealId);

    if (existingIndex == -1) {
      print('1');
      return setState(() {
        _favoriteList.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
    setState(() {
      _favoriteList.removeAt(existingIndex);
    });
  }
  
  bool _isFavoriteMeal(String mealId) {
    return _favoriteList.any((meal) => meal.id == mealId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
          titleMedium: TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1),
            fontSize: 20,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
          ),
        )
      ),
      // home: CategoriesScreen(),
      routes: {
        '/': (ctx) => TabsScreen(_favoriteList),
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(_availiableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(_toggleFavorite, _isFavoriteMeal),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _setFilters),
        FavoriteScreen.routeName: (ctx) => FavoriteScreen(_favoriteList),
      },
      onGenerateRoute: (settings) {
        print(settings.arguments);
        // return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
      onUnknownRoute: (settings) => MaterialPageRoute(builder: (ctx) => CategoriesScreen()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key,}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DeliMeals'),
      ),
      body: Center(
        child: Text('Navigation Time!'),
      ),
    );
  }
}

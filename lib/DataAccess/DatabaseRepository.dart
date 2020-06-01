import 'package:pinoy_recipes/DataAccess/FavoriteReository.dart';

import './RecipeRepository.dart';
import './RecipeCourseRepository.dart';
import './RecipeTypeRepository.dart';
import './RecipeMainIngredientsRepository.dart';
import './RecipeIngredientsRepository.dart';
import './RecipeNutritionsRepository.dart';
import './RecipeInstructionsRepository.dart';
import './RecipeTagRepository.dart';

class DatabaseRepository {
  static RecipeRepository _recepiRepository;
  static RecipeCourseRepository _recipeCourseRepository;
  static RecipeTypeRepository _recipeTypeRepository;
  static RecipeMainIngredientsRepository _recipeMainIngredientsRepository;

  static RecipeIngredientsRepository _recipeIngredientsRepository;
  static RecipeNutritionsRepository _recipeNutritionsRepository;
  static RecipeInstructionsRepository _recipeInstructionsRepository;
  static RecipeTagRepository _recipeTagRepository;
  static FavoriteRepository _favoriteRepository;

  static void _init() {
    if (_recepiRepository == null) _recepiRepository = RecipeRepository();

    if (_recipeCourseRepository == null)
      _recipeCourseRepository = RecipeCourseRepository();

    if (_recipeTypeRepository == null)
      _recipeTypeRepository = RecipeTypeRepository();

    if (_recipeMainIngredientsRepository == null)
      _recipeMainIngredientsRepository = RecipeMainIngredientsRepository();

    if (_recipeIngredientsRepository == null)
      _recipeIngredientsRepository = RecipeIngredientsRepository();
    if (_recipeNutritionsRepository == null)
      _recipeNutritionsRepository = RecipeNutritionsRepository();
    if (_recipeInstructionsRepository == null)
      _recipeInstructionsRepository = RecipeInstructionsRepository();

    if (_recipeTagRepository == null)
      _recipeTagRepository = RecipeTagRepository();

    if (_favoriteRepository == null) _favoriteRepository = FavoriteRepository();
  }

  static RecipeRepository get recipeRepository {
    _init();
    return _recepiRepository;
  }

  static RecipeCourseRepository get recipeCourseRepository {
    _init();
    return _recipeCourseRepository;
  }

  static RecipeTypeRepository get recipeTypeRepository {
    _init();
    return _recipeTypeRepository;
  }

  static RecipeMainIngredientsRepository get recipeMainIngredientsRepository {
    _init();
    return _recipeMainIngredientsRepository;
  }

  static RecipeIngredientsRepository get recipeIngredientsRepository {
    _init();
    return _recipeIngredientsRepository;
  }

  static RecipeNutritionsRepository get recipeNutritionsRepository {
    _init();
    return _recipeNutritionsRepository;
  }

  static RecipeInstructionsRepository get recipeInstructionsRepository {
    _init();
    return _recipeInstructionsRepository;
  }

  static RecipeTagRepository get recipeTagRepository {
    _init();
    return _recipeTagRepository;
  }

  static FavoriteRepository get favoriteRepository {
    _init();
    return _favoriteRepository;
  }
}

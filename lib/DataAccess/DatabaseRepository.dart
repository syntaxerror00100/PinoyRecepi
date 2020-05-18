import './RecepiRepository.dart';
import './RecipeCourseRepository.dart';
import './RecipeTypeRepository.dart';
import './RecipeMainIngredientsRepository.dart';

class DatabaseRepository {
  static void _init() {
    if (_recepiRepository == null) _recepiRepository = RecepiRepository();

    if (_recipeCourseRepository == null)
      _recipeCourseRepository = RecipeCourseRepository();

    if (_recipeTypeRepository == null)
      _recipeTypeRepository = RecipeTypeRepository();

    if (_recipeMainIngredientRepository == null)
      _recipeMainIngredientRepository = RecipeMainIngredientsRepository();
  }

  static RecepiRepository _recepiRepository;
  static RecipeCourseRepository _recipeCourseRepository;
  static RecipeTypeRepository _recipeTypeRepository;
  static RecipeMainIngredientsRepository _recipeMainIngredientRepository;

  static RecepiRepository get recipeRepository {
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
    return _recipeMainIngredientRepository;
  }
}

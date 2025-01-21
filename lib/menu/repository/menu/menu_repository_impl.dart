import 'package:meal_planner/menu/repository/menu/menu_repository.dart';
import 'package:meal_planner/repository/in_memory_repository.dart';

import '../../menu.dart';

class MenuRepositoryImpl extends InMemoryRepository<Menu> implements MenuRepository{}
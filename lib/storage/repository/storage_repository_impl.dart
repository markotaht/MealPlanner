import 'package:meal_planner/storage/repository/storage_repository.dart';

import '../../repository/in_memory_repository.dart';
import '../storage.dart';

class StorageRepositoryImpl extends InMemoryRepository<Storage> implements StorageRepository{}
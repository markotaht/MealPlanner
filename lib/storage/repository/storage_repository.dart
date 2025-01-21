import 'package:flutter/cupertino.dart';
import 'package:meal_planner/storage/storage.dart';

import '../../repository/repository.dart';

abstract class StorageRepository extends ChangeNotifier implements Repository<Storage>{}
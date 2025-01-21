import 'package:flutter/cupertino.dart';

import '../../custom_icons_icons.dart';
import '../../components/propetries/date_property.dart';
import '../../components/propetries/text_property.dart';
import '../../list_property.dart';
import '../model/meal.dart';

class GeneralTab extends StatelessWidget {
  const GeneralTab({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextProperty(
          leading: const Icon(CustomIcons.check),
          title: 'Name',
          object: meal,
          field: 'name',
        ),
        TextProperty(
            leading: const Icon(CustomIcons.edit),
            title: 'Note',
            object: meal,
            field: 'note'),
        ListProperty(
            leading: const Icon(CustomIcons.edit),
            title: 'Category',
            object: meal,
            field: 'categories'),
        DateProperty(
            leading: const Icon(CustomIcons.edit),
            title: "Expiration Date",
            object: meal,
            field: 'expirationDate')
      ],
    );
  }
}

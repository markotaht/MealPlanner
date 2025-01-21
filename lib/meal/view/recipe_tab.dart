import 'package:flutter/cupertino.dart';

class RecipeTab extends StatelessWidget {
  const RecipeTab({super.key, this.recipe});

  final String? recipe;

  @override
  Widget build(BuildContext context) {
    return recipe != null && recipe!.isNotEmpty
        ? Text(recipe!)
        : const Center(
            child: Text("No Recipe written"),
          );
  }
}

import 'package:flutter/material.dart';

import '../../custom_icons_icons.dart';

class MenuPageFooter extends StatelessWidget {
  const MenuPageFooter(
      {super.key,
      this.favourite = false,
      this.showHidden = false,
      required this.toggleFavourite,
      required this.toggleShowHidden});

  final bool favourite;
  final bool showHidden;
  final void Function() toggleFavourite;
  final void Function() toggleShowHidden;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 4.0,
      child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                onPressed: toggleFavourite,
                icon: Icon(
                    favourite ? CustomIcons.star : CustomIcons.star_border)),
            const Spacer(),
            IconButton(
                onPressed: toggleShowHidden,
                icon: Icon(showHidden ? CustomIcons.eye_off : CustomIcons.eye)),
            IconButton(
              onPressed: () async {},
              icon: const Icon(CustomIcons.filter),
            ),
          ]),
    );
  }
}

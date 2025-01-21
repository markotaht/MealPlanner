import 'package:flutter/material.dart';
import 'package:meal_planner/custom_icons_icons.dart';
import 'package:meal_planner/pages/meal_page/meal_page.dart';

import 'meal/model/meal.dart';

class CategorizedListView extends StatefulWidget {
  static Widget defaultHeaderBuilder(Category category, BuildContext context) =>
      CategoryHeader(
          leading: const Icon(CustomIcons.edit), title: category.title);

  static Widget defaultItemBuilder(CategoryItem categoryItem,
          BuildContext context, void Function(int id) onTap) =>
      CategoryListItem(
          title: categoryItem.title,
          subtitle: categoryItem.subtitle,
          visible: categoryItem.visible,
          onTap: () {
            onTap(categoryItem.id);
          },
          trailing: AspectRatio(
              aspectRatio: 1,
              child: IconButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.grey),
                      shape:
                          MaterialStateProperty.all<ContinuousRectangleBorder>(
                              const ContinuousRectangleBorder())),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                               // ItemView(id: categoryItem.id)
                          MealPage(meal: categoryItem.object as Meal,)
                        ));
                  },
                  icon: const Icon(CustomIcons.edit))));

  const CategorizedListView(
      {super.key,
      required this.categories,
      this.categoryHeaderBuilder = defaultHeaderBuilder,
      this.categoryItemBuilder = defaultItemBuilder,
      this.listHeader,
      this.onItemTap,
      this.showHidden = false});

  final List<Category> categories;
  final Widget? Function(Category category, BuildContext context)
      categoryHeaderBuilder;
  final Widget? Function(CategoryItem catecoryItem, BuildContext context,
      void Function(int id) onTap) categoryItemBuilder;
  final Widget? listHeader;
  final bool showHidden;
  final void Function(int id)? onItemTap;

  @override
  State<StatefulWidget> createState() {
    return _CategorizedListViewState();
  }
}

class _CategorizedListViewState extends State<CategorizedListView> {
  late List<ListItem> parsedItems = [];

  @override
  void initState(){
    super.initState();
    createItems();
  }

  void onTap(int id){
    widget.onItemTap?.call(id);
    updateState();
  }
  void updateState() {
    setState(() {
      createItems();
    });
  }

  @override
  void didUpdateWidget(covariant CategorizedListView old) {
    super.didUpdateWidget(old);
    createItems();
  }

  void createItems() {
    parsedItems = [];
    for (var category in widget.categories) {
      List<ListItem> tempItems = [];
      tempItems
          .add(widget.categoryHeaderBuilder(category, context) as ListItem);
      for (var item in category.items) {
        if (item.visible || widget.showHidden) {
          tempItems.add(widget.categoryItemBuilder(item, context, onTap)
              as ListItem);
        }
      }
      if (tempItems.length > 1) {
        parsedItems.addAll(tempItems);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    if (widget.listHeader != null) {
      children.add(widget.listHeader as Widget);
    }
    children.add(Expanded(
        child: ListView.separated(
            separatorBuilder: (content, index) => const Divider(
                  color: Colors.grey,
                  height: 2,
                ),
            itemCount: parsedItems.length,
            itemBuilder: (context, index) {
              return parsedItems[index];
            })));
    return Column(children: children);
  }
}

abstract class ListItem extends StatelessWidget {
  const ListItem({super.key});
}

class CategoryListItem extends ListItem {
  const CategoryListItem(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.trailing,
      required this.visible,
      this.onTap});

  final String title;
  final String? subtitle;
  final Widget trailing;
  final void Function()? onTap;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
            child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onTap,
                child: Container(
                    height: 60,
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(title,
                            style: TextStyle(
                                decoration: visible
                                    ? TextDecoration.none
                                    : TextDecoration.lineThrough,
                                fontSize: 25)))))),
        SizedBox(height: 60, child: trailing)
      ],
    );
    // return ListTile(title: Text(title), trailing: trailing);
  }
}

class CategoryHeader extends ListItem {
  const CategoryHeader({super.key, required this.leading, required this.title});

  final String title;
  final Widget leading;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 60, child: leading),
        Container(
            height: 60,
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(title,
                    style: DefaultTextStyle.of(context)
                        .style
                        .apply(fontSizeFactor: 1.5)))),
      ],
    );
  }
}

class Category {
  final String title;
  final List<CategoryItem> items;

  Category({required this.title, required this.items});
}

class CategoryItem {
  final int id;
  final String title;
  final String? subtitle;
  final String category;
  bool visible;
  final Object object;

  CategoryItem(
      {required this.id,
      required this.title,
      required this.category,
      this.subtitle,
      required this.visible,
      required this.object});

  CategoryItem.visible(
      {required this.id,
      required this.title,
      required this.category,
      this.subtitle,
        required this.object})
      : visible = true;
}

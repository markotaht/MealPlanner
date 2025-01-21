
import 'package:flutter/material.dart';
import 'package:meal_planner/menu/events/manu_cud_event.dart';

import '../../components/future_list/future_list.dart';
import '../../initializer.dart';
import '../menu.dart';
import '../menu_service.dart';
import 'menu_list_tile.dart';

class MenusList extends StatelessWidget {
  const MenusList({super.key});

  @override
  Widget build(BuildContext context) {
    MenuService service = getIt.get<MenuService>();
    return FutureList<Menu, MenuCudEvent>(
        dataFunction: service.getAllMenus,
        itemBuilder: (Menu data, BuildContext context, int index) =>
            MenuListTile(
              menu: data,
              menuService: service,
              index: index,
            ));
  }
}
/*class MenusList extends StatefulWidget {
  const MenusList({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MenusListState();
  }
}

class _MenusListState extends State<MenusList> {
  late StreamSubscription newMenuSubscription;
  late final MenuService menuService;
  List<Menu> menuListItems = [];

  @override
  void initState() {
    super.initState();
    menuService = getIt.get<MenuService>();

    newMenuSubscription = eventBus.on().listen((event) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    newMenuSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Menu>>(
        initialData: [],
        future: menuService.getAllMenus(),
        builder: (BuildContext context, AsyncSnapshot<List<Menu>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (BuildContext context, int index) {
                  return MenuListTile(
                    menu: snapshot.data![index],
                    menuService: menuService,
                    index: index,
                  );
                });
          }
          return const Center(
            child: Text("Loading"),
          );
        });
  }
}*/

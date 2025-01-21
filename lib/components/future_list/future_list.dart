import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../../initializer.dart';

class FutureList<T, E> extends StatefulWidget {
  const FutureList(
      {super.key, required this.dataFunction, required this.itemBuilder});

  final Future<List<T>> Function() dataFunction;
  final Widget Function(T data, BuildContext context, int index) itemBuilder;

  @override
  State<StatefulWidget> createState() {
    return _FutureListState<T, E>();
  }
}

class _FutureListState<T, E> extends State<FutureList<T, E>> {
  late StreamSubscription updateSubscription;

  @override
  void initState() {
    super.initState();
    updateSubscription = eventBus.on<E>().listen((event) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    updateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<T>>(
        initialData: const [],
        future: widget.dataFunction(),
        builder: (BuildContext context, AsyncSnapshot<List<T>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (BuildContext context, int index) {
                  return widget.itemBuilder(
                      snapshot.data![index], context, index);
                });
          }
          return const Center(
            child: Text("Loading"),
          );
        });
  }
}

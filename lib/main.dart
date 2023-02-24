import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive/hive.dart';
import 'graphql/animeList.dart';

Future<void> main() async {
  await initHiveForFlutter();
  await Hive.openBox('my-box');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink('https://graphql.anilist.co');
    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
    GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(store: HiveStore()),
    ),
    );
    return GraphQLProvider(
    client: client,
    child: MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
    primarySwatch: Colors.blue,
    ),
    home: const MyHomePage(title: 'GraphQl')),
    );
  }
}

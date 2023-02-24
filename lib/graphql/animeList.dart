import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_app/graphql/widget/card.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final String query = r"""
 {
  Page {
    media {
      siteUrl
      title {
        english
        native
      }
      description
    }
  }
}
                  """;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Query(
          options: QueryOptions(
            document: gql(query),
            optimisticResult: (val){
              if (kDebugMode) {
                print(val);
              }
            },
          ),
          builder: (QueryResult? result, { VoidCallback? refetch, FetchMore? fetchMore}) {
            if (result?.data?.isEmpty == false) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0,bottom: 8,left: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text("Anime List",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: result?.data!['Page']['media'].length,
                        itemBuilder: (BuildContext context, int index) {
                          return result?.data!['Page']['media'][index]['title']['english'].toString() != "null"
                              ? CardWidget(result: result?.data,index: index) : const SizedBox(height: 0,width: 0,);
                        }),
                  ),
                ],
              );
            }
            return const Center(child: CircularProgressIndicator());
          }
      ),
    );
  }
}

// GraphQL
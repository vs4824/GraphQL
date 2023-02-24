import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:translator/translator.dart';
import 'package:url_launcher/url_launcher.dart';

class CardWidget extends StatefulWidget {
  final Map<String, dynamic>? result;
  final int index;

  const CardWidget({super.key, this.result,required this.index});

  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  var ok;
  final translator = GoogleTranslator();

  @override
  void initState() {
    super.initState();
    translator.translate(widget.result!['Page']['media'][widget.index]['title']['english'], from: 'en', to: 'ja').then((value) {
      setState(() {
        ok = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ExpandablePanel(
          header: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${widget.result!['Page']['media'][widget.index]['title']['english']}",
                    style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text("$ok",
                        style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
                  ),
                  InkWell(
                    onTap: () async {
                      await launchUrl(Uri.parse(widget.result!['Page']['media'][widget.index]['siteUrl']));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text("${widget.result!['Page']['media'][widget.index]['siteUrl']}",
                          style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500,
                              color: Colors.blue)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          collapsed: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Html(data: '${widget.result!['Page']['media'][widget.index]['description']}',shrinkWrap: true,
              style: {
                '#': Style(
                  maxLines: 2,
                  textOverflow: TextOverflow.ellipsis,
                ),
              },),
          ),
          expanded: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Html(data: '${widget.result!['Page']['media'][widget.index]['description']}',shrinkWrap: true, ),
          ),
          // tapHeaderToExpand: true,
          // hasIcon: true,
        ),
      ),
    );
  }
}

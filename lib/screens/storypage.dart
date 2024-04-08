import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import '../story.dart';

class MainScreen extends StatefulWidget {
  final Story story;

  const MainScreen({super.key,required this.story});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (_) => WebviewScaffold(
          scrollBar: true,
          appBar: AppBar(title:Text(widget.story.title,style: TextStyle(color: Colors.white),
          ),backgroundColor: Colors.orange,leading: IconButton(
            icon: Icon(Icons.arrow_back_outlined,color: Colors.white,),
            onPressed: (){Navigator.pop(context);},
          )),
          url: widget.story.url,
          enableAppScheme: true,
          withZoom: true,
        ),
      },
    );
  }
}

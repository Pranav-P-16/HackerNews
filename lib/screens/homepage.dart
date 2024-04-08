import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("HackerNews",style: TextStyle(
      color: Colors.white,fontWeight: FontWeight.w500
    ),),backgroundColor: Colors.orange,),
    floatingActionButton: FloatingActionButton(child: Icon(Icons.exit_to_app,color: Colors.black,),
    onPressed: (){},backgroundColor: Colors.red,),);
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hackernews/screens/loginpage.dart';
import 'package:hackernews/screens/storypage.dart';
import 'package:hackernews/story.dart';
import 'package:hackernews/webservice.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'api/apis.dart';
import 'commentListPage.dart';

class TopArticleList extends StatefulWidget {
  @override
  _TopArticleListState createState() => _TopArticleListState();
}

class _TopArticleListState extends State<TopArticleList> {

  List<Story> _stories = List<Story>.empty();

  @override
  void initState() {
    super.initState();
    _populateTopStories();
  }

  void _populateTopStories() async {

    final responses = await Webservice().getTopStories();
    final stories = responses.map((response) {
      final json = jsonDecode(response.body);
      return Story.fromJSON(json);
    }).toList();

    setState(() {
      _stories = stories;
    });
  }

  void _navigateToShowCommentsPage(BuildContext context, int index) async {

    final story = this._stories[index];
    // final responses = await Webservice().getCommentsByStory(story);
    // final comments = responses.map((response) {
    //   final json = jsonDecode(response.body);
    //   return Comment.fromJSON(json);
    // }).toList();

   // debugPrint("$comments");

    Navigator.push(context, MaterialPageRoute(
        builder: (context) => MainScreen(story: story,)
    ));


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("HackerNews",style: TextStyle(
              color: Colors.white,fontWeight: FontWeight.w500
          ),),backgroundColor: Colors.orange,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right:40.0),
            child: Icon(Icons.message,color: Colors.white,size: 30,),
          )
        ],),
        floatingActionButton: FloatingActionButton(child: Icon(Icons.exit_to_app,color: Colors.black,),
    onPressed: () async {
    await APIs.auth.signOut().then((value) async {
    await GoogleSignIn().signOut().then((value) {
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (_)=> LoginPage()));
    });
    });
    },backgroundColor: Colors.red,),

        body: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: _stories.length,
          itemBuilder: (_, index) {
            return Card(
              child: InkWell(
                onTap: (){
                  _navigateToShowCommentsPage(context, index);
                },
                child: ListTile(
                  title: Text(_stories[index].title, style: TextStyle(fontSize: 18)),
                  trailing: Container(
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.all(Radius.circular(30))
                      ),
                      alignment: Alignment.center,
                      width: 50,
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                          child: Text("${_stories[index].commentIds.length}",style: TextStyle(fontSize:15,color: Colors.white)),
                      )
                  ),
                ),
              ),
            );
          },
        )
    );

  }

}
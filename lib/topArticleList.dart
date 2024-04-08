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
import 'dialogues/dialogues.dart';

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

  void _navigateToStoriesPage(BuildContext context, int index) async {

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
  void _navigateToShowCommentsPage(BuildContext context, int index) async {

    final story = this._stories[index];
    final responses = await Webservice().getCommentsByStory(story);
    final comments = responses.map((response) {
      final json = jsonDecode(response.body);
      return Comment.fromJSON(json);
    }).toList();

    //debugPrint("$comments");

    Navigator.push(context, MaterialPageRoute(
        builder: (context) => CommentListPage(story: story, comments: comments)
    ));


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text("HackerNews",style: TextStyle(
                  color: Colors.white,fontWeight: FontWeight.w500
              ),),Text("☢",style: TextStyle(
            fontWeight: FontWeight.w500))
            ],
          ),backgroundColor: Colors.orange,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right:40.0),
            child: Icon(Icons.message,color: Colors.white,size: 29,),
          )
        ],),
        floatingActionButton: FloatingActionButton(child: Icon(Icons.exit_to_app,
          color: Colors.black,),
    onPressed: () {
      _confirmBox_logOut();
    },backgroundColor: Colors.red,),

        body: Stack(
          children: [Center(child: Image.asset('assets/images/icon.png')),ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: _stories.length,
            itemBuilder: (_, index) {
              return Card(
                shape:RoundedRectangleBorder(
                    side: new BorderSide(color: Colors.deepOrange, width: 1.0),
                    borderRadius: BorderRadius.circular(16)),
                child: ListTile(
                  title: InkWell(
                      onTap: (){
                        _navigateToStoriesPage(context, index);
                      },
                      child: Text(_stories[index].title, style: TextStyle(fontSize: 18))),
                  trailing: InkWell(
                    onTap: (){
                      _navigateToShowCommentsPage(context, index);
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.all(Radius.circular(30))
                        ),
                        alignment: Alignment.center,
                        width: 50,
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                            child: Text("${_stories[index].commentIds.length}",style: TextStyle(fontSize:15,color: Colors.black)),
                        )
                    ),
                  ),
                ),
              );
            },
          )],
        )
    );

  }
  void _confirmBox_logOut(){
    showDialog(context: context, builder: (_)=> AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ),
      title: Row(children: [
        Icon(Icons.outbound,color: Colors.deepOrange,size: 28,),
        Text(' Logout')
      ],),
      content:
      Text("Are you sure?",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.left),
      actions: [
        MaterialButton(onPressed: (){
          Navigator.pop(context);
        },child: Text('Cancel',style: TextStyle(color: Colors.blue,fontSize: 16),),),
        MaterialButton(onPressed: () async {
          Dialogues.showProgressBar(context);
          await APIs.auth.signOut().then((value) async {
            await GoogleSignIn().signOut().then((value) {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> LoginPage()));
            });

          });
        },child: Text('Logout',style: TextStyle(color: Colors.red,fontSize: 16),),),
      ],
    ));
  }

}
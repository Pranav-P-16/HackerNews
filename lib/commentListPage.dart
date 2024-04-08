import 'package:flutter/material.dart';
import 'package:hackernews/story.dart';

class CommentListPage extends StatelessWidget {

  final List<Comment> comments;
  final Story story;

  CommentListPage({required this.story,required this.comments});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
            title: Text(this.story.title,style: TextStyle(color: Colors.white),),
            backgroundColor: Colors.orange,
          leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: (){Navigator.pop(context);},),

        ),
        body: Stack(
          children: [Center(child: Image.asset('assets/images/icon.png')),ListView.builder(
            itemCount: this.comments.length,
            itemBuilder: (context,index) {
              return Card(
                child: ListTile(
                    leading: Container(
                        alignment: Alignment.center,
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: Text("${1+index}",style: TextStyle(fontSize: 22,color: Colors.white))),
                    title: Padding(
                      padding: const EdgeInsets.only(top:8.0),
                      child: Text(this.comments[index].text,style: TextStyle(fontSize: 18)),
                    )
                ),
              );
            },
          )],
        )
    );

  }

}
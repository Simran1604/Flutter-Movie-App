import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';


import 'package:movies/movie_info.dart';

import 'movie_detail.dart';
final List<Info> infoList=Info.getinfo();
class movies extends StatelessWidget{
  
  

  movies({Key? key,}) : super(key: key);
  
  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title:Text("Movies"),
        backgroundColor: Colors.blueGrey.shade800,
      ),

      backgroundColor: Colors.blueGrey.shade800,

      body: ListView.builder(
        itemCount: infoList.length,
        itemBuilder:(BuildContext context, int index){
          final int i=index;

         Widget movieCard(Info movie,BuildContext context){
          return InkWell(
            child:Container(
              margin: EdgeInsets.only(left:80),
              width: MediaQuery.of(context).size.width,
              height: 180,
              child: Card(
                color:Colors.grey.shade900,
                child:Padding(
                  padding: const EdgeInsets.only(top:8,bottom: 12,left:54),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                             child:Text(infoList[index].title,
                            style: TextStyle(
                              color:Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),),
                          ),
                          
                           Expanded(
                             
                              child: Text("Rating: ${infoList[index].imdbRating}/10",
                      style: TextStyle(
                        color:Colors.grey.shade500,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),),
                            ),
                          
                        ],
                      
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child:Text("Year: ${infoList[index].year}",
                            style: TextStyle(
                              color:Colors.grey.shade500,
                              fontWeight: FontWeight.bold,
                              fontSize: 14
                            ),),
                         ),
                           Expanded(
                                child: Text("Duration:${infoList[index].runtime}",style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:Colors.grey.shade500,
                                  fontSize: 14
                                ),),
                             ),
                        ],
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children:[
                          Expanded(
                            child: Text("Genre: ${infoList[index].genre}",style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color:Colors.grey.shade500,
                            ),),
                          )
                        ]
                      )
                    ],
                    ),
                  ),
                )
              ),
         
            ),
         
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>MovieDetails(index:i)));
        }
           );

        }
        
          

          Widget movieImage (String image,int index){
             return InkWell(
               child: Container(
                  margin: EdgeInsets.only(left:10,right:10,top:20),
                  width:135,
                  height:135,
                  decoration: BoxDecoration(
                    shape:BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade900,
                    width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 5
                      )
                    ],
                    image:DecorationImage(image:NetworkImage(image),
                    fit: BoxFit.cover
                    )
                  ),
                ),
               onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>MovieDetails(index:i)));
        }
             );
          }

          return Stack(
            children: [
             movieCard(infoList[index],context),
              movieImage(infoList[index].images[1],index)
              ]);
        
      }),
    );
  }
}


import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';


import 'package:movies/info.dart';

import 'pic.dart';

final List<Info> infoList=Info.getinfo();

class MovieDetails extends StatelessWidget {
  final List<Info> infoList=Info.getinfo();

   MovieDetails({ Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey.shade800,
        appBar: AppBar(
          title:Text("Movies"),
          backgroundColor: Colors.blueGrey.shade900,
        ),
    
        body: ListView(
            
              children:[
                Thumbnail(thumbnail: infoList[index].images[1],index: index,),
                Row(
                  children: [
                    Expanded(child:HeaderWithPoster(index:index)),
                  ],
                ),
                 Line(),
                Row(
                  children: [
                    Expanded(child: Details(index: index)),
                  ],
                ),
                Line(),
                Images(posters: infoList[index].images,index1: index,),
              ]  
            ),
    );
    
  }
}

class Thumbnail extends StatelessWidget {
  final String thumbnail;
  final int index;

  const Thumbnail({ Key? key, required this.thumbnail, required this.index }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width:MediaQuery.of(context).size.width,
              height:180,
              decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(thumbnail),
                fit: BoxFit.cover)
              ),
            ),
            //
            GestureDetector(
               onTap:()
            {
              button(index);
            } ,
            child:Icon(Icons.play_circle_outline, size:60,color: Colors.white,
           ) ,
            )
             
           // IconButton(onPressed: button(index), icon: Icon(Icons.play_circle_outline,size: 60,color: Colors.white,))
            
          ],
         
        ),
         Container(
          decoration:BoxDecoration(
            gradient:LinearGradient(colors: [Color(0x00000000),Color(0xff000000)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
            )
          ),
          height: 40,
        )
      ],      
    );
  }
  button(int index) async
  {
    var url=infoList[index].play;
     if(await canLaunch(url))
     await launch(url);
  }
} 

class HeaderWithPoster extends StatelessWidget {
  final index;
  const HeaderWithPoster({ Key? key, this.index }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:8.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(top:8.0),
            child: Poster(poster:infoList[index].images[0].toString()),
          ),
          SizedBox(
            width:16
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top:10.0),
              child: Header(index:index),
            )
                        )
                              ],
                            ),
                          );
                        }
                      }
            
           class Header extends StatelessWidget {
             final index;
             const Header({ Key? key, this.index }) : super(key: key);
           
             @override
             Widget build(BuildContext context) {
               return Column( 
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text("${infoList[index].title}",
                   style:
                    TextStyle(
                      fontSize:32,
                      fontWeight: FontWeight.w600 ,
                      color: Colors.white
                      ),
                   ),
                   Line(),
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Text("${infoList[index].year} . ${infoList[index].genre}".toUpperCase(),
                     style: TextStyle(
                       fontWeight: FontWeight.w600,
                       color: Colors.amberAccent.shade200
                     ),
                     ),
                   ),
                   Text.rich(
                     TextSpan(
                       style: TextStyle(
                         fontSize: 12,
                         fontWeight: FontWeight.w400
                     ),
                     children: [
                       TextSpan(
                         text:infoList[index].plot,
                         style: TextStyle(
                           fontWeight: FontWeight.w400,
                           fontSize: 14,
                           color: Colors.grey.shade400
                         )
                       ),
                       
                       
                     ]
                     )),

                   InkWell(
                     child: Text("More...",
                         style: TextStyle(color: Colors.amberAccent.shade200,
                         fontSize: 14
                         )
                       ),
                       onTap: () => {launch(infoList[index].more),
                       }
                   )
                 ],
                 
               );
             }
           }
          
          class Poster extends StatelessWidget {
            final String poster;
            const Poster({ Key? key, required this.poster }) : super(key: key);
          
            @override
            Widget build(BuildContext context) {
              var borderRadius=BorderRadius.all(Radius.circular(10));
              return ClipRRect(
                borderRadius: borderRadius,
                  child: Container(
                    width: MediaQuery.of(context).size.width/4,
                    height: 155,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(poster),
                      fit: BoxFit.fill,
                      )
                    ),
                  )
                  );

            }
          }
          class Details extends StatelessWidget {
            final int index;
            const Details({ Key? key, required this.index }) : super(key: key);
          
            @override
            Widget build(BuildContext context) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal:18.0),
                child: Column(
                   children:[Padding(
                    padding: const EdgeInsets.all(8.0),
                  
                    child: MovieField(field:"Cast",value:infoList[index].actors),
                  ),
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: MovieField(field:"Director",value:infoList[index].director),
                   ),
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: MovieField(field:"Awards",value:infoList[index].awards),
                   )
                   ]
                        
                                  ),
                                );
                              }
                            }
                  
                  class MovieField extends StatelessWidget {
                    final String field;
                    final String value;
                    const MovieField({ Key? key, required this.field, required this.value }) : super(key: key);
                  
                    @override
                    Widget build(BuildContext context) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: 
                          Text("$field : ",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                       color: Colors.amberAccent.shade200),
                          ),
                          ),

                          Expanded(child: 
                          Text("$value",
                         style: TextStyle(
                            fontWeight: FontWeight.w400,
                           fontSize: 14,
                           color: Colors.white
                         ),
                          )
                          )
                        ],
                      );
                    }
                  }
                  class Line extends StatelessWidget {

                    const Line({ Key? key }) : super(key: key);
                  
                    @override
                    Widget build(BuildContext context) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                        child: Container(
                          height: 1,
                          color: Colors.white,
                          
                        ),
                      );
                    }
                  }

            class Images extends StatelessWidget {
              final  List <String> posters ;
              int index1;
               Images({ Key? key, required this.posters, required this.index1 }) : super(key: key);
            
              @override
              Widget build(BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical:8.0,horizontal: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("MORE MOVIE POSTERS...",
                        style: TextStyle(
                         fontWeight: FontWeight.w600,
                         color: Colors.amberAccent.shade200,
                          fontSize: 14
                        ),),
                      ),
                      
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueGrey.shade900,
                          width: 2,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: 
                          [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 2
                            ),
                          ],
                        ),
                        height:200,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                           separatorBuilder:(context,index)=>SizedBox(width:8), 
                           itemCount:posters.length,
                           itemBuilder: (context,index)=>ClipRRect(
                             borderRadius:BorderRadius.all(Radius.circular(10)),
                             
                               child: Hero(
                                 tag: 'image$index',
                                 child: Container(
                                   width: MediaQuery.of(context).size.width/2,
                                   height: 160,
                                   decoration: BoxDecoration(
                                     image: DecorationImage(image: NetworkImage(posters[index]),
                                     fit: BoxFit.cover
                                     )
                                   ),
                                   child: GestureDetector(
                                     onTap: () {
                                         Navigator.push(context, MaterialPageRoute(builder: (context) {
                                           return  pic(index1:index1,index2:index);
                                         }));
                                       },
                                     ),
                                          //async {
                                    // await showDialog(
                                    // context: context,
                                    // builder: (_) => Dialog(
                                    //   elevation: 2,
                                    //    child: Container(
                                    //         width: 200,
                                    //         height: 200,
                                    //         decoration: BoxDecoration(
                                    //         image: DecorationImage(
                                    //         image: NetworkImage(posters[index]),
                                    //         fit: BoxFit.cover
                                    //       ),
                                       
                                    //      ),
                                    //    ),
                               
                                    //   ),
                                    //  );}
                                   ),
                               ),
                               )
                             ),
                           ),
                      
                    ]
              
                  )
                );
            }
            }

            

            
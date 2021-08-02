import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:url_launcher/url_launcher.dart';


import 'movie-info.dart';
final List<Info> infoList=Info.getinfo();
// ignore: camel_case_types
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
              height: 120,
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
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),),
                          ),
                          
                           Expanded(
                             
                              child: Text("Rating :${infoList[index].imdbRating}/10",
                      style: TextStyle(
                        color:Colors.grey.shade500,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),),
                            ),
                          
                        ],
                      
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children:[
                         Expanded(
                            child:Text("Released:${infoList[index].released}",
                            style: TextStyle(
                              color:Colors.grey.shade500,
                              fontWeight: FontWeight.bold,
                              fontSize: 12
                            ),),
                         ),
                          
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Expanded(
                              child: Text("${infoList[index].runtime}",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color:Colors.grey.shade500,
                                fontSize: 12
                              ),),
                            ),
                          ),
                          Expanded(
                            child: Text("${infoList[index].rated}",style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
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
         ,  );

        }
        
          

          Widget movieImage (String image){
            return Container(
              margin: EdgeInsets.only(top:10,left:20),
              width:100,
              height:100,
              decoration: BoxDecoration(
                shape:BoxShape.circle,
                image:DecorationImage(image:NetworkImage(image),
                fit: BoxFit.fill
                )
              ),
            );
          }

          return Stack(
            children: [
              movieCard(infoList[index],context),
              movieImage(infoList[index].images[0]),
              ]);

        // return Card(
        //   elevation: 4.0,
        //   color: Colors.white,
        //   child: ListTile(
        //     leading: CircleAvatar(
        //       child:Container(
        //         width: 400,
        //         height: 400,
        //         decoration:BoxDecoration(
        //           image: DecorationImage(image: NetworkImage(infoList[index].images[0]),
        //           fit: BoxFit.cover),
        //           borderRadius: BorderRadius.circular(12),
        //         ),
        //       )
        //     ),
        //     title:Text(infoList.elementAt(index).title),
        //     subtitle: Text("${infoList[index].genre}"),
        //     onTap: () {
        //       Navigator.push(context, MaterialPageRoute(builder: (context)=>MovieDetails(movieName:infoList.elementAt(index).title,
        //       )));
        //     },
        //     trailing: Text("...")
        //   ),
        // );
        
      }),
    );
  }
}

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
            Thumbnail(thumbnail: infoList[index].images[0],index: index,),
            Expanded(child:HeaderWithPoster(index:index)),
             Line(),
            Expanded(child: Details(index: index)),
            Line(),
            Images(posters: infoList[index].images),
          ]  
    ),
    );
    
      // body: Center(
      //   child: Container(
      //     child:RaisedButton(
      //       child:Text("Go back to $movieName",
      //       textAlign: TextAlign.center,),
      //       onPressed:(){
      //         Navigator.pop(context);
      //       }
      //     ),
      //   ),
      // ),
    
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
            gradient:LinearGradient(colors: [Color(0x00f5f5f5),Color(0xfff5f5f5)],
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
          Poster(poster:infoList[index].images[1].toString()),
          SizedBox(
            width:16
          ),
          Expanded(
            child: Header(index:index)
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
              return Card(
                child: ClipRRect(
                   borderRadius: borderRadius=borderRadius,
                  child: Container(
                    width: MediaQuery.of(context).size.width/4,
                    height: 160,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(poster),
                      fit: BoxFit.cover
                      )
                    ),
                  )
                  ),
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
              const Images({ Key? key, required this.posters,  }) : super(key: key);
            
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
                        height:200,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                           separatorBuilder:(context,index)=>SizedBox(width:8), 
                           itemCount:posters.length,
                           itemBuilder: (context,index)=>ClipRRect(
                             borderRadius:BorderRadius.all(Radius.circular(10)),
                             
                               child: Container(
                                 width: MediaQuery.of(context).size.width/3,
                                 height: 160,
                                 decoration: BoxDecoration(
                                   image: DecorationImage(image: NetworkImage(posters[index]),
                                   fit: BoxFit.fill
                                   )
                                 ),
                               ),
                           ),
                           ),
                      )
                    ],
                    
                  ),
                );
              }
            }
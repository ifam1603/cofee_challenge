import 'package:cofee_challenge/games.dart';
import 'package:flutter/material.dart';

class Gamecard  extends StatelessWidget{
  Game game;
  Gamecard(this.game);
  @override
  Widget build(BuildContext context){

    Size size=MediaQuery.of(context).size;
    double cardWidth =size.width-60;
    double cardHeight = size.height*.55;

    return Container(
      child: Stack(
        //overflow:Overflow.visible,
        children: <Widget>[
          buildTopText(),
          buildBackgroundImage(cardWidth,cardHeight,size),
          buildAboveCard(cardWidth,cardHeight,size),
        ],
      ),
    );
  }

 Widget buildTopText(){
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Row(children: <Widget>[
        SizedBox(width: 20,),
        Text(game.name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 50,color: game.lightColor),),
        Text(game.conName,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 50,color: game.darkColor),),
      ],),
    );
  }

  Widget buildBackgroundImage(double cardWidth, double cardHeight, Size size){
    return Positioned(
      width: cardWidth,
      height: cardHeight,
      bottom: size.height*.15,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: ClipRRect(
          borderRadius:BorderRadius.circular(25) ,
          child: Image.asset(game.backgroundImage,fit: BoxFit.cover,),
        ),
      ),
    );
  }

  Widget buildAboveCard(double cardWidth, double cardHeight, Size size){
   return Positioned(
      width: cardWidth,
      height: cardHeight,
      bottom: size.height*.15,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          color: game.darkColor.withOpacity(.80),
          borderRadius: BorderRadius.circular(25)
        ),
        padding: EdgeInsets.all(30) ,
        child: Column(
          children:<Widget> [
            Text('Juego',style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              color: Colors.white),
              ),
              SizedBox(height: 10,),
              Text(game.description,style:TextStyle(color: Colors.white,fontSize: 18,))
          ],
        ),
      ),
      );
  }
}



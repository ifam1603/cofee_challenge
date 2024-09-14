import 'package:cofee_challenge/colors.dart';
import 'package:cofee_challenge/games.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class Gamecard  extends StatelessWidget{
  Game game;
  double pageOffset;
  int index;

  Gamecard(this.game, this.pageOffset, this.index);

  late double animation;

  double animate=0;

  double columnAnimation=0;

  double rotate=0;

  @override
  Widget build(BuildContext context){

    Size size=MediaQuery.of(context).size;
    double cardWidth =size.width-60;
    double cardHeight = size.height*.55;
    double count=0;
    double page;

    rotate=index-pageOffset;

    for(page=pageOffset;page>1;){
      page --;
      count ++;
    }

    animation=Curves.easeOutBack.transform(page);
    animate =100*(count+animation);
    columnAnimation =50*(count+animation);

    for(int i=0;i<index;i++){
      animate-=100;
      columnAnimation-=50;

    }
    
    return Container(
      child: Stack(
        //overflow:Overflow.visible,
        children: <Widget>[
          buildTopText(),
          buildBackgroundImage(cardWidth,cardHeight,size),
          buildAboveCard(cardWidth,cardHeight,size),
          buildGameImage(size),
          buildImageBlur(cardWidth,size),
          buildTopImage(cardWidth,cardHeight,size),
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
        child: Transform.translate(
          offset: Offset(-columnAnimation,0),
          child: Column(
            children:<Widget> [
              Text('Juego',style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.white),
                ),
                SizedBox(height: 10,),
                Text(game.description,style:TextStyle(color: Colors.white,fontSize: 18,)),
                Spacer(),
                Row(
                  children:<Widget> [
                    SizedBox(width:5 ,),
                    Image.asset('assets/logo_singleplayer.png',width: 70, height: 70,),
                    SizedBox(width: 5,)
                  ],
                ),
                SizedBox(height: 15,),
                Container(
                  height: 40,
                  decoration: BoxDecoration(color: bludlight,borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget> [
                        SizedBox(width: 20,),
                        Text('\$',style: TextStyle(fontSize: 20,color: Colors.white),),
                        SizedBox(width: 10,),
                        Text('19.', style: TextStyle(fontSize: 19,color: Colors.white),),
                        Text('99', style: TextStyle(fontSize: 14,color: Colors.white),)
                      ],
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
      );
  }

  Widget buildGameImage(Size size) {
    return Positioned(
      bottom: 160,
      right: -size.width * .2 + 70,
      child: Container(
        height: size.height * .26, 
        child: Transform.rotate(
          angle: -math.pi/14*rotate,
          child: Image.asset(
            game.gameImage,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Widget buildImageBlur(double cardWidth, Size size) {
    return Positioned(
      bottom: size.height * .33,
      right: 60+animate,
      child: Container(
        width: cardWidth, // Define el ancho de la imagen basado en `cardWidth`
        height: size.height * .1, // Define la altura según un porcentaje del tamaño de la pantalla
        child: Image.asset(
          game.imageBlur,
          fit: BoxFit.contain, // Asegura que la imagen se ajuste dentro del contenedor sin cortarse
        ),
      ),
    );
  }

  Widget buildTopImage(double cardWidth, double cardHeight, Size size){
    return Positioned(
      width: cardWidth,
      height: size.height *.1,
      right: 1 +animate,
      top: 80,
      child: Image.asset(game.imageTop,fit: BoxFit.contain,)
      );
  }
}



import 'package:cofee_challenge/colors.dart';
import 'package:cofee_challenge/gameCard.dart';
import 'package:cofee_challenge/games.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> with SingleTickerProviderStateMixin{
  late PageController pageController;
  double pageOffset=0;
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    controller =AnimationController(vsync: this,duration: Duration(milliseconds: 800));
    animation=CurvedAnimation(parent: controller, curve: Curves.easeOutBack);
    pageController = PageController(viewportFraction:.8);
    pageController.addListener((){
      setState(() {
        pageOffset = pageController.page!;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
      controller.dispose();
      pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            buildToolbar(),
            buildLogo(size),
            buildPager(size),
            buildPageIndicator()
          ],
        )
      ),
    );
  }

  Widget buildToolbar(){
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        children: <Widget>[
            SizedBox(width: 20,),
           AnimatedBuilder(
              animation: animation,
              builder: (context, snapshot) {
                double animatedValue = (400 * (1 - animation.value)).toDouble();
                return Transform.translate(
                  offset: Offset(animatedValue,0),
                  child: Image.asset('assets/location.png',
                  width: 30, 
                  height: 30,));
              }
            ),
            Spacer(),
            AnimatedBuilder(
              animation: animation,
              builder: (context, snapshot) {
               double animatedValue = (400 * (1 - animation.value)).toDouble();
                return Transform.translate(
                  offset: Offset(animatedValue,0),
                  child: Image.asset('assets/drawer.png',
                  width: 30, 
                  height: 30,));
              }
            ),
            SizedBox(width: 20,),
          ],
        ),
    );
  }

  Widget buildLogo(Size size){
    return Positioned(
      top: 10,
      right: size.width/2-25,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, snapshot) {
          return Transform(
            transform: Matrix4.identity()
            ..translate(0.0,size.height/2*(1-animation.value))
            ..scale(1+(1-animation.value)),
            origin: Offset(25, 25),
            child: InkWell(
              onTap: ()=>controller.isCompleted?controller.reverse():controller.forward(),
              child: Image.asset('assets/logo.png',width: 50, height: 50,)));
        }
      )
      );
  }

  Widget buildPager(Size size) {
  return Container(
    margin: EdgeInsets.only(top: 70),
    height: size.height - 50,
    child: AnimatedBuilder(
      animation: animation,
      builder: (context, snapshot) {
        // Asegúrate de convertir el valor a double
        double animatedValue = (400 * (1 - animation.value)).toDouble();

        return Transform.translate(
          offset: Offset(animatedValue, 0),
          child: PageView.builder(
            controller: pageController,
            itemCount: getGames().length,
            itemBuilder: (context, index) => Gamecard(getGames()[index], pageOffset, index),
          ),
        );
      },
    ),
  );
}



   List<Game> getGames() {
    List<Game> list = [];
    list.add(Game(
        'Blood',
        'borne',
        'assets/fondo_ps4.png',
        'assets/mando_ps4.png',
        'assets/marca_cazador.png',
        'assets/ps_logo.png',
        'assets/bloodborne.png',
        'Bladborn es un uego exclusivo de ps4 que corre a 30 fps \n(ya saquen el port a pc)',
        bludlight,
        bluddark));
    list.add(Game(
        'Gears o',
        'f war',
        'assets/xbox_fondo.png',
        'assets/mando_xbox.png',
        'assets/xbox_logo.png',
        'assets/xbox_logo.png',
        'assets/yirs.png',
        'yirs el juego de hombres mamados despedazando locust saquen el po\nrt a pc YA.',
        greenLight,
        greenDark));
    list.add(Game(
        'legend ',
        'zelda',
        'assets/fondo_nintendo.png',
        'assets/mando_switch.png',
        'assets/nintendo_logo.png',
        'assets/nintendo_logo.png',
        'assets/zelda.png',
        'zelda controlamos al nene duende otra vez pero mundo abierto bien \nhecho.',
        colorswitch,
        colorswitchDark));
    return list;
  }
  
    Widget buildPageIndicator() {
    return AnimatedBuilder(
      animation:controller,
      builder: (context, snapshot) {
        return Positioned(
          bottom: 10,
          left: 10,
          child: Opacity(
            opacity: controller.value,
            child: Row(
              children:
                  List.generate(getGames().length, (index) => buildContainer(index)),
            ),
          ),
        );
      }
    );
  }

  Widget buildContainer(int index) {
    double animate =pageOffset-index;
    double size =10;
    animate=animate.abs();
    Color color =Colors.grey;
    if(animate<=1 && animate>=0){
      size=10+10*(1-animate);
      color =ColorTween(begin: Colors.grey,end: mAppGreen).transform((1-animate))!;
    }

    return Container(
      margin: EdgeInsets.all(4),
      height: size,
      width: size,
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(20)),
    );
  }



}
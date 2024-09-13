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

class _homeState extends State<home> {
  late PageController pageController;

  @override
  void initState() {
    // TODO: implement initState
    pageController = PageController(viewportFraction:.8);
    super.initState();
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
            buildPager(size)
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
            Image.asset('assets/location.png',width: 30, height: 30,),
            Spacer(),
            Image.asset('assets/drawer.png',width: 30, height: 30,),
            SizedBox(width: 20,),
          ],
        ),
    );
  }

  Widget buildLogo(Size size){
    return Positioned(
      top: 10,
      right: size.width/2-25,
      child: Image.asset('assets/logo.png',width: 50, height: 50,)
      );
  }

  Widget buildPager(Size size){
    return Container(
      margin: EdgeInsets.only(top: 70),
      height: size.height-50,
      child: PageView.builder(controller: pageController,itemCount: getGames().length, itemBuilder: (context,index)=>Gamecard(getGames()[index])),
    );     
  }

   List<Game> getGames() {
    List<Game> list = [];
    list.add(Game(
        'Blood',
        'borne',
        'assets/fondo_ps4.png',
        'assets/frasco_sangre.png',
        'assets/marca_cazador.png',
        'assets/marca_cazador.png',
        'assets/bloodborne.png',
        'Bladborn es un uego exclusivo de ps4 que corre a 30 fps \n(ya saquen el port a pc)',
        bludlight,
        bluddark));
    list.add(Game(
        'Gears o',
        'f war 2',
        'assets/xbox_fondo.png',
        'assets/logo_xbox.png',
        'assets/logo_xbox.png',
        'assets/logo_xbox.png',
        'assets/yirs.png',
        'yirs el juego de hombres mamados despedazando locust \nsaquen el po\nrt a pc YA.',
        greenLight,
        greenDark));
    list.add(Game(
        'breath of ',
        'the wild',
        'assets/fondo_nintendo.png',
        'assets/logo_switch.png',
        'assets/logo_switch.png',
        'assets/logo_switch.png',
        'assets/zelda.png',
        'zelda controlamos al nene duende otra vez pero mundo abierto bien \nhecho.',
        colorswitch,
        colorswitchDark));
    return list;
  }

}
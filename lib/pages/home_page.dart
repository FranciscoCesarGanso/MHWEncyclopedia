
import 'package:flutter/material.dart';
import 'package:mhencicopledia/models/monster.dart';
import 'package:mhencicopledia/services/monster_hunter_service.dart';
import 'package:mhencicopledia/widgets/custom_loader_widget.dart';
class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image:DecorationImage(
                image:AssetImage("assets/img/library.jpg"),
                fit:BoxFit.fill
              )
            ),
            child: FutureBuilder(
              future: MonsterHunterService().getMonsters(),
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  return GridView.builder(
                    itemCount: snapshot.data.length,
                    physics: BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ), 
                    itemBuilder:(context, index) {
                      return _Book(monster:snapshot.data[index]);
                    },
                  );
                }
                else{
                  return CustomLoader();
                }
              },
            ),
          )
        ),
      ),
    );
  }
}
class _Book extends StatelessWidget {

  final Monster monster;
  const _Book({@required this.monster});

  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, 'monster',arguments: this.monster);    
      },
      child: Container(
        height: 220,
        child: Stack(
          children: [
            Center(child: Image(image: AssetImage("assets/img/book.png"))),
            Positioned(
              child: monster.getIcon(),
              left: 75, 
              top: 30,
            ),
            Positioned(
              bottom: 20,
              left: 60,
              child: Container(
                width: 100,
                height: 100,
                child: Center(
                  child: Text(
                    this.monster.name,
                    style:Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.clip,
                  )
                )
              ),
            ), 
          ],
        ),
      ),
    );
  }
}

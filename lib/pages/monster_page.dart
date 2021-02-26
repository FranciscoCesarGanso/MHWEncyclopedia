import 'package:flutter/material.dart';
import 'package:mhencicopledia/helpers/capitalize.dart';
import 'package:mhencicopledia/models/monster.dart';
import 'package:mhencicopledia/widgets/custom_tab_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MonsterPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
   final Monster monster=ModalRoute.of(context).settings.arguments;
    return SafeArea(
      child: FirstTab(monster: monster,) ,
    );
  }
}
class FirstTab extends StatefulWidget {
  final Monster monster;
  FirstTab({@required this.monster});

  @override
  _FirstTabState createState() => _FirstTabState(); 
}

class _FirstTabState extends State<FirstTab> with SingleTickerProviderStateMixin{

  TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 3, vsync: this);
  }

  @override
  void dispose() { 
    tabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        body:Stack(
          children: [
            _Background(),
            Positioned(
              left: 40,
              bottom: 50,
              child: Container( 
                width: 370,
                height: 650,
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    _Title(monsterName: widget.monster.name),
                    SizedBox(height: 10,),
                    widget.monster.getRender(),
                    SizedBox(height: 10,),
                    _Description(monsterDescription:widget.monster.description),
                    SizedBox(height: 10,),
                    Container(
                      child:TabBar(
                        tabs: [
                          CustomTab(texto: "Weaknesses",gradienteStart: Theme.of(context).primaryColor,gradienteEnd:Theme.of(context).secondaryHeaderColor),
                          CustomTab(texto: "Resistances",gradienteStart: Theme.of(context).primaryColor,gradienteEnd:Theme.of(context).secondaryHeaderColor),
                          CustomTab(texto: "Locations",gradienteStart: Theme.of(context).primaryColor,gradienteEnd:Theme.of(context).secondaryHeaderColor),              
                        ],
                      ),
                    ),
                    Expanded(
                      child:TabBarView(
                        physics: BouncingScrollPhysics(),
                        children: [
                          _WeaknessesTab(weaknesses: widget.monster.weaknesses),
                          _ResistancesTab(resistances: widget.monster.resistances),
                          _LocationTab(locations: widget.monster.locations)
                        ],
                      ) 
                    )
                  ],
                ),
              ),
            )
          ],
        ) 
      ),
    );
  }
}

class _Description extends StatelessWidget {
  final String monsterDescription;

  const _Description({@required this.monsterDescription});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        margin: EdgeInsets.all(5),
        child: Text(
          monsterDescription,
          style: Theme.of(context).textTheme.bodyText1,
          textAlign: TextAlign.center,
          overflow: TextOverflow.clip,
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String monsterName;

  const _Title({@required this.monsterName});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration:BoxDecoration(
        border: Border.symmetric(horizontal: BorderSide(color: Colors.black, width: 2, style: BorderStyle.solid)),
        shape: BoxShape.rectangle,
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor.withOpacity(0.6),
            Theme.of(context).secondaryHeaderColor.withOpacity(0.6)
          ]
        )
      ),
      child: Text(
        monsterName,
        style:Theme.of(context).textTheme.headline1,
        textAlign: TextAlign.center,
        overflow: TextOverflow.clip,
      ),
    );
  }
}

class _Background extends StatelessWidget {
  const _Background({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image(
        image: AssetImage("assets/img/page.png"),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        fit: BoxFit.cover,
      )
    );
  }
}

class _WeaknessesTab extends StatelessWidget {
  final List<Weakness> weaknesses;

  const _WeaknessesTab({@required this.weaknesses});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: weaknesses.length,
      physics: BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        
        crossAxisCount: 2,
        childAspectRatio: 5,
        crossAxisSpacing: 0.5,
        mainAxisSpacing: 2
      ), 
      itemBuilder: (context, index) {
        return _WeaknessWidget(weakness:weaknesses[index]);
      },
    );
  }
}

class _ResistancesTab extends StatelessWidget {
  final List<Resistance> resistances;

  const _ResistancesTab({@required this.resistances});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: resistances.length,
      physics: BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 5,
        crossAxisSpacing: 0.5,
        mainAxisSpacing: 2
      ), 
      itemBuilder: (context, index) {
        return _ResistanceWidget(resistance:resistances[index]);
      },
    );
  }
}
class _LocationTab extends StatelessWidget {
  final List<Location> locations;

  const _LocationTab({@required this.locations});

  @override
  Widget build(BuildContext context) {
    final controller = PageController(initialPage: 0);
    return Expanded(
        child: PageView.builder(
        physics: BouncingScrollPhysics(),
        pageSnapping: false,
        itemCount: locations.length,
        controller: controller,
        itemBuilder: (context, index) {
          return Column(
            children: [
              SizedBox(height: 5,),
              ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image(image: AssetImage("assets/locations/MHW-${locations[index].getPath()}.jpg"),height: 100,width: 200,)
              ),
              SizedBox(height:10,),
              Text(
                locations[index].name,
                style: Theme.of(context).textTheme.bodyText2,
              ),
              SizedBox(height:10,),
              SmoothPageIndicator(
                  controller: controller,
                  count: locations.length,
                  effect: ScrollingDotsEffect(
                    dotWidth: 8,
                    dotHeight: 8,
                    activeDotScale:1.5,
                    activeDotColor: Theme.of(context).primaryColor,
                    dotColor:Theme.of(context).primaryColor.withOpacity(0.8)
                  )),
            ],
          );
        },

      ),
    );
  }
}
class _WeaknessWidget extends StatelessWidget {
  final Weakness weakness;

  const _WeaknessWidget({@required this.weakness});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _LeadingWidget(element:weakness.element),
        _StarWidget(stars:weakness.stars)
      ],
    );
  }
}
class _ResistanceWidget extends StatelessWidget {
  final Resistance resistance;

  const _ResistanceWidget({@required this.resistance});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _LeadingWidget(element:resistance.element),
      ],
    );
  }
}
class _LeadingWidget extends StatelessWidget {
  final ElementMHW element;

  const _LeadingWidget({Key key, this.element}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children:[
        Image(image: AssetImage("assets/elements/${element.toString().split(".")[1].toLowerCase()}.png"),width: 30,height: 30,),
        Container(
          width: 60,
          child: Text(
            capitalize(element.toString().split(".")[1].toLowerCase()),
            style:Theme.of(context).textTheme.bodyText2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.clip,
            ),
        ),
        
      ]
    );
  }
}
class _StarWidget extends StatelessWidget {
  final int stars;

  const _StarWidget({@required this.stars});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List<Widget>.generate(stars, (index){
        return Container(margin:EdgeInsets.symmetric(horizontal: 5),child: Image(image: AssetImage("assets/img/star.png"), width: 20,height: 20,));
      }),
    );
  }
}

// To parse this JSON data, do
//
//     final monster = monsterFromJson(jsonString);

import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

List<Monster> monsterFromJson(String str) => List<Monster>.from(json.decode(str).map((x) => Monster.fromJson(x)));

String monsterToJson(List<Monster> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Monsters{
  List<Monster> items= new List();
  Monsters();
  Monsters.fromJsonList(List<dynamic> jsonList){
    if(jsonList==null) return;
    for(var item in jsonList){
      final monster= new Monster.fromJson(item);
      items.add(monster);
    }
  }
}

class Monster {
    Monster({
        this.id,
        this.type,
        this.species,
        this.elements,
        this.name,
        this.description,
        this.ailments,
        this.locations,
        this.resistances,
        this.weaknesses,
        this.rewards,
    });

    int id;
    MonsterType type;
    String species;
    List<ElementMHW> elements;
    String name;
    String description;
    List<Ailment> ailments;
    List<Location> locations;
    List<Resistance> resistances;
    List<Weakness> weaknesses;
    List<Reward> rewards;
    factory Monster.fromJson(Map<String, dynamic> json) => Monster(
        id: json["id"],
        type: monsterTypeValues.map[json["type"]],
        species: json["species"],
        elements: List<ElementMHW>.from(json["elements"].map((x) => elementValues.map[x])),
        name: json["name"],
        description: json["description"],
        ailments: List<Ailment>.from(json["ailments"].map((x) => Ailment.fromJson(x))),
        locations: List<Location>.from(json["locations"].map((x) => Location.fromJson(x))),
        resistances: List<Resistance>.from(json["resistances"].map((x) => Resistance.fromJson(x))),
        weaknesses: List<Weakness>.from(json["weaknesses"].map((x) => Weakness.fromJson(x))),
        rewards: List<Reward>.from(json["rewards"].map((x) => Reward.fromJson(x))), 
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type": monsterTypeValues.reverse[type],
        "species": species,
        "elements": List<dynamic>.from(elements.map((x) => elementValues.reverse[x])),
        "name": name,
        "description": description,
        "ailments": List<dynamic>.from(ailments.map((x) => x.toJson())),
        "locations": List<dynamic>.from(locations.map((x) => x.toJson())),
        "resistances": List<dynamic>.from(resistances.map((x) => x.toJson())),
        "weaknesses": List<dynamic>.from(weaknesses.map((x) => x.toJson())),
        "rewards": List<dynamic>.from(rewards.map((x) => x.toJson())),
    };
  Container getRender(){
    String pathRender= "https://monsterhunterworld.wiki.fextralife.com/file/Monster-Hunter-World/mhw-${_parseName(name)}_render_001.png";
    String pathRenderIceborne="https://monsterhunterworld.wiki.fextralife.com/file/Monster-Hunter-World/mhwi-${_parseName(name)}_render_001.png";
    return Container(
      height:200,
      width: 280,
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: CachedNetworkImage(imageUrl: pathRender, placeholder: (context, url) => Image.asset("assets/img/chargeImg.gif",fit: BoxFit.cover),errorWidget: (context, url, error) {
        return CachedNetworkImage(imageUrl: pathRenderIceborne, placeholder: (context, url) => Image.asset("assets/img/chargeImg.gif",fit: BoxFit.cover),errorWidget: (context, url, error) {
          return Image.asset("assets/img/question.png");
        },);
      },) 
    );
  }
  Container getIcon(){
      
    String path="https://monsterhunterworld.wiki.fextralife.com/file/Monster-Hunter-World/gthumbnails/mhw-${_parseName(name)}_icon.png";
    String pathIceborne="https://monsterhunterworld.wiki.fextralife.com/file/Monster-Hunter-World/gthumbnails/mhwi-${_parseName(name)}_icon.png";
    String pathOld="https://monsterhunterworld.wiki.fextralife.com/file/Monster-Hunter-World/gthumbnails/mhw-${_parseName(name)}_icon2.png";      
    String pathStrange="https://monsterhunterworld.wiki.fextralife.com/file/Monster-Hunter-World/gthumbnails/mhw-icono_${_parseName(name)}.png";
    return Container(
      
      width: 70,
      height: 70,
      child: CachedNetworkImage(imageUrl:path, placeholder: (context, url) => Image.asset("assets/img/chargeImg.gif",fit: BoxFit.cover,),errorWidget: (context, url, error) {
          return CachedNetworkImage(imageUrl: pathIceborne, placeholder: (context, url) => Image.asset("assets/img/chargeImg.gif",fit: BoxFit.cover), errorWidget: (context, url, error) {
            return CachedNetworkImage(imageUrl: pathOld, placeholder: (context, url) => Image.asset("assets/img/chargeImg.gif",fit: BoxFit.cover), errorWidget: (context, url, error) {
              return CachedNetworkImage(imageUrl: pathStrange, placeholder: (context, url) => Image.asset("assets/img/chargeImg.gif",fit: BoxFit.cover),errorWidget: (context, url, error) {
                return Image.asset("assets/img/question.png");
              },);
            },);
          },);
        },
      ),
    );
  }
  String _parseName(String name){
    return name.toLowerCase().replaceAll(RegExp(" "), "_");
  }
  
}

class Ailment {
    Ailment({
        this.id,
        this.name,
        this.description,
        this.recovery,
        this.protection,
    });

    int id;
    String name;
    String description;
    Recovery recovery;
    Protection protection;

    factory Ailment.fromJson(Map<String, dynamic> json) => Ailment(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        recovery: Recovery.fromJson(json["recovery"]),
        protection: Protection.fromJson(json["protection"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "recovery": recovery.toJson(),
        "protection": protection.toJson(),
    };
}

class Protection {
    Protection({
        this.skills,
        this.items,
    });

    List<Skill> skills;
    List<Item> items;

    factory Protection.fromJson(Map<String, dynamic> json) => Protection(
        skills: List<Skill>.from(json["skills"].map((x) => Skill.fromJson(x))),
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "skills": List<dynamic>.from(skills.map((x) => x.toJson())),
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
    };
}

class Item {
    Item({
        this.id,
        this.rarity,
        this.value,
        this.carryLimit,
        this.name,
        this.description,
    });

    int id;
    int rarity;
    int value;
    int carryLimit;
    String name;
    String description;

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        rarity: json["rarity"],
        value: json["value"],
        carryLimit: json["carryLimit"],
        name: json["name"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "rarity": rarity,
        "value": value,
        "carryLimit": carryLimit,
        "name": name,
        "description": description,
    };
}

class Skill {
    Skill({
        this.id,
        this.name,
        this.description,
    });

    int id;
    String name;
    String description;

    factory Skill.fromJson(Map<String, dynamic> json) => Skill(
        id: json["id"],
        name: json["name"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
    };
}

class Recovery {
    Recovery({
        this.actions,
        this.items,
    });

    List<Action> actions;
    List<Item> items;

    factory Recovery.fromJson(Map<String, dynamic> json) => Recovery(
        actions: List<Action>.from(json["actions"].map((x) => actionValues.map[x])),
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "actions": List<dynamic>.from(actions.map((x) => actionValues.reverse[x])),
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
    };
}

enum Action { DODGE }

final actionValues = EnumValues({
    "dodge": Action.DODGE
});

enum ElementMHW { WATER, THUNDER, FIRE, DRAGON, ICE, POISON, SLEEP, BLAST, PARALYSIS, STUN }

final elementValues = EnumValues({
    "blast": ElementMHW.BLAST,
    "dragon": ElementMHW.DRAGON,
    "fire": ElementMHW.FIRE,
    "ice": ElementMHW.ICE,
    "paralysis": ElementMHW.PARALYSIS,
    "poison": ElementMHW.POISON,
    "sleep": ElementMHW.SLEEP,
    "stun": ElementMHW.STUN,
    "thunder": ElementMHW.THUNDER,
    "water": ElementMHW.WATER
});

class Location {
    Location({
        this.id,
        this.zoneCount,
        this.name,
    });

    int id;
    int zoneCount;
    String name;

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["id"],
        zoneCount: json["zoneCount"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "zoneCount": zoneCount,
        "name": name,
    };
    String getPath(){
      return this.name.replaceAll(" ", "_");
    }
}

class Resistance {
    Resistance({
        this.element,
        this.condition,
    });

    ElementMHW element;
    String condition;

    factory Resistance.fromJson(Map<String, dynamic> json) => Resistance(
        element: elementValues.map[json["element"]],
        condition: json["condition"] == null ? null : json["condition"],
    );

    Map<String, dynamic> toJson() => {
        "element": elementValues.reverse[element],
        "condition": condition == null ? null : condition,
    };
}

class Reward {
    Reward({
        this.id,
        this.item,
        this.conditions,
    });

    int id;
    Item item;
    List<Condition> conditions;

    factory Reward.fromJson(Map<String, dynamic> json) => Reward(
        id: json["id"],
        item: Item.fromJson(json["item"]),
        conditions: List<Condition>.from(json["conditions"].map((x) => Condition.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "item": item.toJson(),
        "conditions": List<dynamic>.from(conditions.map((x) => x.toJson())),
    };
}

class Condition {
    Condition({
        this.type,
        this.rank,
        this.quantity,
        this.chance,
        this.subtype,
    });

    ConditionType type;
    Rank rank;
    int quantity;
    int chance;
    String subtype;

    factory Condition.fromJson(Map<String, dynamic> json) => Condition(
        type: conditionTypeValues.map[json["type"]],
        rank: rankValues.map[json["rank"]],
        quantity: json["quantity"],
        chance: json["chance"],
        subtype: json["subtype"] == null ? null : json["subtype"],
    );

    Map<String, dynamic> toJson() => {
        "type": conditionTypeValues.reverse[type],
        "rank": rankValues.reverse[rank],
        "quantity": quantity,
        "chance": chance,
        "subtype": subtype == null ? null : subtype,
    };
}

enum Rank { LOW, HIGH }

final rankValues = EnumValues({
    "high": Rank.HIGH,
    "low": Rank.LOW
});

enum ConditionType { CARVE, REWARD, INVESTIGATION, PLUNDERBLADE, TRACK, WOUND, SHINY, PALICO }

final conditionTypeValues = EnumValues({
    "carve": ConditionType.CARVE,
    "investigation": ConditionType.INVESTIGATION,
    "palico": ConditionType.PALICO,
    "plunderblade": ConditionType.PLUNDERBLADE,
    "reward": ConditionType.REWARD,
    "shiny": ConditionType.SHINY,
    "track": ConditionType.TRACK,
    "wound": ConditionType.WOUND
});

enum MonsterType { SMALL, LARGE }

final monsterTypeValues = EnumValues({
    "large": MonsterType.LARGE,
    "small": MonsterType.SMALL
});

class Weakness {
    Weakness({
        this.element,
        this.stars,
        this.condition,
    });

    ElementMHW element;
    int stars;
    String condition;

    factory Weakness.fromJson(Map<String, dynamic> json) => Weakness(
        element: elementValues.map[json["element"]],
        stars: json["stars"],
        condition: json["condition"] == null ? null : json["condition"],
    );

    Map<String, dynamic> toJson() => {
        "element": elementValues.reverse[element],
        "stars": stars,
        "condition": condition == null ? null : condition,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}

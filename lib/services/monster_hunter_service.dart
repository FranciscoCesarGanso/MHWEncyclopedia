import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mhencicopledia/models/monster.dart';

class MonsterHunterService{
  String _url="mhw-db.com";

  Future<List<Monster>> getMonsters() async{
    final url=Uri.https(_url, "/monsters");
    final resp= await http.get(url);
    final decodeData=json.decode(resp.body);
    final monsters=Monsters.fromJsonList(decodeData);
    return monsters.items;
  }
}
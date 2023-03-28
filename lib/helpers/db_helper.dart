import 'package:flutter/foundation.dart';
import 'package:flutter_cookbook/models/tag.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

import '../models/ingredient.dart';
import '../models/recipe.dart';

enum DBTables {
  recipes,
  ingredients,
  tags;

  @override
  String toString() {
    return super.toString().split('.').last;
  }
}

/// A class that provides functions for SQLite database
class DBHelper {
  static bool _isPopulating = false;

  /// Open database and create tables if they don't exist yet
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    var db = await sql.openDatabase(
      path.join(dbPath, 'cookBook.db'),
      onCreate: (db, version) async {
        if (kDebugMode) {
          print('Database created');
        }
        await db.execute(
            'CREATE TABLE ${DBTables.recipes} (id INTEGER PRIMARY KEY, name TEXT, content TEXT, ingredients TEXT, ingredients_size TEXT, tags TEXT, imagePath TEXT)');
        await db.execute(
            'CREATE TABLE ${DBTables.ingredients} (id INTEGER PRIMARY KEY, name TEXT, weightType INTEGER)');
        await db.execute(
            'CREATE TABLE ${DBTables.tags} (id INTEGER PRIMARY KEY, name TEXT)');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (kDebugMode) {
          print('Database upgraded from version $oldVersion to $newVersion');
        }
        if (oldVersion < 3) {
          await db.execute(
              'ALTER ${DBTables.ingredients} ADD COLUMN weightType INTEGER');
        }
      },
      onConfigure: (db) {
        if (kDebugMode) {
          print('Database configured');
        }
      },
      onDowngrade: (db, oldVersion, newVersion) {
        if (kDebugMode) {
          print('Database downgraded from version $oldVersion to $newVersion');
        }
      },
      onOpen: (db) async {
        if (kDebugMode) {
          print('Database opened');
        }
        if (kDebugMode) {
          print('Database version: ${await db.getVersion()}');
        }
      },
      version: 2,
    );

    ///uncomment to populate database with ingredients
    // var query = await db.query('${DBTables.ingredients}');
    // // print('Ingredients: ${query.length}');
    // if (query.isEmpty && _isPopulating == false) {
    //   _isPopulating = true;
    //   await DBHelper._populateIngredients();
    // }

    return db;
  }

  ///populate database with ingredients
  // static Future<void> _populateIngredients() async {
  //   _isPopulating = true;
  //   Map<String, IngredientWeightType> ingredients = {};
  //   ingredients["Advocaat"] = IngredientWeightType.mililiters;
  //   ingredients["Adwokat"] = IngredientWeightType.mililiters;
  //   ingredients["Agrest"] = IngredientWeightType.grams;
  //   ingredients["Amaretto"] = IngredientWeightType.mililiters;
  //   ingredients["Ananas"] = IngredientWeightType.grams;
  //   ingredients["Anyż"] = IngredientWeightType.grams;
  //   ingredients["Arbuz"] = IngredientWeightType.grams;
  //   ingredients["Awokado"] = IngredientWeightType.grams;
  //   ingredients["Bagietka"] = IngredientWeightType.pieces;
  //   ingredients["Bakalie"] = IngredientWeightType.grams;
  //   ingredients["Bakłażan"] = IngredientWeightType.grams;
  //   ingredients["Banan"] = IngredientWeightType.grams;
  //   ingredients["Bataty"] = IngredientWeightType.grams;
  //   ingredients["Bazylia"] = IngredientWeightType.grams;
  //   ingredients["Beza"] = IngredientWeightType.grams;
  //   ingredients["Biała czekolada"] = IngredientWeightType.grams;
  //   ingredients["Biała kiełbasa"] = IngredientWeightType.grams;
  //   ingredients["Białko"] = IngredientWeightType.grams;
  //   ingredients["Biały rum"] = IngredientWeightType.mililiters;
  //   ingredients["Biszkopt"] = IngredientWeightType.grams;
  //   ingredients["Bita śmietana"] = IngredientWeightType.grams;
  //   ingredients["Boczek"] = IngredientWeightType.grams;
  //   ingredients["Boczek gotowany"] = IngredientWeightType.grams;
  //   ingredients["Boczek wędzony"] = IngredientWeightType.grams;
  //   ingredients["Boczniak"] = IngredientWeightType.grams;
  //   ingredients["Bolognese"] = IngredientWeightType.grams;
  //   ingredients["Borowik"] = IngredientWeightType.grams;
  //   ingredients["Borówki"] = IngredientWeightType.grams;
  //   ingredients["Botwinka"] = IngredientWeightType.grams;
  //   ingredients["Bourbon"] = IngredientWeightType.mililiters;
  //   ingredients["Brandy"] = IngredientWeightType.mililiters;
  //   ingredients["Brokuły"] = IngredientWeightType.grams;
  //   ingredients["Brukselka"] = IngredientWeightType.grams;
  //   ingredients["Bryndza"] = IngredientWeightType.grams;
  //   ingredients["Brzoskwinia"] = IngredientWeightType.grams;
  //   ingredients["Budyń"] = IngredientWeightType.grams;
  //   ingredients["Bulgur"] = IngredientWeightType.grams;
  //   // ingredients["Bulion"] = IngredientWeightType.;
  //   // ingredients["Bulion Warzywny"] = IngredientWeightType.;
  //   // ingredients["Bulion drobiowy"] = IngredientWeightType.;
  //   // ingredients["Bulion wołowy"] = IngredientWeightType.;
  //   ingredients["Burak"] = IngredientWeightType.grams;
  //   ingredients["Burbon"] = IngredientWeightType.mililiters;
  //   ingredients["Camembert"] = IngredientWeightType.grams;
  //   ingredients["Bułka"] = IngredientWeightType.pieces;
  //   // ingredients["Bułka hamburgerowa"] = IngredientWeightType.;
  //   ingredients["Bułka tarta"] = IngredientWeightType.grams;
  //   // ingredients["Bułka wieloziarnista"] = IngredientWeightType.;
  //   ingredients["Bób"] = IngredientWeightType.grams;
  //   ingredients["Cebula"] = IngredientWeightType.grams;
  //   // ingredients["Champagne"] = IngredientWeightType.;
  //   ingredients["Chałka"] = IngredientWeightType.grams;
  //   ingredients["Chałwa"] = IngredientWeightType.grams;
  //   ingredients["Cheddar"] = IngredientWeightType.grams;
  //   ingredients["Chili"] = IngredientWeightType.grams;
  //   ingredients["Chleb"] = IngredientWeightType.pieces;
  //   ingredients["Chleb graham"] = IngredientWeightType.pieces;
  //   ingredients["Chleb pszenny"] = IngredientWeightType.pieces;
  //   ingredients["Chleb tostowy"] = IngredientWeightType.pieces;
  //   ingredients["Chleb wieloziarnisty"] = IngredientWeightType.pieces;
  //   ingredients["Chleb żytni"] = IngredientWeightType.pieces;
  //   ingredients["Chrzan"] = IngredientWeightType.grams;
  //   ingredients["Ciecierzyca"] = IngredientWeightType.grams;
  //   ingredients["Cielęcina"] = IngredientWeightType.grams;
  //   ingredients["Cukier"] = IngredientWeightType.grams;
  //   ingredients["Cukier biały"] = IngredientWeightType.grams;
  //   ingredients["Cukier puder"] = IngredientWeightType.grams;
  //   ingredients["Cukier trzcinowy"] = IngredientWeightType.grams;
  //   ingredients["Cukier wanilinowy"] = IngredientWeightType.grams;
  //   ingredients["Cukinia"] = IngredientWeightType.grams;
  //   ingredients["Curry"] = IngredientWeightType.grams;
  //   ingredients["Cykoria"] = IngredientWeightType.grams;
  //   ingredients["Cynamon"] = IngredientWeightType.grams;
  //   ingredients["Cynk"] = IngredientWeightType.grams;
  //   ingredients["Cytryna"] = IngredientWeightType.grams;
  //   ingredients["Czarna porzeczka"] = IngredientWeightType.grams;
  //   ingredients["Czekolada"] = IngredientWeightType.grams;
  //   ingredients["Czekolada mleczna"] = IngredientWeightType.grams;
  //   ingredients["Czereśnie"] = IngredientWeightType.grams;
  //   ingredients["Czerwona porzeczka"] = IngredientWeightType.grams;
  //   ingredients["Czosnek"] = IngredientWeightType.grams;
  //   ingredients["Cząber"] = IngredientWeightType.grams;
  //   ingredients["Daktyle"] = IngredientWeightType.grams;
  //   ingredients["Dorsz"] = IngredientWeightType.grams;
  //   ingredients["Drożdże"] = IngredientWeightType.grams;
  //   ingredients["Dynia"] = IngredientWeightType.grams;
  //   ingredients["Dziczyzna"] = IngredientWeightType.grams;
  //   ingredients["Dżem"] = IngredientWeightType.grams;
  //   ingredients["Fasola"] = IngredientWeightType.grams;
  //   ingredients["Fasolka szparagowa"] = IngredientWeightType.grams;
  //   ingredients["Feta"] = IngredientWeightType.grams;
  //   ingredients["Figa"] = IngredientWeightType.grams;
  //   ingredients["Frytki"] = IngredientWeightType.grams;
  //   ingredients["Galaretka"] = IngredientWeightType.grams;
  //   ingredients["Gałka muszkatołowa"] = IngredientWeightType.grams;
  //   ingredients["Gin"] = IngredientWeightType.mililiters;
  //   ingredients["Gofry"] = IngredientWeightType.grams;
  //   ingredients["Golonka"] = IngredientWeightType.grams;
  //   ingredients["Gorzka czekolada"] = IngredientWeightType.grams;
  //   ingredients["Gouda"] = IngredientWeightType.grams;
  //   ingredients["Goździk"] = IngredientWeightType.grams;
  //   ingredients["Granat"] = IngredientWeightType.grams;
  //   ingredients["Grejpfrut"] = IngredientWeightType.grams;
  //   ingredients["Groch"] = IngredientWeightType.grams;
  //   ingredients["Groszek"] = IngredientWeightType.grams;
  //   ingredients["Gruszka"] = IngredientWeightType.grams;
  //   ingredients["Grysik"] = IngredientWeightType.grams;
  //   ingredients["Grzanki"] = IngredientWeightType.pieces;
  // ingredients["Grzyby marynowane"] = IngredientWeightType.;
  // ingredients["Grzyby suszone"] = IngredientWeightType.;
  // ingredients["Gęsina"] = IngredientWeightType.;
  // ingredients["Halibut"] = IngredientWeightType.;
  // ingredients["Herbata"] = IngredientWeightType.;
  // ingredients["Hibiskus"] = IngredientWeightType.;
  // ingredients["Homar"] = IngredientWeightType.;
  // ingredients["Imbir"] = IngredientWeightType.;
  // ingredients["Indyk"] = IngredientWeightType.;
  // ingredients["Jabłko"] = IngredientWeightType.;
  // ingredients["Jagermeister"] = IngredientWeightType.;
  // ingredients["Jagnięcina"] = IngredientWeightType.;
  // ingredients["Jagody"] = IngredientWeightType.;
  // ingredients["Jajka"] = IngredientWeightType.;
  // ingredients["Jarmuż"] = IngredientWeightType.;
  // ingredients["Jeżyny"] = IngredientWeightType.;
  // ingredients["Jod"] = IngredientWeightType.;
  // ingredients["Jogurt"] = IngredientWeightType.;
  // ingredients["Jogurt grecki"] = IngredientWeightType.;
  // ingredients["Kabaczek"] = IngredientWeightType.;
  // ingredients["Kabanos"] = IngredientWeightType.;
  // ingredients["Kaczka"] = IngredientWeightType.;
  // ingredients["Kakao"] = IngredientWeightType.;
  // ingredients["Kaki"] = IngredientWeightType.;
  // ingredients["Kalafior"] = IngredientWeightType.;
  // ingredients["Kalarepa"] = IngredientWeightType.;
  // ingredients["Kalmary"] = IngredientWeightType.;
  // ingredients["Kalorie"] = IngredientWeightType.;
  // ingredients["Kapusta biała"] = IngredientWeightType.;
  // ingredients["Kapusta czerwona"] = IngredientWeightType.;
  // ingredients["Kapusta pekińska"] = IngredientWeightType.;
  // ingredients["Karczochy"] = IngredientWeightType.;
  // ingredients["Karkówka"] = IngredientWeightType.;
  // ingredients["Karmel"] = IngredientWeightType.;
  // ingredients["Karp"] = IngredientWeightType.;
  // ingredients["Kasza"] = IngredientWeightType.;
  // ingredients["Kasza gryczana"] = IngredientWeightType.;
  // ingredients["Kasza jaglana"] = IngredientWeightType.;
  // ingredients["Kasza jęczmienna"] = IngredientWeightType.;
  // ingredients["Kasza manna"] = IngredientWeightType.;
  // ingredients["Kasza orkiszowa"] = IngredientWeightType.;
  // ingredients["Kasza pęczak"] = IngredientWeightType.;
  // ingredients["Kasztany jadalne"] = IngredientWeightType.;
  // ingredients["Kawa"] = IngredientWeightType.;
  // ingredients["Kebab"] = IngredientWeightType.;
  // ingredients["Kefir"] = IngredientWeightType.;
  // ingredients["Ketchup"] = IngredientWeightType.;
  // ingredients["Kiełbasa"] = IngredientWeightType.;
  // ingredients["Kiełbasa wędzona"] = IngredientWeightType.;
  // ingredients["Kiełki"] = IngredientWeightType.;
  // ingredients["Kisiel"] = IngredientWeightType.;
  // ingredients["Kiszona kapusta"] = IngredientWeightType.;
  // ingredients["Kiwi"] = IngredientWeightType.;
  // ingredients["Kokos"] = IngredientWeightType.;
  // ingredients["Kolendra"] = IngredientWeightType.;
  // ingredients["Komosa ryżowa"] = IngredientWeightType.;
  // ingredients["Koniak"] = IngredientWeightType.;
  // ingredients["Koper"] = IngredientWeightType.;
  // ingredients["Koper włoski"] = IngredientWeightType.;
  // ingredients["Koperek"] = IngredientWeightType.;
  // ingredients["Korniszon"] = IngredientWeightType.;
  // ingredients["Krab"] = IngredientWeightType.;
  // ingredients["Krewetki"] = IngredientWeightType.;
  // ingredients["Królik"] = IngredientWeightType.;
  // ingredients["Ksylitol"] = IngredientWeightType.;
  // ingredients["Kukurydza"] = IngredientWeightType.;
  // ingredients["Kumin"] = IngredientWeightType.;
  // ingredients["Kurczak"] = IngredientWeightType.;
  // ingredients["Kurka"] = IngredientWeightType.;
  // ingredients["Kurkuma"] = IngredientWeightType.;
  // ingredients["Kuskus"] = IngredientWeightType.;
  // ingredients["Kwas foliowy"] = IngredientWeightType.;
  // ingredients["Kwas pantotenowy"] = IngredientWeightType.;
  // ingredients["Kwiat lipy"] = IngredientWeightType.;
  // ingredients["Kwiaty cukinii"] = IngredientWeightType.;
  // ingredients["Langusta"] = IngredientWeightType.;
  // ingredients["Likier"] = IngredientWeightType.;
  // ingredients["Limonka"] = IngredientWeightType.;
  // ingredients["Magnez"] = IngredientWeightType.;
  // ingredients["Majeranek"] = IngredientWeightType.;
  // ingredients["Majonez"] = IngredientWeightType.;
  // ingredients["Mak"] = IngredientWeightType.;
  // ingredients["Makaron"] = IngredientWeightType.;
  // ingredients["Makaron lasagne"] = IngredientWeightType.;
  // ingredients["Makaron spaghetti"] = IngredientWeightType.;
  // ingredients["Makrela"] = IngredientWeightType.;
  // ingredients["Maliny"] = IngredientWeightType.;
  // ingredients["Mandarynka"] = IngredientWeightType.;
  // ingredients["Mangan"] = IngredientWeightType.;
  // ingredients["Mango"] = IngredientWeightType.;
  // ingredients["Marakuja"] = IngredientWeightType.;
  // ingredients["Marcepan"] = IngredientWeightType.;
  // ingredients["Marchewka"] = IngredientWeightType.;
  // ingredients["Margaryna"] = IngredientWeightType.;
  // ingredients["Mascarpone"] = IngredientWeightType.;
  // ingredients["Masło"] = IngredientWeightType.;
  // ingredients["Małże"] = IngredientWeightType.;
  // ingredients["Maślak"] = IngredientWeightType.;
  // ingredients["Maślanka"] = IngredientWeightType.;
  // ingredients["Melisa"] = IngredientWeightType.;
  // ingredients["Melon"] = IngredientWeightType.;
  // ingredients["Metaxa"] = IngredientWeightType.;
  // ingredients["Miedź"] = IngredientWeightType.;
  // ingredients["Migdały"] = IngredientWeightType.;
  // ingredients["Mintaj"] = IngredientWeightType.;
  // ingredients["Miód"] = IngredientWeightType.;
  // ingredients["Mięso dzika"] = IngredientWeightType.;
  // ingredients["Mięso mielone"] = IngredientWeightType.;
  // ingredients["Mięso mielone drobiowe"] = IngredientWeightType.;
  // ingredients["Mięso mielone wieprzowe"] = IngredientWeightType.;
  // ingredients["Mięso mielone wieprzowo – wołowe"] = IngredientWeightType.;
  // ingredients["Mięso mielone wołowe"] = IngredientWeightType.;
  // ingredients["Mięta"] = IngredientWeightType.;
  // ingredients["Mleko"] = IngredientWeightType.;
  // ingredients["Mleko kokosowe"] = IngredientWeightType.;
  // ingredients["Mleko migdałowe"] = IngredientWeightType.;
  // ingredients["Mleko skondensowane"] = IngredientWeightType.;
  // ingredients["Mleko sojowe"] = IngredientWeightType.;
  // ingredients["Mleko w proszku"] = IngredientWeightType.;
  // ingredients["Molibden"] = IngredientWeightType.;
  // ingredients["Morela"] = IngredientWeightType.;
  // ingredients["Mozzarella"] = IngredientWeightType.;
  // ingredients["Mun"] = IngredientWeightType.;
  // ingredients["Musztarda"] = IngredientWeightType.;
  // ingredients["Mąka"] = IngredientWeightType.;
  // ingredients["Mąka kokosowa"] = IngredientWeightType.;
  // ingredients["Mąka kukurydziana"] = IngredientWeightType.;
  // ingredients["Mąka orkiszowa"] = IngredientWeightType.;
  // ingredients["Mąka pszenna"] = IngredientWeightType.;
  // ingredients["Mąka ziemniaczana"] = IngredientWeightType.;
  // ingredients["Mąka żytnia"] = IngredientWeightType.;
  // ingredients["Młoda kapusta"] = IngredientWeightType.;
  // ingredients["Nalewka"] = IngredientWeightType.;
  // ingredients["Natka pietruszki"] = IngredientWeightType.;
  // ingredients["Nektarynka"] = IngredientWeightType.;
  // ingredients["Niacyna"] = IngredientWeightType.;
  // ingredients["Numer telefonu"] = IngredientWeightType.;
  // ingredients["Nutella"] = IngredientWeightType.;
  // ingredients["Ocet"] = IngredientWeightType.;
  // ingredients["Ogórek"] = IngredientWeightType.;
  // ingredients["Ogórek kiszony"] = IngredientWeightType.;
  // ingredients["Ogórek konserwowy"] = IngredientWeightType.;
  // ingredients["Olej"] = IngredientWeightType.;
  // ingredients["Olej kokosowy"] = IngredientWeightType.;
  // ingredients["Oliwa"] = IngredientWeightType.;
  // ingredients["Oliwki"] = IngredientWeightType.;
  // ingredients["Opieniek"] = IngredientWeightType.;
  // ingredients["Oregano"] = IngredientWeightType.;
  // ingredients["Orzechy laskowe"] = IngredientWeightType.;
  // ingredients["Orzechy włoskie"] = IngredientWeightType.;
  // ingredients["Orzeszki piniowe"] = IngredientWeightType.;
  // ingredients["Orzeszki ziemne"] = IngredientWeightType.;
  // ingredients["Otręby"] = IngredientWeightType.;
  // ingredients["Owoce leśne"] = IngredientWeightType.;
  // ingredients["Ośmiornica"] = IngredientWeightType.;
  // ingredients["Pak choi"] = IngredientWeightType.;
  // ingredients["Papaja"] = IngredientWeightType.;
  // ingredients["Papryczka chili"] = IngredientWeightType.;
  // ingredients["Papryczka jalapeño"] = IngredientWeightType.;
  // ingredients["Papryka"] = IngredientWeightType.;
  // ingredients["Parmezan"] = IngredientWeightType.;
  // ingredients["Parówki"] = IngredientWeightType.;
  // ingredients["Pasztet"] = IngredientWeightType.;
  // ingredients["Perliczka"] = IngredientWeightType.;
  // ingredients["Pieczarka"] = IngredientWeightType.;
  // ingredients["Pieczone mięso"] = IngredientWeightType.;
  // ingredients["Pieprz czarny"] = IngredientWeightType.;
  // ingredients["Pietruszka"] = IngredientWeightType.;
  // ingredients["Pigwa"] = IngredientWeightType.;
  // ingredients["Pini"] = IngredientWeightType.;
  // ingredients["Pistacje"] = IngredientWeightType.;
  // ingredients["Pita"] = IngredientWeightType.;
  // ingredients["Piwo"] = IngredientWeightType.;
  // ingredients["Podgrzybek"] = IngredientWeightType.;
  // ingredients["Podroby"] = IngredientWeightType.;
  // ingredients["Pomarańcza"] = IngredientWeightType.;
  // ingredients["Pomelo"] = IngredientWeightType.;
  // ingredients["Pomidory"] = IngredientWeightType.;
  // ingredients["Por"] = IngredientWeightType.;
  // ingredients["Porzeczka"] = IngredientWeightType.;
  // ingredients["Potas"] = IngredientWeightType.;
  // ingredients["Poziomka"] = IngredientWeightType.;
  // ingredients["Prawdziwek"] = IngredientWeightType.;
  // ingredients["Prażona cebula"] = IngredientWeightType.;
  // ingredients["Prosecco"] = IngredientWeightType.;
  // ingredients["Przegrzebki"] = IngredientWeightType.;
  // ingredients["Pstrąg"] = IngredientWeightType.;
  // ingredients["Pęczak"] = IngredientWeightType.;
  // ingredients["Rabarbar"] = IngredientWeightType.;
  // ingredients["Rodzynki"] = IngredientWeightType.;
  // ingredients["Rostbef"] = IngredientWeightType.;
  // ingredients["Roszponka"] = IngredientWeightType.;
  // ingredients["Rosół"] = IngredientWeightType.;
  // ingredients["Rozmaryn"] = IngredientWeightType.;
  // ingredients["Rukola"] = IngredientWeightType.;
  // ingredients["Rum"] = IngredientWeightType.;
  // ingredients["Ryboflawina"] = IngredientWeightType.;
  // ingredients["Rydz"] = IngredientWeightType.;
  // ingredients["Ryż"] = IngredientWeightType.;
  // ingredients["Ryż biały"] = IngredientWeightType.;
  // ingredients["Ryż czarny"] = IngredientWeightType.;
  // ingredients["Ryż czerwony"] = IngredientWeightType.;
  // ingredients["Rzodkiewka"] = IngredientWeightType.;
  // ingredients["Salami"] = IngredientWeightType.;
  // ingredients["Sandacz"] = IngredientWeightType.;
  // ingredients["Sangria"] = IngredientWeightType.;
  // ingredients["Sarnina"] = IngredientWeightType.;
  // ingredients["Sałata"] = IngredientWeightType.;
  // ingredients["Sałata lodowa"] = IngredientWeightType.;
  // ingredients["Schab"] = IngredientWeightType.;
  // ingredients["Selen"] = IngredientWeightType.;
  // ingredients["Seler"] = IngredientWeightType.;
  // ingredients["Seler korzeniowy"] = IngredientWeightType.;
  // ingredients["Seler naciowy"] = IngredientWeightType.;
  // ingredients["Ser biały"] = IngredientWeightType.;
  // ingredients["Ser pleśniowy"] = IngredientWeightType.;
  // ingredients["Ser żółty"] = IngredientWeightType.;
  // ingredients["Serek homogenizowany"] = IngredientWeightType.;
  // ingredients["Serek kanapkowy"] = IngredientWeightType.;
  // ingredients["Serek wiejski"] = IngredientWeightType.;
  // ingredients["Sezam"] = IngredientWeightType.;
  // ingredients["Shitake"] = IngredientWeightType.;
  // ingredients["Skwarki"] = IngredientWeightType.;
  // ingredients["Smalec"] = IngredientWeightType.;
  // ingredients["Soczewica"] = IngredientWeightType.;
  // ingredients["Soda oczyszczona"] = IngredientWeightType.;
  // ingredients["Sola"] = IngredientWeightType.;
  // ingredients["Sos sojowy"] = IngredientWeightType.;
  // ingredients["Spirytus"] = IngredientWeightType.;
  // ingredients["Stek"] = IngredientWeightType.;
  // ingredients["Syrop klonowy"] = IngredientWeightType.;
  // ingredients["Szampan"] = IngredientWeightType.;
  // ingredients["Szałwia"] = IngredientWeightType.;
  // ingredients["Szczaw"] = IngredientWeightType.;
  // ingredients["Szczupak"] = IngredientWeightType.;
  // ingredients["Szczypiorek"] = IngredientWeightType.;
  // ingredients["Szparagi"] = IngredientWeightType.;
  // ingredients["Szpinak"] = IngredientWeightType.;
  // ingredients["Szprotki"] = IngredientWeightType.;
  // ingredients["Szynka"] = IngredientWeightType.;
  // ingredients["Szynka parmeńska"] = IngredientWeightType.;
  // ingredients["Szynka wędzona"] = IngredientWeightType.;
  // ingredients["Sód"] = IngredientWeightType.;
  // ingredients["Sól"] = IngredientWeightType.;
  // ingredients["Słonecznik"] = IngredientWeightType.;
  // ingredients["Tequila"] = IngredientWeightType.;
  // ingredients["Tiamina"] = IngredientWeightType.;
  // ingredients["Topinambur"] = IngredientWeightType.;
  // ingredients["Tortilla"] = IngredientWeightType.;
  // ingredients["Trawa cytrynowa"] = IngredientWeightType.;
  // ingredients["Truskawka"] = IngredientWeightType.;
  // ingredients["Tuńczyk"] = IngredientWeightType.;
  // ingredients["Twaróg"] = IngredientWeightType.;
  // ingredients["Tymianek"] = IngredientWeightType.;
  // ingredients["Wanilia"] = IngredientWeightType.;
  // ingredients["Whisky"] = IngredientWeightType.;
  // ingredients["Wieprzowina"] = IngredientWeightType.;
  // ingredients["Wino"] = IngredientWeightType.;
  // ingredients["Wino białe"] = IngredientWeightType.;
  // ingredients["Wino czerwone"] = IngredientWeightType.;
  // ingredients["Wino różowe"] = IngredientWeightType.;
  // ingredients["Winogrono"] = IngredientWeightType.;
  // ingredients["Wiśnia"] = IngredientWeightType.;
  // ingredients["Wołowina"] = IngredientWeightType.;
  // ingredients["Wódka"] = IngredientWeightType.;
  // ingredients["Ziele angielskie"] = IngredientWeightType.;
  // ingredients["Ziemniaki"] = IngredientWeightType.;
  // ingredients["Łosoś"] = IngredientWeightType.;
  // ingredients["Łosoś wędzony"] = IngredientWeightType.;
  // ingredients["Śledzie"] = IngredientWeightType.;
  // ingredients["Śliwka"] = IngredientWeightType.;
  // ingredients["Śmietana"] = IngredientWeightType.;
  // ingredients["Żeberka"] = IngredientWeightType.;
  // ingredients["Żelatyna"] = IngredientWeightType.;
  // ingredients["Żurawina"] = IngredientWeightType.;
  //   int i = 0;
  //   for (var ingredient in ingredients.keys) {
  //     print(ingredient);
  //     print(ingredients[ingredient]!);
  //     DBHelper.insertIngredient(Ingredient.id(
  //       id: i++,
  //       name: ingredient,
  //       weightType: ingredients[ingredient]!,
  //     ));
  //   }
  // }

  /// Get all tags from the database
  static Future<List<Tag>> getTags() async {
    final db = await DBHelper.database();
    final List<Map<String, dynamic>> maps = await db.query('${DBTables.tags}');
    return List.generate(maps.length, (i) {
      return Tag.id(
        id: maps[i]['id'],
        name: maps[i]['name'],
      );
    });
  }

  /// Insert a [tag] into the database
  /// Returns the id of the inserted row.
  static Future<int> insertTag(Tag tag) async {
    final db = await DBHelper.database();
    return db.insert('${DBTables.tags}', tag.toMap(),
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  /// Update a [tag] in the database
  /// Returns the number of rows affected by the update operation.
  static Future<int> updateTag(Tag tag) async {
    final db = await DBHelper.database();
    return db.update('${DBTables.tags}', tag.toMap(),
        where: 'id = ?', whereArgs: [tag.id]);
  }

  /// Delete a [tag] from the database
  /// Returns the number of rows affected by the delete operation.
  static Future<int> deleteTag(Tag tag) async {
    final db = await DBHelper.database();
    return db.delete('${DBTables.tags}', where: 'id = ?', whereArgs: [tag.id]);
  }

  /// Get all ingredients from the database
  static Future<List<Ingredient>> getIngredients() async {
    final db = await DBHelper.database();
    final List<Map<String, dynamic>> maps =
        await db.query('${DBTables.ingredients}');
    return List.generate(maps.length, (i) {
      return Ingredient.id(
        id: maps[i]['id'],
        name: maps[i]['name'],
        weightType: IngredientWeightType.values[maps[i]['weightType']],
      );
    });
  }

  /// Insert an [ingredient] into the database
  /// Returns the id of the inserted row.
  static Future<int> insertIngredient(Ingredient ingredient) async {
    final db = await DBHelper.database();
    return db.insert('${DBTables.ingredients}', ingredient.toMap(),
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  /// Update an [ingredient] in the database
  /// Returns the number of rows affected by the update operation.
  static Future<int> updateIngredient(Ingredient ingredient) async {
    final db = await DBHelper.database();
    return db.update('${DBTables.ingredients}', ingredient.toMap(),
        where: 'id = ?', whereArgs: [ingredient.id]);
  }

  /// Delete an [ingredient] from the database
  /// Returns the number of rows affected by the delete operation.
  static Future<int> deleteIngredient(Ingredient ingredient) async {
    final db = await DBHelper.database();
    return db.delete('${DBTables.ingredients}',
        where: 'id = ?', whereArgs: [ingredient.id]);
  }

  /// Get all recipes from the database. Needs a list of [tags] and [ingredients] to add the tags and ingredients to the recipe.
  static Future<List<Recipe>> getRecipes(
    List<Tag> tags,
    List<Ingredient> ingredients,
  ) async {
    if (tags.isEmpty || ingredients.isEmpty) {
      return [];
    }
    final db = await DBHelper.database();
    final List<Map<String, dynamic>> maps =
        await db.query('${DBTables.recipes}');
    return List.generate(maps.length, (i) {
      Recipe recipe = Recipe.id(
        id: maps[i]['id'],
        description: maps[i]['content'],
        title: maps[i]['name'],
        imgPath: maps[i]['imagePath'],
      );

      String tmpTags = maps[i]
          ['tags']; //tags are stored as a string with the ids separated by ';'
      List<String> splitedTags = tmpTags.split(';'); // split them
      splitedTags.removeWhere((element) => element == "");
      for (var element in splitedTags) {
        // add the tag of given ID to the recipe
        recipe.addTag(tags.firstWhere((tag) => tag.id == int.parse(element)));
      }

      //ingredients are stored as a string with the ids separated by ';' and the size separated by ','
      String tmpIngredientsWithSize = maps[i]['ingredients'];
      List<String> splitedIngredientsWithSize =
          tmpIngredientsWithSize.split(';'); // split ingredients
      splitedIngredientsWithSize.removeWhere((element) => element == "");
      for (var element in splitedIngredientsWithSize) {
        List<String> ingredientWithSize =
            element.split(','); // split ingredient and size
        recipe.addIngredient(
          ingredients.firstWhere(
            (ingredient) => ingredient.id == int.parse(ingredientWithSize[0]),
          ),
          double.parse(ingredientWithSize[1]),
        );
      }
      return recipe;
    });
  }

  /// Insert a [recipe] into the database
  /// Returns the id of the inserted row.
  static Future<int> insertRecipe(Recipe recipe) async {
    final db = await DBHelper.database();
    return db.insert('${DBTables.recipes}', recipe.toMap(),
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  /// Update a [recipe] in the database
  /// Returns the number of rows affected by the update operation.
  static Future<int> updateRecipe(Recipe recipe) async {
    final db = await DBHelper.database();
    return db.update('${DBTables.recipes}', recipe.toMap(),
        where: 'id = ?', whereArgs: [recipe.id]);
  }

  /// Delete a [recipe] from the database
  /// Returns the number of rows affected by the delete operation.
  static Future<int> deleteRecipe(Recipe recipe) async {
    final db = await DBHelper.database();
    return db
        .delete('${DBTables.recipes}', where: 'id = ?', whereArgs: [recipe.id]);
  }

  /// Delete the database file
  static Future<void> deleteDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    sql.deleteDatabase(path.join(dbPath, 'cookBook.db'));
    if (kDebugMode) {
      print('Database deleted');
    }
  }

  /// Delete all the recipes from the database
  static Future<void> deleteAllRecipes() async {
    final db = await DBHelper.database();
    db.delete('${DBTables.recipes}');
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokeapp/ben10.dart';
import 'package:pokeapp/ben10detail.dart';

void main() => runApp(MaterialApp(
  title: "Ben 10 App",
  home: HomePage(),
  debugShowCheckedModeBanner: false,
));
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var url = "https://raw.githubusercontent.com/karthikvpgowda/Ben10/main/ben10_1.json?token=ALPQXJXZDGESDWBWFAPSHYDASBAMS";
  PokeHub pokeHub;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }
  fetchData() async{
    var res = await http.get(url);
    var decodedJson = jsonDecode(res.body);
    pokeHub = PokeHub.fromJson(decodedJson);
    print(pokeHub.toJson());
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Aliens List"),
      ),
      body: pokeHub == null?Center(
        child: CircularProgressIndicator(),
      )
          : GridView.count(crossAxisCount: 2,
      children: pokeHub.pokemon.map((poke) => Padding(
          padding: const EdgeInsets.all(2.0),
          child: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => PokeDetail(pokemon: poke,)));
            },
            child: Hero(
              tag: poke.img,
              child: Card(
                elevation: 3.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      height: 100.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage(poke.img))
                      ),
                    ),
                    Text(poke.name, style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          ),
      )).toList(),
    ),
      drawer: Drawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.cyan,
        child: Icon(Icons.refresh),
      ),
    );
  }
}

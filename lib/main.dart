import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'dart:async';
import 'dart:convert';

const request = "https://api.hgbrasil.com/finance?key=36bf5c09";

Future<Map> getData() async{
  http.Response response = await http.get(request);
  return json.decode(response.body);
} 

void main(List<String> args) async {
  runApp(
    MaterialApp(
      home: Home(), 
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)
          )
        )
      )
    )
  );
}
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  
  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();

  double dolar;
  double euro;

  void _realChanged(String text){

  }

  void _dolarChanged(String text){
    
  }

  void _euroChanged(String text){
    
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('\$ Conversor \$'),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text('Carregando dados...',
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 25.0
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text('Erro ao carregar dados :(',
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 25.0
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              }else{
                dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];

                return SingleChildScrollView(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Icon(Icons.monetization_on, size: 150.0, color: Colors.amber),
                      buildTextFild('Reais', 'R\$ ', realController, _realChanged),
                      Divider(),
                      buildTextFild('Dolares', 'US\$ ', dolarController, _dolarChanged),
                      Divider(),
                      buildTextFild('Euros', '€ ', euroController, _euroChanged),
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }
}

buildTextFild(String label, String prefix, TextEditingController controllerInput, Function f){
  return TextField(
    controller: controllerInput,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.amber),
      border: OutlineInputBorder(),
      prefixText: prefix,
    ),
    style: TextStyle(
      color: Colors.amber, fontSize: 25,
    ),
    onChanged: f,
    keyboardType: TextInputType.number,
  );
}
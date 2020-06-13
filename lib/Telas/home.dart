import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:fluttertreinaweb/Telas/cliente.dart';
import 'package:fluttertreinaweb/Telas/lista_vendas.dart';
import 'package:fluttertreinaweb/Telas/login.dart';
import 'package:fluttertreinaweb/Telas/produto.dart';
import 'package:fluttertreinaweb/Telas/venda.dart';
import 'package:fluttertreinaweb/Telas/vendedor.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


const RoxoBonito = const Color(0xFF7953D2);


//Classe da home
class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
  
}

class _HomeState extends State<Home> {
  var gestorHome = false;

  final GlobalKey<AnimatedCircularChartState> _chartKey = new GlobalKey<AnimatedCircularChartState>();

  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();

  Future<bool> _getBool() async {
    final prefs = await SharedPreferences.getInstance();
    final gestorLog = prefs.getBool("loginGestor");
    if (gestorLog == true) {
      gestorHome = true;
    }
    if (gestorLog == false) {
      gestorHome = false;
    }
  }

  Future<void> _resetBool() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('loginGestor', false);
    gestorHome = false;
  }

  var estojo;
  var caneta;
  var lapis;
  double estojoChart;
  double canetaChart;
  double lapisChart;

  Future <String> getData() async {
    var response = await http.get(
      Uri.encodeFull("https://vendasprojeto.herokuapp.com/vendas?produto=Estojo"),
    headers: {
      "Accept": "application/json" 
    } 
    );
    print(response.body);
    estojo = response.body;
    estojoChart = double.parse(estojo);
   
  }

 Future <String> getData2() async {
    var response = await http.get(
      Uri.encodeFull("https://vendasprojeto.herokuapp.com/vendas?produto=caneta"),
    headers: {
      "Accept": "application/json" 
    } 
    );
    print(response.body);
    caneta = response.body;
    canetaChart = double.parse(caneta);
  }

   Future <String> getData3() async {
    var response = await http.get(
      Uri.encodeFull("https://vendasprojeto.herokuapp.com/vendas?produto=lapis"),
    headers: {
      "Accept": "application/json" 
    } 
    );
    print(response.body);
    lapis = response.body;
    lapisChart = double.parse(lapis);
  }


  var data = [0.0, 1.0, 1.5, 2.0, 0.0, 0.0, -0.5, -1.0, -0.5, 0.0, 0.0];
  var data1 = [0.0, -2.0, 3.5, -2.0, 0.5, 0.7, 0.8, 1.0, 2.0, 3.0, 3.2];

 List<CircularStackEntry> dataChart = <CircularStackEntry>[
  new CircularStackEntry(
    <CircularSegmentEntry>[
      new CircularSegmentEntry(500.0, Colors.red, rankKey: 'Q1'),
      new CircularSegmentEntry(1000.0, Colors.green, rankKey: 'Q2'),
      new CircularSegmentEntry(2000.0, Colors.blue, rankKey: 'Q3'),
      new CircularSegmentEntry(1000.0, Colors.yellow, rankKey: 'Q4'),
    ],
    rankKey: 'Quarterly Profits',
  ),
];

  void _cycleSamples() {
  List<CircularStackEntry> nextData = <CircularStackEntry>[
    new CircularStackEntry(
      <CircularSegmentEntry>[
        new CircularSegmentEntry(estojoChart, Colors.red, rankKey: 'Q1'),
        new CircularSegmentEntry(canetaChart, Colors.green, rankKey: 'Q2'),
        new CircularSegmentEntry(lapisChart, Colors.blue, rankKey: 'Q3'),
        new CircularSegmentEntry(0, Colors.yellow, rankKey: 'Q4'),
      ],
      rankKey: 'Quarterly Profits',
    ),
  ];
  setState(() {
    _chartKey.currentState.updateData(nextData);
  });
}

  Material myTextItems(String title, String subtitle) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      borderRadius: BorderRadius.circular(24.0),
      shadowColor: Color(0x802196F3),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 30.0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Material myCircularItems(String title, String subtitle) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      borderRadius: BorderRadius.circular(24.0),
      shadowColor: Color(0x802196F3),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 30.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: AnimatedCircularChart(
                      key: _chartKey,
                      size: const Size(100.0, 100.0),
                      initialChartData: dataChart ,
                      chartType: CircularChartType.Pie,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Material mychart1Items(String title, String priceVal, String subtitle) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      borderRadius: BorderRadius.circular(24.0),
      shadowColor: Color(0x802196F3),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Text(
                      priceVal,
                      style: TextStyle(
                        fontSize: 30.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: new Sparkline(
                      data: data1,
                      lineColor: Color(0xffff6101),
                      pointsMode: PointsMode.all,
                      pointSize: 8.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _handleDrawer() {
    _key.currentState.openDrawer();

    setState(() {
      _getBool();
    });
  }

  @override
  void initState() {
    getData();
    getData2();
    getData3();
    Timer(Duration(seconds: 2), () => _cycleSamples());
    //; 
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawerEnableOpenDragGesture: true,
      appBar: AppBar(
        title: Text('Vendas - Dashboard'),
        leading: new IconButton(
          icon: new Icon(Icons.menu),
          onPressed: _handleDrawer,
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(FontAwesomeIcons.chartLine),
              onPressed: () {
                //nothing
              }),
        ],
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            Ink(
                color: RoxoBonito,
                height: 80.0,
                child: Padding(
                  padding: EdgeInsets.only(top: 12.0),
                  child: new ListTile(
                      title: new Text(
                    "MENU",
                    style: new TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                        fontSize: 30.0,
                        letterSpacing: 2.0),
                  )),
                )),
            new ListTile(
                title: Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: new Text(
                    "CADASTRAR VENDA",
                    style: new TextStyle(
                      color: Colors.grey,
                      fontFamily: 'OpenSans',
                      fontSize: 15.0,
                      letterSpacing: 2.0,
                    ),
                  ),
                ),
                onTap: () {
                  print('Cadastrar Venda Pressed');
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => VendaScreen()));
                },
                trailing: new Icon(Icons.add)),
            new Divider(),
            new ListTile(
                title: Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: new Text(
                    "CADASTRAR CLIENTE",
                    style: new TextStyle(
                      color: Colors.grey,
                      fontFamily: 'OpenSans',
                      fontSize: 15.0,
                      letterSpacing: 2.0,
                    ),
                  ),
                ),
                onTap: () {
                  print('Cadastrar Cliente Pressed');
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ClienteScreen()));
                },
                trailing: new Icon(Icons.person_add)),
            new Divider(),
            new ListTile(
                title: Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: new Text(
                    "CADASTRAR PRODUTO",
                    style: new TextStyle(
                      color: Colors.grey,
                      fontFamily: 'OpenSans',
                      fontSize: 15.0,
                      letterSpacing: 2.0,
                    ),
                  ),
                ),
                onTap: () {
                  print('Cadastrar Produto Pressed');
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProdutoScreen()));
                },
                trailing: new Icon(Icons.add_shopping_cart)),
            new Divider(),
            Visibility(
              child: new ListTile(
                  title: Padding(
                    padding: EdgeInsets.only(top: 5.0),
                    child: new Text(
                      "CADASTRAR VENDEDOR",
                      style: new TextStyle(
                        color: Colors.grey,
                        fontFamily: 'OpenSans',
                        fontSize: 15.0,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ),
                  onTap: () {
                    print('Cadastrar Vendedor Pressed');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VendedorScreen()));
                  },
                  trailing: new Icon(Icons.person_outline)),
              visible: gestorHome,
            ),
            Visibility(child: new Divider(), visible: gestorHome),
            new ListTile(
                title: Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: new Text(
                    "LISTA DE VENDAS",
                    style: new TextStyle(
                      color: Colors.grey,
                      fontFamily: 'OpenSans',
                      fontSize: 15.0,
                      letterSpacing: 2.0,
                    ),
                  ),
                ),
                onTap: () {
                  print('Lista de Vendas Pressed');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ListaVendaScreen()));
                },
                trailing: new Icon(Icons.view_list)),
            new Divider(),
            new ListTile(
                title: Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: new Text(
                    "SAIR",
                    style: new TextStyle(
                      color: Colors.grey,
                      fontFamily: 'OpenSans',
                      fontSize: 15.0,
                      letterSpacing: 2.0,
                    ),
                  ),
                ),
                onTap: () {
                  print('Logout Pressed');
                  _resetBool();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                trailing: new Icon(Icons.exit_to_app))
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10.0),
        color: Color(0xffE5E5E5),
        child: StaggeredGridView.count(
          crossAxisCount: 4,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  mychart1Items("Vendas por mês", "421.3M", "+12.9% of target"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: myCircularItems("Vendas", "produto")
                
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: myTextItems("Meta", "40.0M"),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: myTextItems("Vendas", "25.5M"),
            ),
          ],
          staggeredTiles: [
            StaggeredTile.extent(4, 300.0),
            StaggeredTile.extent(2, 270.0),
            StaggeredTile.extent(2, 130.0),
            StaggeredTile.extent(2, 130.0)
          ],
        ),
      ),
    );
  }
}

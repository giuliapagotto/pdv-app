import 'package:flutter/material.dart';
import 'package:fluttertreinaweb/Telas/cliente.dart';
import 'package:fluttertreinaweb/Telas/home.dart';
import 'package:fluttertreinaweb/Telas/login.dart';
import 'package:fluttertreinaweb/Telas/produto.dart';
import 'package:fluttertreinaweb/Telas/venda.dart';
import 'package:fluttertreinaweb/Telas/vendedor.dart';
import 'package:shared_preferences/shared_preferences.dart';

const RoxoBonito = const Color(0xFF7953D2);

class ListaVendaScreen extends StatefulWidget {
  @override
  _ListaVendaScreenState createState() => new _ListaVendaScreenState();
}

class _ListaVendaScreenState extends State<ListaVendaScreen> {

  var gestorHome = false;

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

 _handleDrawer() {
    _key.currentState.openDrawer();

    setState(() {
      _getBool();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       key: _key,
      appBar: AppBar(
        title: Text('Lista de vendas'),
        leading: new IconButton(
          icon: new Icon(Icons.menu),
          onPressed: _handleDrawer,
        ),
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
                  ),
                  ),
                )),
                new ListTile(
                title: Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: new Text(
                    "HOME",
                    style: new TextStyle(
                      color: Colors.grey,
                      fontFamily: 'OpenSans',
                      fontSize: 15.0,
                      letterSpacing: 2.0,
                    ),
                  ),
                ),
                onTap: () {
                  print('Home Pressed');
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Home()));
                },
                trailing: new Icon(Icons.home)),
                new Divider(),
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
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => VendaScreen()));
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
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => ClienteScreen()));
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProdutoScreen()));
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
                  print('Cadastrar Cliente Pressed');
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => ListaVendaScreen()));
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
                  _resetBool();
                  print('Logout Pressed');
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                trailing: new Icon(Icons.exit_to_app))
          ],
        ),
      ),
    );
  }
}
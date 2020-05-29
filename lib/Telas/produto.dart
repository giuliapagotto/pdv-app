import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertreinaweb/Telas/home.dart';
import 'package:fluttertreinaweb/Telas/lista_vendas.dart';
import 'package:fluttertreinaweb/Telas/login.dart';
import 'package:fluttertreinaweb/Telas/venda.dart';
import 'package:fluttertreinaweb/Telas/cliente.dart';
import 'package:fluttertreinaweb/Telas/vendedor.dart';

const RoxoBonito = const Color(0xFF7953D2);

class ProdutoScreen extends StatefulWidget {
  @override
  _ProdutoScreenState createState() => new _ProdutoScreenState();
}

class _ProdutoScreenState extends State<ProdutoScreen> {
  String _nome;
  String _descricao;
  String _preco;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildNome() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Nome do Produto'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Nome é obrigatório';
        }

        return null;
      },
      onSaved: (String value) {
        _nome = value;
      },
    );
  }

  Widget _buildDescricao() {
    return TextFormField(
      decoration: InputDecoration(hintText: "Descrição"),
      minLines: 2,
      maxLines: 5,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Descrição é obrigatório';
        }

        return null;
      },
      onSaved: (String value) {
        _descricao = value;
      },
      
    );
  }

  Widget _buildPreco() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Preço",
      prefixText: "R\$ ",
      ),
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Preço é obrigatório';
        }

        return null;
      },
      onSaved: (String value) {
        _preco = value;
      },
    );
  }


  Widget _buildSaveBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          if (!_formKey.currentState.validate()) {
            return;
          }
          _formKey.currentState.save();

          print(_nome);

          //Navigator.push(
          //    context, MaterialPageRoute(builder: (context) => Home()));
        },
        padding: EdgeInsets.all(15.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        color: Colors.white,
        child: Text('CADASTRAR',
            style: TextStyle(
                color: Color(0xFF527DAA),
                letterSpacing: 2.0,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans')),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cadastrar produto'),
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home()));
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ClienteScreen()));
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
              new ListTile(
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => VendedorScreen()));
                  },
                  trailing: new Icon(Icons.person_outline)),
              new Divider(), 
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  trailing: new Icon(Icons.exit_to_app))
            ],
          ),
        ),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: Stack(children: <Widget>[
              Container(
                  height: double.infinity,
                  margin: EdgeInsets.all(24),
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                         _buildNome(),
                         _buildDescricao(),
                         _buildPreco(),
                          SizedBox(height: 100.0),
                         _buildSaveBtn()
                        ],
                      ),
                    ),
                  ))
            ])));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertreinaweb/Telas/cliente.dart';
import 'package:fluttertreinaweb/Telas/home.dart';
import 'package:fluttertreinaweb/Telas/lista_vendas.dart';
import 'package:fluttertreinaweb/Telas/login.dart';
import 'package:fluttertreinaweb/Telas/produto.dart';
import 'package:fluttertreinaweb/Telas/venda.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

const RoxoBonito = const Color(0xFF7953D2);

class VendedorScreen extends StatefulWidget {
  @override
  _VendedorScreenState createState() => new _VendedorScreenState();
}

class _VendedorScreenState extends State<VendedorScreen> {
  String _nome;
  String _email;
  String _cpf;
  String _celular;
  String _login;
  String _senha;
  bool gestor = false;
  

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var maskFormatterCPF = new MaskTextInputFormatter(mask: '###.###.###-##', filter: { "#": RegExp(r'[0-9]') });
  var maskFormatterCelular = new MaskTextInputFormatter(mask: '(##) #####-####', filter: { "#": RegExp(r'[0-9]') });

  Widget _buildNome() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Nome'),
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

  Widget _buildEmail() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'E-mail'),
      keyboardType: TextInputType.emailAddress,
      validator: (String value) {
        if (value.isEmpty) {
          return 'E-mail é obrigatório';
        }
        if (!RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
          return 'Insira um e-mail válido';
        }

        return null;
      },
      onSaved: (String value) {
        _email = value;
      },
    );
  }

  Widget _buildCpf() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'CPF'),
      inputFormatters: [maskFormatterCPF],
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty) {
          return 'CPF é obrigatório';
        }

        return null;
      },
      onSaved: (String value) {
        _cpf = value;
      },
    );
  }

  Widget _buildCelular() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Celular'),
      inputFormatters: [maskFormatterCelular],
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Celular é obrigatório';
        }

        return null;
      },
      onSaved: (String value) {
        _celular = value;
      },
    );
  }

  Widget _buildLogin() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Login'),
      keyboardType: TextInputType.text,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Login é obrigatório';
        }

        return null;
      },
      onSaved: (String value) {
        _login = value;
      },
    );
  }

   Widget _buildSenha() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Senha'),
      obscureText: true,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Senha é obrigatório';
        }

        return null;
      },
      onSaved: (String value) {
        _senha = value;
      },
    );
  }

  Widget _buildGestorCheckBox() {
    return Container(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: RoxoBonito),
            child: Checkbox(
              value: gestor,
              checkColor: Colors.white,
              activeColor: RoxoBonito,
              onChanged: (value) {
                setState(() {
                  gestor = value;
                });
              },
            ),
          ),
          Text(
            'Gestor',
            style: TextStyle(
              color: Colors.black54
            ),
          )
        ],
      ),
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

          print(maskFormatterCPF.getUnmaskedText());

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
          title: Text('Cadastrar vendedor'),
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
                          _buildCpf(),
                          _buildEmail(),
                          _buildCelular(),
                          _buildLogin(),
                          _buildSenha(),
                          SizedBox(height: 20.0),
                          _buildGestorCheckBox(),
                          SizedBox(height: 60.0),
                          _buildSaveBtn()
                        ],
                      ),
                    ),
                  ))
            ])));
  }
}

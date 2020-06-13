import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fluttertreinaweb/Telas/home.dart';
import 'package:fluttertreinaweb/Telas/lista_vendas.dart';
import 'package:fluttertreinaweb/Telas/login.dart';
import 'package:fluttertreinaweb/Telas/produto.dart';
import 'package:fluttertreinaweb/Telas/venda.dart';
import 'package:fluttertreinaweb/Telas/vendedor.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:date_format/date_format.dart'; 
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const RoxoBonito = const Color(0xFF7953D2);

class ClienteScreen extends StatefulWidget {
  @override
  _ClienteScreenState createState() => new _ClienteScreenState();
}

class _ClienteScreenState extends State<ClienteScreen> {
  String _nome;
  String _email;
  String _cpf;
  String _celular;
  String _endereco;
  int group = 1;
  DateTime _dataNascimento;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

  _cadastarCliente() async {
    // set up POST request arguments
    String url = 'https://vendasprojeto.herokuapp.com/clientes';
    Map<String, String> headers = {"Content-type": "application/json"};
    String json = '{"nome": "${_nome}", "dataNascimento": "${_dataNascimento}", "cpf": "${maskFormatterCPF.getUnmaskedText()}", "email": "${_email}", "celular": "${maskFormatterCelular.getUnmaskedText()}", "endereco": "${_endereco}"}';
    // make POST request
    http.Response response = await http.post(url, headers: headers, body: json);
    // check the status code for the result
    int statusCode = response.statusCode;
    // this API passes back the id of the new item added to the body
    String responseBody = response.body;
    //home navigation
    if (statusCode == 200) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
      Fluttertoast.showToast(
              msg: "Cliente cadastrado",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
    }
    //erro
    if (statusCode == 401) {
       Fluttertoast.showToast(
              msg: "Este e-mail já está em uso",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
    }
    if (statusCode == 400) {
       Fluttertoast.showToast(
              msg: "Este CPF já está em uso",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
    }
  }

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

  Widget _buildData() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Data de Nascimento'),
      onTap: () {
        print("teste");
        showDatePicker(
                context: context,
                initialDate: _dataNascimento == null ? DateTime.now() : _dataNascimento,
                firstDate: DateTime(1920),
                lastDate: DateTime(2021))
            .then((date) { 
          setState(() {
            _dataNascimento = date;
           print(_dataNascimento);
          });
        });
      },
        controller: TextEditingController(text: (_dataNascimento == null ? '' : formatDate(_dataNascimento, [dd, '/', mm, '/', yyyy]))),
    );
  }

  Widget _buildCelular() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Celular'),
      inputFormatters: [maskFormatterCelular],
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Número de celular é obrigatório';
        }

        return null;
      },
      onSaved: (String value) {
        _celular = value;
      },
    );
  }

  Widget _buildEndereco() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Endereço'),
      keyboardType: TextInputType.text,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Endereço é obrigatório';
        }

        return null;
      },
      onSaved: (String value) {
        _endereco = value;
      },
    );
  }

 /* Widget _buildSexoRadio() {
    return Container(
        padding: EdgeInsets.all(15.0),
        child: Row(
          children: <Widget>[
            Radio(
              value: 1,
              activeColor: RoxoBonito,
              groupValue: group,
              onChanged: (T) {
                print(T);

                setState(() {
                  group = T;
                });
              },
            ),
            Text("Feminino",
                style: TextStyle(
                    color: Color(0xFF527DAA),
                    letterSpacing: 2.0,
                    fontSize: 14.0)),
            Radio(
              value: 2,
              activeColor: RoxoBonito,
              groupValue: group,
              onChanged: (T) {
                print(T);

                setState(() {
                  group = T;
                });
              },
            ),
            Text("Masculino",
                style: TextStyle(
                    color: Color(0xFF527DAA),
                    letterSpacing: 2.0,
                    fontSize: 14.0))
          ],
        ));
  }*/

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
          _cadastarCliente();
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
          title: Text('Cadastrar cliente'),
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
                    _resetBool();
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
                          _buildData(),
                          _buildCpf(),
                          _buildEmail(),
                          _buildCelular(),
                          _buildEndereco(),
                          SizedBox(height: 100.0),
                          _buildSaveBtn()
                        ],
                      ),
                    ),
                  ))
            ])));
  }
}

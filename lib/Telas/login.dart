import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertreinaweb/Telas/home.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

final kHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Colors.white,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Color(0xFF4527A0),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

//Classe da página de login
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String login;
  String senha;
  bool emptyL = false;
  bool emptyS = false;
  String msgToast = '';
  bool _rememberMe = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //get 
  Future<bool> _getBool() async {
    final prefs = await SharedPreferences.getInstance();
    final gestorLog = prefs.getBool("loginGestor");
    if(gestorLog == null){
      return false;
    }
    return gestorLog;
  }

  //reset to false
  Future<void> _resetBool() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('loginGestor', false);
  }


//LOGIN
  _loginRequest() async {
    // set up POST request arguments
    String url = 'https://vendasprojeto.herokuapp.com/authenticate';
    Map<String, String> headers = {"Content-type": "application/json"};
    String json = '{"login": "${login}","senha": "${senha}"}';
    // make POST request
    http.Response response = await http.post(url, headers: headers, body: json);
    // check the status code for the result
    int statusCode = response.statusCode;
    // this API passes back the id of the new item added to the body
    String responseBody = response.body;
    Map<String, dynamic> usuario = jsonDecode(responseBody);
    //home navigation
    if (statusCode == 200) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
      var gestor = usuario['user']['gestor'];
      if (gestor == true) {
        //set instance true
        Future<bool> _setBool() async {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool("loginGestor", gestor);
          print(prefs.getBool('loginGestor'));
        }
        _setBool();
      }
    }
    //LOGIN OU SENHA INVALIDOS
    if (statusCode == 400) {
      Fluttertoast.showToast(
          msg: "Login e/ou senha inválidos",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Login',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.white, fontFamily: 'OpenSans'),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Login',
              hintStyle: kHintTextStyle,
            ),
            validator: (String value) {
              if (value.isEmpty) {
                setState(() {
                  emptyL = true;
                });
              }
              return null;
            },
            onSaved: (String value) {
              login = value;
            },
          ),
        )
      ],
    );
  }

  Widget _buildSenhaTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Senha',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            obscureText: true,
            style: TextStyle(color: Colors.white, fontFamily: 'OpenSans'),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Senha',
              hintStyle: kHintTextStyle,
            ),
            validator: (String value) {
              if (value.isEmpty) {
                emptyS = true;
              }
              return null;
            },
            onSaved: (String value) {
              senha = value;
            },
          ),
        )
      ],
    );
  }

  Widget _buildEsqueceuSenhaBtn() {
    return Container(
      padding: EdgeInsets.only(bottom: 30.0),
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Esqueceu sua senha?',
          style: kLabelStyle,
        ),
      ),
    );
  }

  Widget _buildLembrarAcessoCheckBox() {
    return Container(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value;
                });
              },
            ),
          ),
          Text(
            'Lembrar meu acesso',
            style: kLabelStyle,
          )
        ],
      ),
    );
  }

  Widget _buildLoginBtn() {
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
          _loginRequest();
          if (emptyL == true && emptyS == false) {
            msgToast = 'Informe o login';
          }
          if (emptyL == false && emptyS == true) {
            msgToast = 'Informe sua senha';
          }
          if (emptyL == true && emptyS == true) {
            msgToast = 'Informe Login e Senha';
          }
          if (msgToast != '') {
            Fluttertoast.showToast(
                msg: msgToast,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
          emptyL = false;
          emptyS = false;
          msgToast = '';
        },
        padding: EdgeInsets.all(15.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        color: Colors.white,
        child: Text('LOGIN',
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
        body: AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF7953D2),
                Color(0xFF4527A0),
              ],
              stops: [0.6, 1],
            )),
          ),
          Container(
              height: double.infinity,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding:
                    EdgeInsets.symmetric(horizontal: 40.0, vertical: 120.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 30.0),
                      _buildEmailTF(),
                      SizedBox(height: 30.0),
                      _buildSenhaTF(),
                      _buildEsqueceuSenhaBtn(),
                      _buildLembrarAcessoCheckBox(),
                      _buildLoginBtn()
                    ],
                  ),
                ),
              ))
        ],
      ),
    ));
  }
}

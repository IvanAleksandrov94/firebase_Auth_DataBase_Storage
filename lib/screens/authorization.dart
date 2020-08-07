import 'package:firestore/models/user.dart';
import 'package:firestore/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class AuthorizationPage extends StatefulWidget {
  @override
  _AuthorizationPageState createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  String _email;
  String _pass;

  AuthService _authService = AuthService();

  void onClickLogin() async {
    _email = _emailController.text;
    _pass = _passController.text;

    if (_email.isEmpty || _pass.isEmpty)
      return Toast.show("Введите данные", context);

    User user = await _authService.signInWithEmailAndPassword(
        _email.trim(), _pass.trim());
    if (user == null) {
      Toast.show("error", context);
    } else {
      _emailController.clear();
      _passController.clear();
    }
  }

  void onClickRegister() async {
    _email = _emailController.text;
    _pass = _passController.text;

    if (_email.isEmpty || _pass.isEmpty)
      return Toast.show("Введите данные", context);

    User user = await _authService.registerInWithEmailAndPassword(
        _email.trim(), _pass.trim());
    if (user == null) {
      Toast.show("error", context);
    } else {
      _emailController.clear();
      _passController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("auth"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 50),
              child: Text("Регистрация/Вход"),
            ),
            TextFormField(
              controller: _emailController,
              autofocus: true,
              textDirection: TextDirection.ltr,
              decoration: const InputDecoration(labelText: "Введите Email"),
            ),
            TextFormField(
              controller: _passController,
              autofocus: false,
              decoration: const InputDecoration(labelText: "Введите пароль"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: RaisedButton(
                    onPressed: () => onClickLogin(),
                    child: Text("Войти"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: RaisedButton(
                    onPressed: () => onClickRegister(),
                    child: Text("Регистрация"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

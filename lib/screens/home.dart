import 'package:firestore/services/auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("listview"),
          actions: <Widget>[
            Container(
              child: IconButton(
                  icon: Icon(Icons.exit_to_app),
                  onPressed: () => AuthService().logOut()),
            )
          ],
        ),
        body: ListView(
          controller: _scrollController,
          children: <Widget>[
            RaisedButton(
              onPressed: () => {},
            ),
            RaisedButton(
              onPressed: () => {},
            )
          ],
        ));
  }
}

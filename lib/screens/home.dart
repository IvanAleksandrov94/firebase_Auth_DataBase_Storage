import 'package:firestore/models/items.dart';
import 'package:firestore/services/auth.dart';
import 'package:firestore/services/database.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _scrollController = ScrollController();
  Item item = Item("2", "Ivan", "Aleksandrov", 26);

  List<Item> getItem = List<Item>();
  DataBaseService db = DataBaseService();
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    Stream stream = db.getItems();
    stream.listen((data) {
      setState(() {
        getItem = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("listview"),
          actions: <Widget>[
            Container(
              child: IconButton(
                icon: Icon(Icons.add),
                onPressed: () => db.addOrUpdateDB(item),
              ),
            ),
            Container(
              child: IconButton(
                  icon: Icon(Icons.exit_to_app),
                  onPressed: () => AuthService().logOut()),
            )
          ],
        ),
        body: ListView.builder(
          controller: _scrollController,
          itemCount: getItem.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(getItem[index].name),
              subtitle: Text(getItem[index].soName),
              leading: Text((index + 1).toString()),
              trailing: Text("id: ${getItem[index].id}"),
            );
          },
        ));
  }
}

import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firestore/models/cloud_storage_resoult.dart';
import 'package:firestore/models/items.dart';
import 'package:firestore/services/auth.dart';
import 'package:firestore/services/database.dart';
import 'package:firestore/services/storage.dart';
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
  String downloadUrl;
  bool isComplited = false;

  @override
  void initState() {
    super.initState();
    CloudStorageService().getImageUrl().then((CloudStorageResoult res) {
      downloadUrl = res.imageUrl;
      CloudStorageService()
          .getImageUrl()
          .whenComplete(() => isComplited = true);
    });

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
              leading: Container(
                child: CachedNetworkImage(
                  imageUrl: downloadUrl,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              trailing: Text("id: ${getItem[index].id}"),
              onTap: () => {
                //
              },
            );
          },
        ));
  }
}

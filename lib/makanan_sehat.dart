import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './makanan_add.dart';
import 'makanan_detail.dart';

class MakananList extends StatefulWidget {
  @override
  _MakananListState createState() => _MakananListState();
}

class _MakananListState extends State<MakananList> {
  Future<List> getData() async {
    final response = await http
        .get(Uri.parse("http://10.0.2.2/healthify/makanan_getdata.php"));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: new AppBar(
        backgroundColor: Color(0xff1DBAB5),
        title: Text("Makanan Sehat"),
      ),
      floatingActionButton: new FloatingActionButton(
          backgroundColor: Color(0xff1DBAB5),
          child: new Icon(Icons.add),
          onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MakananAdd()),
              ).then((value) => setState(() {
                    getData();
                  }))),
      body: new FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? new ItemList(list: snapshot.data)
              : new Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ItemList extends StatefulWidget {
  final List list;
  ItemList({this.list});

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: widget.list == null ? 0 : widget.list.length,
      itemBuilder: (context, i) {
        return new Container(
          padding: EdgeInsets.only(top: 3, bottom: 3, left: 12, right: 12),
          child: new GestureDetector(
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) =>
                    new MakananDetail(list: widget.list, index: i))),
            child: new Card(
              child: Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: new ListTile(
                  title: new Text(
                    widget.list[i]['nama_makanan'],
                    style: TextStyle(
                        color: Color(0xff1DBAB5),
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  leading: new Icon(Icons.local_dining),
                  subtitle: Container(
                      padding: EdgeInsets.only(top: 15),
                      child: new Text("${widget.list[i]['keterangan']} ")),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

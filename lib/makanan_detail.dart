import 'package:flutter/material.dart';
import 'package:healthify/makanan_edit.dart';
import 'package:http/http.dart' as http;
import 'main.dart';
import './makanan_edit.dart';
import './tentang_kami.dart';

class MakananDetail extends StatefulWidget {
  List list;
  int index;
  MakananDetail({this.list, this.index});

  @override
  _MakananDetailState createState() => _MakananDetailState();
}

class _MakananDetailState extends State<MakananDetail> {
  void deleteData() {
    http.post(Uri.parse("http://10.0.2.2/healthify/makanan_deletedata.php"),
        body: {"id": widget.list[widget.index]['id']});
  }

  void confirmPopUp() {
    AlertDialog alertDialog = new AlertDialog(
      content: new Text(
          "Yakin mau hapus data '${widget.list[widget.index]['nama_makanan']}' ?"),
      actions: [
        new RaisedButton(
          child: new Text("IYA, HAPUS"),
          onPressed: () {
            deleteData();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MyApp(),
              ),
            );
            ;
          },
        ),
        new RaisedButton(
          child: new Text("BATAL"),
          onPressed: () => Navigator.of(context).pop(),
        )
      ],
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: new AppBar(
          backgroundColor: Color(0xff1DBAB5),
          title: new Text("${widget.list[widget.index]['nama_makanan']}"),
        ),
        body: new Container(
          padding: EdgeInsets.all(15),
          child: new Center(
            child: new Column(
              children: [
                SizedBox(height: 30),
                new Container(
                  width: 1300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.all(20),
                  child: new Text(
                      "Nama Makanan : ${widget.list[widget.index]['nama_makanan']}"),
                ),
                SizedBox(height: 10),
                new Container(
                  width: 1300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.all(20),
                  child: new Text(
                      "Keterangan : ${widget.list[widget.index]['keterangan']}"),
                ),
                new Padding(padding: EdgeInsets.only(top: 30)),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 80),
                    new RaisedButton(
                      child: new Text("EDIT"),
                      onPressed: () => Navigator.of(context).push(
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new MakananEdit(
                                      list: widget.list, index: widget.index))),
                    ),
                    SizedBox(width: 10),
                    new RaisedButton(
                      child: new Text("DELETE"),
                      onPressed: () => confirmPopUp(),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}

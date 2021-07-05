import 'package:flutter/material.dart';
import './editdata.dart';
import 'package:http/http.dart' as http;
import './main.dart';

class Detail extends StatefulWidget {
  List list;
  int index;
  Detail({this.list, this.index});

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  void deleteData() {
    http.post(Uri.parse("http://10.0.2.2/healthify/deletedata.php"),
        body: {"id": widget.list[widget.index]['id']});
  }

  void confirmPopUp() {
    AlertDialog alertDialog = new AlertDialog(
      content: new Text(
          "Yakin mau hapus data '${widget.list[widget.index]['item_name']}'"),
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
        appBar: new AppBar(
          title: new Text("${widget.list[widget.index]['item_name']}"),
        ),
        body: new Container(
          padding: EdgeInsets.all(5),
          child: new Card(
            child: new Center(
              child: new Column(
                children: [
                  new Text(widget.list[widget.index]['item_name']),
                  new Text("Code : ${widget.list[widget.index]['item_code']}"),
                  new Text("Price : ${widget.list[widget.index]['price']}"),
                  new Text("Stock : ${widget.list[widget.index]['stock']}"),
                  new Padding(padding: EdgeInsets.only(top: 30)),
                  new Row(
                    children: [
                      new RaisedButton(
                        child: new Text("EDIT"),
                        onPressed: () => Navigator.of(context).push(
                            new MaterialPageRoute(
                                builder: (BuildContext context) => new EditData(
                                    list: widget.list, index: widget.index))),
                      ),
                      new RaisedButton(
                        child: new Text("DELETE"),
                        onPressed: () => confirmPopUp(),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

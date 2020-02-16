import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class ThoughtList extends StatefulWidget {
  @override
  _ThoughtListState createState() => _ThoughtListState();
}

class _ThoughtListState extends State<ThoughtList> {
  Map data;
  List quoteData;

  Future getData() async {
    http.Response response = await http.get("https://memeapi26.herokuapp.com/givetext/showerthoughts/40");
    data = json.decode(response.body);
    setState(() {
      quoteData = data["sub"];
    });
   
  }

  _copyData(int index){
    Clipboard.setData(ClipboardData(text: "${quoteData[index]["Title"]}"));
    
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: quoteData == null ? 0 : quoteData.length,
        itemBuilder: (BuildContext context, int index ){
          return Padding(
            padding: const EdgeInsets.only(left: 4, top: 4, right: 4),
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 5.0, right: 10),
                    child: FlatButton.icon(
                      onPressed: (){
                        _copyData(index);
                        Fluttertoast.showToast(
                        msg: "Thought Copied..",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        fontSize: 16.0,
                       );
                      },
                      icon: Icon(Icons.chat_bubble_outline), 
                      label: Text("ShowerThoughts", style: TextStyle(fontSize: 15.0),),
                    
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, bottom: 10,right: 10),
                    child: Text(
                      "\t${quoteData[index]["Title"]}",
                      style: TextStyle(
                        fontSize: 19,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  
                ],
              ),
            ),
          );
        } 
      ),
      
    );
  }
}
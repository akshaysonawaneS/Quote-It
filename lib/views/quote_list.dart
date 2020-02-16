import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class QuoteList extends StatefulWidget {
  @override
  _QuoteListState createState() => _QuoteListState();
}

class _QuoteListState extends State<QuoteList> {
  
  Map data;
  List quoteData;

  Future<List> _getData() async {
    http.Response response = await http.get("https://memeapi26.herokuapp.com/givetext/quotes/40");
    data = json.decode(response.body);
//setState(() {
      quoteData = data["sub"];
  
   // });
    return quoteData;
    
    }

  _copyData(int index){
    Clipboard.setData(ClipboardData(text: "${quoteData[index]["Title"]}"));
  }

  // @override
  // void initState() {
  //   super.initState();
  //   getData();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: _getData(),
        builder: (BuildContext context, AsyncSnapshot snapshot){

          if (snapshot.data == null ) {
            return Center(
                    child: Text(
                      "Wow, Such empty...Loading",
                      style: TextStyle(
                        fontSize: 22.0,
                        color: Colors.grey,
                      ),
                    ),
                  );
          } 
          else {
          
          return ListView.builder(  
                  itemCount: snapshot.data.length,
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
                                icon: Icon(Icons.bookmark_border), 
                                label: Text("Quote:", style: TextStyle(fontSize: 15.0),),
                              
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
            );
          }
        }
      )
      
    );
  }
}

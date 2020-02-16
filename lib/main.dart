
import 'package:QuoteIt/views/quote_list.dart';
import 'package:QuoteIt/views/thought_list.dart';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePage();
  }
}



class HomePage extends State<MyApp>{
  int _currentIndex = 0;
  bool dark = false;
  
  Widget callPage(int currentIndex){
      switch(currentIndex){
        case 0:return QuoteList();
        case 1:return ThoughtList();

        default:return QuoteList();
      }

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Quote",
        theme: ThemeData(
          brightness: dark ? Brightness.dark  : Brightness.light,
          primaryColor: dark ? Colors.grey[900] : Colors.blue,
          accentColor: dark ? Colors.grey[50] : Colors.blue
        ),
        home: Scaffold(
      appBar: AppBar(
        title: Text("Quote IT"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh), 
            onPressed: (){}
            
          ),
        ],
      ),
      body: callPage(_currentIndex),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.brightness_2),
        onPressed: (){
          if(dark == false){
            dark = true;
          }
          else{
            dark = false;
          }
          setState(() {
          });
        }

      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value){
          _currentIndex = value;
          setState(() {
            
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            title: Text("Quotes"),
            backgroundColor: Colors.blue
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            title: Text("ShowerThoughts"),
            backgroundColor: Colors.blue
          )
        ],
      ),
    ),
    );
  }

  
}
import 'package:flutter/material.dart';


void main(){
  runApp(MyApp());

}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var grid=[
    '-',
    '-',
    '-',
    '-',
    '-',
    '-',
    '-',
    '-',
    '-',
  ];
  var winner ="";
  var currentplayer='x';
  void drawxo(i){
    if(grid[i]=='-'){
      setState(() {
        grid[i]=currentplayer;
        currentplayer = currentplayer=='X'? '0':'X';
      });
      findWinner(grid[i]);//for current player value
    }

  }
  bool checkMove(i1,i2,i3,sign){
    if(grid[i1] == sign && grid[i2] == sign && grid[i3]== sign){
      return true;
    }
    return false;
  }
  void findWinner(currentsign){
    if(
    checkMove(0,1,2,currentsign) || checkMove(3,4,5,currentsign) || checkMove(6,7,8, currentsign) ||//for rows
        checkMove(0,3,6,currentsign) || checkMove(1,4,7,currentsign) || checkMove(2,5,8,currentsign)  ||//for columns
        checkMove(0,4,8,currentsign) || checkMove(2,4,6,currentsign)//for diagonal
    ){
      setState(() {
        winner = currentsign;
      });

    }
  }
  void reset(){
    setState(() {
      winner ="";
      grid=[
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
      ];
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tic Tac Toe',
      theme: ThemeData(primarySwatch: Colors.blue),
      home:Scaffold(
        appBar: AppBar(
          title:Text('Tic Tac Toe'),
        ),
        body: Center(
          child: Column(
            children: [
              if (winner != "")Text('$winner won the game',style: TextStyle(fontSize: 30),),
              Container(
                constraints: BoxConstraints(maxHeight: 400,maxWidth: 400),
                margin: EdgeInsets.all(20),
                color: Colors.black87,
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10
                  ),
                  itemCount: grid.length,
                  itemBuilder: (context,index)=> Material(
                    color:Colors.tealAccent,
                    child: InkWell(
                        splashColor: Colors.blue,
                        onTap: ()=>drawxo(index),
                        child: Center(
                            child: Text(
                              grid[index],
                              style:TextStyle(
                                  fontSize: 50),
                            )
                        )
                    ),
                  ),
                ),
              ),
              ElevatedButton.icon(onPressed: reset, icon:Icon(Icons.refresh) ,label:Text('Reset'))
            ],
          ),
        ),
      ),
    );
  }
}

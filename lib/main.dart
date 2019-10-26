import 'scoreview.dart';
import 'login.dart';
import 'package:flutter/material.dart';
import 'upload_photo.dart';

void main() {
  runApp(MaterialApp(
    title: 'Navigation Basics',
    home: FirstRoute(),
  ));
}

class FirstRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String msg = "555";
    return Scaffold(
      appBar: AppBar(
        title: Text('Indoor and Outdoor Location'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                msg,
                style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
              ),
              RaisedButton(
                child: Text('score'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => scoreview()),
                  );
                },
              ),

              RaisedButton(
                child: Text('login'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => login()),
                  );
                },
              ),
              RaisedButton(
                child: Text('upload_photo'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => upload_photo()),
                  );
                },
              ),


            ],
          ),
        ),
      ),
    );

  }


}
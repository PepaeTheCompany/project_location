import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'home_patient.dart';
class account_patient extends StatefulWidget {
  FirebaseDatabase database = new FirebaseDatabase();
  final FirebaseUser user;
  account_patient(this.user, {Key key}) : super(key: key);

  @override
  _MySignUpPageState createState() => _MySignUpPageState();
}

class _MySignUpPageState extends State<account_patient> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController surenameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController nicknameController = new TextEditingController();
  TextEditingController hnController = new TextEditingController();
  TextEditingController detailController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController countryController = new TextEditingController();
  TextEditingController postController = new TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  var mylist = List.generate(10, (i)=>"Flutter $i");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("แก้ไขข้อมูลผู้ป่วย", style: TextStyle(color: Colors.white)),

        ),
        body: Container(
            color: Colors.green[50],
            child: Center(

              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                          colors: [Colors.yellow[100], Colors.green[100]])),
                  margin: EdgeInsets.all(32),
                  padding: EdgeInsets.all(24),
                  child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          buildTextFieldname(),
                           buildTextFieldsurename(),
                             buildTextFieldphone(),
                            buildTextFieldnickname(),
                                buildTextFieldhn(),
                               buildTextFielddetail(),
                       buildTextFieldaddress(),
                     buildTextFieldcountry(),
                   buildTextFieldpost(),
                          buildButtoncommit(context),






                        ],
                      )
                  )
              ),

            )));
  }

  Container buildButtoncommit(BuildContext context) {
    return Container(
        constraints: BoxConstraints.expand(height: 65),
        child: RaisedButton(
            color: Colors.green[200],

            child: Text('บันทึกการเปลี่ยนแปลง',

                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.white)),
            shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(14.0)),
            onPressed: () async {
update();

            }
        ) , padding: EdgeInsets.all(12));
  }

  Container buildTextFieldname() {
    return Container(

        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.yellow[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            decoration: InputDecoration.collapsed(hintText: "ชื่อ"),
            controller: nameController,
            keyboardType: TextInputType.text,
            style: TextStyle(fontSize: 18)));
  }
  Container buildTextFieldsurename() {
    return Container(
        margin: EdgeInsets.only(top: 5),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.yellow[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            decoration: InputDecoration.collapsed(hintText: "นามสกุล"),
            controller: surenameController,
            keyboardType: TextInputType.text,
            style: TextStyle(fontSize: 18)));
  }

  Container buildTextFieldphone() {
    return Container(
        margin: EdgeInsets.only(top: 5),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.yellow[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            decoration: InputDecoration.collapsed(hintText: "เบอร์โทร"),
            controller: phoneController,
            keyboardType: TextInputType.phone,
            style: TextStyle(fontSize: 18)));
  }

  Container buildTextFieldnickname() {
    return Container(
        margin: EdgeInsets.only(top: 5),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.yellow[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            decoration: InputDecoration.collapsed(hintText: "ชื่อเล่น"),
            controller: nicknameController,
            keyboardType: TextInputType.text,
            style: TextStyle(fontSize: 18)));
  }

  Container buildTextFieldhn() {
    return Container(
        margin: EdgeInsets.only(top: 5),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.yellow[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            decoration: InputDecoration.collapsed(hintText: "HN Number"),
            controller: hnController,
            keyboardType: TextInputType.text,
            style: TextStyle(fontSize: 18)));
  }

  Container buildTextFielddetail() {
    return Container(
        margin: EdgeInsets.only(top: 5),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.yellow[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            decoration: InputDecoration.collapsed(hintText: "อาการป่วย"),
            controller: detailController,
            keyboardType: TextInputType.text,
            style: TextStyle(fontSize: 18)));
  }

  Container buildTextFieldaddress() {
    return Container(
        margin: EdgeInsets.only(top: 5),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.yellow[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            decoration: InputDecoration.collapsed(hintText: "ที่อยู่"),
            controller: addressController,
            keyboardType: TextInputType.text,
            style: TextStyle(fontSize: 18)));
  }

  Container buildTextFieldcountry() {
    return Container(
        margin: EdgeInsets.only(top: 5),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.yellow[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            decoration: InputDecoration.collapsed(hintText: "จังหวัด"),
            controller: countryController,
            keyboardType: TextInputType.text,
            style: TextStyle(fontSize: 18)));
  }

  Container buildTextFieldpost() {
    return Container(
        margin: EdgeInsets.only(top: 5),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.yellow[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            decoration: InputDecoration.collapsed(hintText: "รหัวไปรษณีย์"),
            controller: postController,
            keyboardType: TextInputType.text,
            style: TextStyle(fontSize: 18)));
  }


  Future<void> update () async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid = user.uid.toString();
    FirebaseDatabase database = new FirebaseDatabase();
    DatabaseReference databaseReference = database.reference().child('patient');
    databaseReference.child(uid).update(<String, String>{
      "Firsname": nameController.text.toString(),
    "lastname": surenameController.text.toString(),
      "HNnumber": hnController.text.toString(),
      "address": addressController.text.toString(),
      "county": countryController.text.toString(),
      "detail": detailController.text.toString(),
      "nickname": nicknameController.text.toString(),
      "phone": phoneController.text.toString(),
      "postcode": postController.text.toString(),

    }).then((_) {
      print('Transaction  committed.');
    });
    Fluttertoast.showToast(
        msg: "บันทึก",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);

  }

}


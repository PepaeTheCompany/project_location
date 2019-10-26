import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'home_attendant.dart';
class register_attentant extends StatefulWidget {
  register_attentant({Key key}) : super(key: key);

  @override
  _MySignUpPageState createState() => _MySignUpPageState();
}

class _MySignUpPageState extends State<register_attentant> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController surenameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController postController = TextEditingController();

  var mylist = List.generate(10, (i)=>"Flutter $i");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("สมัครสมาชิกผู้ดูแล", style: TextStyle(color: Colors.white)),

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

                          buildTextFieldEmail(),
                          buildTextFieldPassword(),
                          buildTextFieldPasswordConfirm(),
                          buildTextFieldname(),
                          buildTextFieldsurename(),
                          buildTextFieldphone(),
                          buildTextFieldaddress(),
                          buildTextFieldcountry(),
                          buildTextFieldpost(),

                          buildButtonSignUp(context),



                        ],
                      )
                  )
              ),

            )));
  }

  Container buildButtonSignUp(BuildContext context) {
    return Container(
        constraints: BoxConstraints.expand(height: 65),
        child: RaisedButton(
            color: Colors.green[200],

            child: Text('สมัครสมาชิก',

                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.white)),
            shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(14.0)),
            onPressed: () async {
              signUp();

            }
        ) , padding: EdgeInsets.all(12));
  }

  Container buildTextFieldEmail() {
    return Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.yellow[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            decoration: InputDecoration.collapsed(hintText: "อีเมลล์"),
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(fontSize: 18)));
  }

  Container buildTextFieldPassword() {
    return Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(top: 5),
        decoration: BoxDecoration(
            color: Colors.yellow[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            obscureText: true,
            controller: passwordController,
            decoration: InputDecoration.collapsed(hintText: "รหัสผ่าน"),
            style: TextStyle(fontSize: 18)));
  }

  Container buildTextFieldPasswordConfirm() {
    return Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(top: 5),
        decoration: BoxDecoration(
            color: Colors.yellow[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            obscureText: true,
            controller: confirmController,
            decoration: InputDecoration.collapsed(hintText: "ยืนยันรหัสผ่าน"),
            style: TextStyle(fontSize: 18)));
  }
  Container buildTextFieldname() {
    return Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(top: 5),
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
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(top: 5),
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
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(top: 5),
        decoration: BoxDecoration(
            color: Colors.yellow[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            decoration: InputDecoration.collapsed(hintText: "เบอร์โทร"),
            controller: phoneController,
            keyboardType: TextInputType.number,
            style: TextStyle(fontSize: 18)));
  }
  Container buildTextFieldaddress() {
    return Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(top: 5),
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
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(top: 5),
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
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(top: 5),
        decoration: BoxDecoration(
            color: Colors.yellow[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            decoration: InputDecoration.collapsed(hintText: "รหัสไปรษณีย์"),
            controller: postController,
            keyboardType: TextInputType.text,
            style: TextStyle(fontSize: 18)));
  }
  signUp() async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmController.text.trim();


    if (password == confirmPassword && password.length >= 6) {
      _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((user) async {
        final FirebaseUser user = await FirebaseAuth.instance.currentUser();
        final String uid = user.uid.toString();
        FirebaseDatabase database = new FirebaseDatabase();
        DatabaseReference databaseReference = database.reference().child('attendant');
        databaseReference.child(uid).set(<String, String>{
         "email":  emailController.text.trim(),
        "password": passwordController.text.trim(),
          "name": nameController.text.toString(),
          "Surename": surenameController.text.toString(),
          "address": addressController.text.toString(),
          "county": countryController.text.toString(),
          "Phone": phoneController.text.toString(),
          "postcode": postController.text.toString(),

        }).then((_) {
          print('Transaction  committed.');
        });
        DatabaseReference databaseReference1 = database.reference().child('information');
        databaseReference1.push().set(<String, String>{
          "email":  emailController.text.trim(),
          "status": "attendant",
          "uid": uid,


        }).then((_) {
          print('Transaction  committed.');
        });
        print("สมัครสมาชิกสำเร็จ");

        checkAuth(context);

      }).catchError((error) {
        print(error.message);
      });
    } else {
      print("รหัสผ่านไม่ตรงกัน");
    }
  }
  Future checkAuth(BuildContext context) async {
    FirebaseUser user = await _auth.currentUser();
    if (user != null) {
      print("Already singed-in with");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => home_attendant(user)));
    }
  }
}


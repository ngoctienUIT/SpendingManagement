import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool valNotify1 = true;
  bool valNotify2 = false;
  bool valNotify3 = false;

  onChangeFunction1(bool newValue1){
    setState((){
      valNotify1 = newValue1;
    });
  }

  onChangeFunction2(bool newValue2){
    setState((){
      valNotify2 = newValue2;
    });
  }

  onChangeFunction3(bool newValue3){
    setState((){
      valNotify3 = newValue3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            const SizedBox(height: 40),
            Row(
              children:const [
                Icon(
                  Icons.person,
                  color: Colors.blue,
                ),
                SizedBox(width:10),
                Text("Account", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
              ],
            ),
            const Divider(height:20, thickness: 1),
            const SizedBox(height:10),
            buildAccountOption(context, "Change Password"),
            buildAccountOption(context, "Edit profile"),
            buildAccountOption(context, "Languages"),
            const SizedBox(height:40),
            Row(
              children:const [
                Icon(Icons.volume_off_outlined, color: Colors.blue),
                SizedBox(width:10),
                Text ("Notifications", style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                ))
              ],
            ),
            const Divider(height: 20,thickness: 1),
            const SizedBox(height:10),
            buildNotificationsOptions("theme Dark", valNotify1,onChangeFunction1),
            buildNotificationsOptions("Account Active", valNotify2,onChangeFunction2),
            buildNotificationsOptions("Opportunity", valNotify3,onChangeFunction3),
            const SizedBox(height:50),
            Center(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                ),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  await GoogleSignIn().signOut();
                  await FacebookAuth.instance.logOut();
                  if (!mounted) return;
                  Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                },
                child:const Text("SIGN OUT", style: TextStyle(
                  fontSize: 16,
                  letterSpacing: 2.2,
                  color: Colors.black
                )),
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding buildNotificationsOptions(String title, bool value, Function onChangedMethod){
    return Padding(padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.grey[600]
        )),
        Transform.scale(
          scale: 0.7,
          child: CupertinoSwitch(
            activeColor: Colors.blue,
            trackColor: Colors.grey,
            value: value,
            onChanged: (bool newValue) {
              onChangedMethod(newValue);
            },
          )
        )
      ],
    ),
    );
  }

  GestureDetector buildAccountOption(BuildContext context,String title){
    return GestureDetector(
      onTap: (){
        showDialog(context: context, builder: (BuildContext context){
          return AlertDialog(
            title: Text(title),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("options 1"),
                Text("options 2")
              ],
            ),
            actions: [
              TextButton(onPressed:(){
                Navigator.of(context).pop();
              }, child: Text("close"))
            ],
          );
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:20, vertical:8),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(
              fontSize:20,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600]
            )),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey)
          ],
        )
      )
    );
  }
}

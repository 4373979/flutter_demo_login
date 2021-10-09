import 'package:flutter/material.dart';
import 'package:flutter_demo_login/widgets/login/login_functions.dart';


Widget buildFloatingActionButton(BuildContext context){
  return FloatingActionButton(
    elevation: 0,
    backgroundColor: Colors.transparent,
    child: const Icon(Icons.language, color: Colors.black,size: 30,),
    onPressed: (){
      onActionSheetPress(context);
    },
  );
}
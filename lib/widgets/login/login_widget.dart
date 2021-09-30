import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_login/widgets/login/login_function.dart';
import 'package:flutter_demo_login/widgets/login/third_party_login.dart';
import 'package:ionicons/ionicons.dart';
import 'package:easy_localization/easy_localization.dart';

Widget buildFloatingActionButton(BuildContext context){
  return FloatingActionButton(
    elevation: 0,
    backgroundColor: Colors.transparent,
    child: const Icon(Icons.language, color: Colors.white,size: 30,),
    onPressed: (){
      onActionSheetPress(context);
    },
  );
}

BoxDecoration bulidDecorationImage(){
  return const BoxDecoration(
      image: DecorationImage(
          image: AssetImage('assets/images/bg-cover.jpg'),
          fit: BoxFit.fill)
  );
}

BoxDecoration bulidBoxDecorationBackgroundColor(){
  return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20)
  );
}

Widget buildLogoImage(){
  return Expanded(
      child: Transform.scale(
          scale: 3.0,
          child: Image.asset('assets/images/login.png')
      )
  );
}

Widget buildButtonGroup(BuildContext context){
  return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisSize:MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: const Icon(Ionicons.logo_google),
            iconSize: 30,
            onPressed: (){
              signInWithGoogle(context);
            },
          ),
          IconButton(
            icon: const Icon(Ionicons.logo_apple),
            iconSize: 30,
            onPressed: (){
            },
          ),
          IconButton(
            icon: const Icon(Ionicons.logo_facebook),
            iconSize: 30,
            onPressed: (){
              signInWithFacebook(context);
            },
          ),
          IconButton(
            icon: const Icon(Ionicons.logo_twitter),
            iconSize: 30,
            onPressed: (){
            },
          )
        ],
      )
  );
}

Widget buildLoginButton(BuildContext context,_formKey,username,password){
  return TextButton(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
      padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 15)),
      minimumSize:MaterialStateProperty.resolveWith((states) => const Size(double.infinity, 40)),
    ),
    child: const Text('button.login', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)).tr(),
    onPressed: (){
      userLogin(context,_formKey,username,password);
    },
  );
}

Widget buildSignUpButton(BuildContext context){
  return TextButton(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
      padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 15)),
      minimumSize:MaterialStateProperty.resolveWith((states) => const Size(double.infinity, 40)),
    ),
    child: const Text('button.signUp', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)).tr(),
    onPressed: (){},
  );
}
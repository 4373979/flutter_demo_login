import 'package:flutter/material.dart';
import 'package:flutter_demo_login/db/login_db.dart';
import 'package:flutter_demo_login/models/user_info_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeDrawer extends StatefulWidget {

  final UserInfoModel? userInfoModel;

  HomeDrawer({required this.userInfoModel}) : super();

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {

  UserInfoModel? userInfoModel;

  @override
  void initState() {
    super.initState();
    userInfoModel=widget.userInfoModel;
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future<void> _handleSignOut() async {
    _googleSignIn.disconnect();
  }

  Future<void> logout() async {
    await LoginDb().logout()
        .then((value) => _handleSignOut())
        .then((value) =>
        Navigator.pushReplacementNamed(
        context,
        "/login"));
  }

  @override
  Widget build(BuildContext context) {
    // String pictureUrl = userInfoModel!.picture;
    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            height: 100,
            color: Colors.blue,
            child: Row(
                children: <Widget>[
                  Row(children: <Widget>[
                    Container(
                        margin: EdgeInsets.all(10),
                        height: 80,
                        width: 280,
                        child:
                        userInfoModel!.picture==null?
                        ListTile(
                          leading: CircleAvatar(
                            maxRadius:30,
                            backgroundImage: AssetImage("assets/images/null.png"),
                          ),
                          title: Text(userInfoModel!.name==null?userInfoModel!.name.toString():'',style: TextStyle(fontSize:24,color: Colors.white)),
                          subtitle: Text(userInfoModel!.email==null?userInfoModel!.email.toString():'',style: TextStyle(fontSize:15,color: Colors.white)),
                        ):
                        ListTile(
                          leading: CircleAvatar(
                            maxRadius:30,
                            backgroundImage: NetworkImage(userInfoModel!.picture.toString()),
                          ),
                          title: Text(userInfoModel!.name.toString(),style: TextStyle(fontSize:24,color: Colors.white)),
                          subtitle: Text(userInfoModel!.email.toString(),style: TextStyle(fontSize:15,color: Colors.white)),
                        )
                    ),
                  ]),
                ]
            ),
          ),
          ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.logout),
            ),
            title: Text('logout'.tr()),
            onTap: (){
              logout();
            },
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class MenuBotton extends StatelessWidget {
  const MenuBotton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.menu),
      tooltip: 'personal_information'.tr(),
      onPressed: (){
        Scaffold.of(context).openDrawer();
      },
    );
  }
}
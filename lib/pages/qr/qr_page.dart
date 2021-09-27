import 'package:flutter/material.dart';
import 'package:flutter_demo_login/db/qr_login_db.dart';
import 'package:scan/scan.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:easy_localization/easy_localization.dart';

class QrPage extends StatelessWidget {
  const QrPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScanController controller = ScanController();
    final size =MediaQuery.of(context).size;
    final screenWidth =size.width;
    final screenHeight =size.height;
    return Scaffold(
      floatingActionButton: buildFloatingActionButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black,
        child: Column(
          children: [
            Wrap(
              children: [
                Container(
                  width: screenWidth,
                  height: screenHeight,
                  child: ScanView(
                    controller: controller,
                    scanAreaScale: .7,
                    scanLineColor: Colors.green.shade400,
                    onCapture: (data) async {
                      if (data == null) {
                        Fluttertoast.showToast(
                            msg: 'not_scan_anything'.tr(),
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      } else {
                        print("data:$data");
                        await QrLoginDb().setQrLogin(data);
                        Navigator.pushNamed(
                            context,
                            "/qrLogin");
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

  }
  Widget buildFloatingActionButton(BuildContext context){
    return FloatingActionButton(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: const Icon(Icons.arrow_back_ios_new, color: Colors.grey,size: 30,),
      onPressed: (){
        Navigator.pushNamed(
            context,
            "/home");
      },
    );
  }
}

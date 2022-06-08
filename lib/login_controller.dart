import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogInController extends GetxController{
  final isLoggedIn = false.obs;

  static SharedPreferences? sharedPref;
  LogInController(){
    _getStoreVale();
  }
  Future<void> changeStatus(bool val)
  async {
    isLoggedIn(val);
    sharedPref?.setBool("Log in",isLoggedIn.value);
  }
  Future<void> _getStoreVale() async{
    isLoggedIn(sharedPref?.getBool("Log in") ?? false);
  }
  void showMessage(String incorrect){
    Get.defaultDialog(
        title: 'Incorrect $incorrect',
        middleText:
        "The $incorrect you entered is incorrect. Please try again",
        confirm: Column(
          children: [
            Divider(
              color: Colors.grey[800],
            ),
            InkWell(
              child: const SizedBox(
                height: 40,
                child: Center(child: Text('Try Again')),
              ),
              onTap: () => Get.back(),
            ),
          ],
        ),
        backgroundColor: const Color(0xffe5e5e5));
  }
}
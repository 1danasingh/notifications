import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signin/login_controller.dart';
import 'package:signin/notifaction_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LogInController.sharedPref = await SharedPreferences.getInstance();
  runApp(const GetMaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  LogInController logInController = Get.isRegistered<LogInController>()? Get.find<LogInController>():Get.put(LogInController());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String email = 'whyvandanaaa@gmail.com';
  String password = 'hihiyhu';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Obx(
            ()=> !(logInController.isLoggedIn.value)?Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: const Text('Sign in'),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: 'Enter email'),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: 'Enter password'),
                  obscureText: true,
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (emailController.text == email &&
                        passwordController.text == password) {
                      Get.off(() => const Notifications());
                      logInController.changeStatus(true);
                    } else {
                      String incorrect = (emailController.text == email)
                          ? 'Password'
                          : 'Email';
                      logInController.showMessage(incorrect);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(Get.width, 55),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  child: const Text('Log In'),
                )
              ],
            ),
          ),
        ):const Notifications()
    );
  }
}

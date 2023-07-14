import 'package:flutter/material.dart';
import 'package:my_app/main.dart';
import 'package:my_app/screens/home/screen_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({Key? key}) : super(key: key);

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  final _UserNameController = TextEditingController();

  final _PasswordController = TextEditingController();

  bool _isDataMatched = true;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: Builder(builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextFormField(
                  controller: _UserNameController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'User Name'),
                  validator: (value) {
                    //if (_isDataMatched) {
                    //  return null;
                    //} else {
                    //   return 'Error';
                    // }
                    //  ;
                    if (value == null || value.isEmpty) {
                      return 'value is Empty';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _PasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Password'),
                  validator: (value) {
                    //if (_isDataMatched) {
                    //  return null;
                    // } else {
                    //  return 'Error';
                    //  }
                    // ;
                    if (value == null || value.isEmpty) {
                      return 'value is Empty';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Visibility(
                      visible: !_isDataMatched,
                      child: Text(
                        'Username & Password doesnot match',
                        style:
                            TextStyle(color: Color.fromARGB(255, 255, 17, 0)),
                      ),
                    ),
                    ElevatedButton.icon(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            checkLogin(context);
                          } else {
                            print('Data Empty');
                          }

                          //checkLogin(context);
                        },
                        icon: const Icon(
                          Icons.check,
                          color: Colors.orange,
                          size: 15.0,
                        ),
                        label: const Text('LogIn')),
                  ],
                )
              ],
            ),
          ),
        );
      }),
    ));
  }

  Future<void> checkLogin(BuildContext context) async {
    final _username = _UserNameController.text;
    final _password = _PasswordController.text;
    if (_username == _password) {
      print('Username & Password match');

      //Goto Home

      final _sharedprefs = await SharedPreferences.getInstance();
      await _sharedprefs.setBool(SAVE_KEY_NAME, true);

      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => ScreenHome()));
    } else {
      print('Username & Password does not match');

      //Snackbar
      //ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //    duration: Duration(seconds: 5),
      //    backgroundColor: Color.fromARGB(255, 255, 17, 0),
      //    behavior: SnackBarBehavior.floating,
      //    margin: EdgeInsets.all(10),
      //    content: Text('Username & Password doesnot match')));
    }
  }
}

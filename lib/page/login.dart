import 'package:flutter/material.dart';
import 'package:flspai/model/login_request_model.dart';
import 'package:flspai/services/api_services.dart';
import 'package:flspai/page/signup.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

import '../config.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isAPIcallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      bottomSheet: Container(
        width: double.infinity,
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("Dont Have account ?",
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            FlatButton(
                onPressed: ()=> Navigator.pushNamed(context, "/register"),
                child: Text("Sign Up",
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)))
          ],),
      ),
      body: ProgressHUD(
        child: Form(
      key: globalFormKey,
      child: _loginUI(context),
    ),
        inAsyncCall: isAPIcallProcess,
        opacity: 0.3,
        key: UniqueKey(),
      ),
    ),
    );
  }

  Widget _loginUI(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 1,
              color: fromCssColor('#FFDC97'),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/img.png', width: 250, height: 300),
                  SizedBox(height: 5),
                  Text(
                    'LifeHealth',
                    style:
                    TextStyle(fontSize: 22, fontFamily: "Roboto", fontWeight: FontWeight.bold,height: 2.0, color: Colors.brown),
                  ),
                ],),
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                bottom: 30,
                top: 35
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FormHelper.inputFieldWidget(
                      context,
                      const Icon(Icons.person),
                      "username",
                      "UserName",
                          (onValidateVal) {
                        if(onValidateVal.isEmpty){
                          return "Username can't be empty";
                        }
                        return null;
                      },
                          (onSavedVal) {
                        username = onSavedVal;
                      },
                      borderFocusColor: Colors.brown,
                      prefixIconColor: Colors.brown,
                      borderColor: Colors.brown,
                      textColor: Colors.black,
                      hintColor: Colors.grey.withOpacity(0.7),
                      borderRadius: 12
                  ),
                  SizedBox(height: 30),
                  FormHelper.inputFieldWidget(
                      context,
                      const Icon(Icons.lock),
                      "password",
                      "Password",
                          (onValidateVal) {
                        if(onValidateVal.isEmpty){
                          return "Password can't be empty";
                        }
                        return null;
                      },
                          (onSavedVal) {
                        password = onSavedVal;
                      },
                      borderFocusColor: Colors.brown,
                      prefixIconColor: Colors.brown,
                      borderColor: Colors.brown,
                      textColor: Colors.black,
                      hintColor: Colors.grey.withOpacity(0.7),
                      borderRadius: 12,
                      obscureText: hidePassword,
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                        color: Colors.brown.withOpacity(0.7),
                        icon: Icon(
                          hidePassword ? Icons.visibility_off : Icons.visibility,
                        ),)
                  ),
                  SizedBox(height: 40),
                  Center(
                    child: FormHelper.submitButton(
                        "Sign In",
                          () {
                            if (validateAndSave()) {
                              setState(() {
                                isAPIcallProcess = true;
                              });

                              Map<String,String> model = {
                                'username': username,
                                'password': password,
                              };

                              APIService.login(model).then((response) => {
                                print(model),
                              setState(() {
                              isAPIcallProcess = false;
                              }),

                              if(response) {
                                Navigator.pushNamedAndRemoveUntil(context, '/startdata', (route) => false
                                )
                              }
                              else {
                                FormHelper.showSimpleAlertDialog(
                                context,
                                Config.appName,
                                "Invalid Username/Password",
                                "OK",
                                () {
                                  Navigator.pop(context);
                                },
                              )
                            }
                            }
                            );
                            }
                          },
                    btnColor: Colors.brown,
                    borderColor: Colors.white,
                    txtColor: Colors.white,
                    borderRadius: 10)
                  )

                  //      FlatButton(
                    //      onPressed: ()=> Navigator.pushReplacement(context,
                      //        MaterialPageRoute(builder: (context){
                        //        return Menu();
                          //    })),
                          //child: Text("Sign In",
                            //  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),)
                      ],
                    ),
                  ),
                ],
              ),
            )
          ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}
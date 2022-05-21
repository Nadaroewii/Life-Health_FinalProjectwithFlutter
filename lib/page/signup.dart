import 'package:flutter/material.dart';
import 'package:flspai/page/login.dart';
import 'package:flspai/page/mulai.dart';
import 'package:flspai/services/api_services.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

import '../config.dart';
import '../model/register_request_model.dart';


class SignUp extends StatefulWidget {
  const SignUp({ Key? key}) : super(key: key);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isAPIcallProcess = false;
  bool hidePassword = true;
  bool _isSecure = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String username = '';
  String? password = '';
  String? name = '';
  String? email = '';
  void tesTapButton() {
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ProgressHUD(
          child: Form(
            key: globalFormKey,
            child: _registerUI(context),
          ),
          inAsyncCall: isAPIcallProcess,
          opacity: 0.3,
          key: UniqueKey(),
        ),
      ),);
  }

  Widget _registerUI(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .height,
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 1,
              color: fromCssColor('#FFDC97'),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'LifeHealth',
                    style:
                    TextStyle(fontSize: 24,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.bold,
                        height: 3.0,
                        color: Colors.brown),
                  ),
                ],),
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                bottom: 30,
                top: 35 ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sign Up Account',
                    style:
                    TextStyle(fontSize: 20,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.bold,
                        height: 1.0),
                  ),
                  SizedBox(height: 40),
                  FormHelper.inputFieldWidget(
                      context,
                      const Icon(Icons.person),
                      "name",
                      "Name",
                          (onValidateVal) {
                        if(onValidateVal.isEmpty){
                          return "Name can't be empty";
                        }
                        return null;
                      },
                          (onSavedVal) {
                        name = onSavedVal;
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
                      const Icon(Icons.email),
                      "Email",
                      "email",
                          (onValidateVal) {
                        if(onValidateVal.isEmpty){
                          return "Email can't be empty";
                        }
                        return null;
                      },
                          (onSavedVal) {
                        email = onSavedVal;
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
                          "Sign Up",
                              () {
                                if (validateAndSave()) {
                                  setState(() {
                                    isAPIcallProcess = true;
                                  });

                                  Map<String, String> model = {
                                    'username': username!,
                                    'password': password!,
                                    'email': email!,
                                    'name': name!,
                                  };

                                  APIService.register(model).then((response) => {
                                  setState(() {
                                  isAPIcallProcess = false;
                                  }),
                                    if(response.data != null) {
                                      FormHelper.showSimpleAlertDialog(
                                        context,
                                        Config.appName,
                                        "Registration Successfull. Please login to the account.",
                                        "OK",
                                            () {
                                          Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              '/login',
                                              (route) => false);
                                        },
                                      )
                                    }
                                    else {
                                      FormHelper.showSimpleAlertDialog(
                                        context,
                                        Config.appName,
                                        response.message,
                                        "OK",
                                            () {
                                          Navigator.pop(context);
                                        },
                                      )
                                    }
                                  });
                                }
                              },
                          btnColor: Colors.brown,
                          borderColor: Colors.white,
                          txtColor: Colors.white,
                          borderRadius: 10)
                  )
                ],
              ),
            )
          ],),
        ),
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
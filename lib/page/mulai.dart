
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flspai/page/otherpage.dart';
import 'package:flspai/model/Start.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

import '../config.dart';
import '../model/login_response_model.dart';
import '../services/shared_services.dart';


class Start extends StatefulWidget {
  const Start({ Key? key}) : super(key: key);
  @override
  State<Start> createState() => _StartState();
}
class _StartState extends State<Start> {
  String selectGender = "";
  List<String> genders = [
    "Female",
    "Male"
  ];

  TextEditingController _ageController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  TextEditingController _weightController = TextEditingController();

  void tesTapButton(){
  }
  // String selectActive = "";
  // List<String> active = [
  //   "Jalan Cepat",
  //   "Jalan Normal"
  // ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: fromCssColor('#FFDC97'),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'LifeHealth',
              style:
              TextStyle(fontSize: 21,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.bold,
                  height: 1.0,
                  color: Colors.brown),
            ),
          ],),
      ),
      bottomSheet: Container(
        width: double.infinity,
        color: Colors.brown,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child:
            Container(
              padding: EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children:<Widget>[
                  Text(
                    'Personal Data',
                    style:
                    TextStyle(fontSize: 20, fontFamily: "Roboto", fontWeight: FontWeight.bold,height: 1.0),
                  ),
                  //SizedBox(height: 20),
                  // DropdownSearch<String>(
                  //   showClearButton: true,
                  //   mode: Mode.MENU,
                  //   showSelectedItems: true,
                  //   items: active,
                  //   enabled: true,
                  //   label: "Activity Type",
                  //   hint: "Choose your Activity Type",
                  //   onChanged: (value){
                  //     setState(() {
                  //       selectActive = value!;
                  //     });
                  //   },
                  //   dropdownSearchBaseStyle:
                  //   TextStyle(fontSize: 12,fontFamily: "Roboto",fontWeight: FontWeight.bold,),
                  //   dropdownSearchDecoration: InputDecoration(
                  //     border: UnderlineInputBorder(),
                  //   ),
                  // ),
                  SizedBox(height: 20),
                  TextFormField(
                    style: TextStyle(fontSize: 12, fontFamily: "Roboto", fontWeight: FontWeight.bold,height: 2.0, color: Colors.black),
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Age'),
                    keyboardType: TextInputType.number,
                    controller: _ageController,
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    style: TextStyle(fontSize: 12, fontFamily: "Roboto", fontWeight: FontWeight.bold,height: 2.0, color: Colors.black),
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Weight'),
                    keyboardType: TextInputType.number,
                    controller: _weightController,
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    style: TextStyle(fontSize: 12, fontFamily: "Roboto", fontWeight: FontWeight.bold,height: 2.0, color: Colors.black),
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Height'),
                    keyboardType: TextInputType.number,
                    controller: _heightController,
                  ),
                  SizedBox(height: 10),
                  DropdownSearch<String>(
                    showClearButton: true,
                    mode: Mode.MENU,
                    showSelectedItems: true,
                    items: genders,
                    label: "Gender",
                    hint: "Choose your Gender",
                    onChanged: (value){
                      setState(() {
                        selectGender = value!;
                      });
                    },
                    dropdownSearchBaseStyle:
                    TextStyle(fontSize: 12,fontFamily: "Roboto",fontWeight: FontWeight.bold,),
                    dropdownSearchDecoration: InputDecoration(
                      border: UnderlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    padding: EdgeInsets.all(1),
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.brown,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      children: <Widget>[
                        FlatButton(
                          onPressed: () async {
                            Mulai mulai = Mulai(
                              gender: selectGender,
                              //dataactv: selectActive,
                              age: _ageController.text,
                              height: _heightController.text,
                              weight: _weightController.text,
                            );
                            //Mengambil Clientpubkey
                            LoginResponseModel? loginDetails = await SharedService.loginDetails();
                            var pcli = loginDetails!.data.ClientpubKey[0];
                            var gcli = loginDetails!.data.ClientpubKey[1];
                            var ycli = loginDetails!.data.ClientpubKey[2];
                            var xcli = loginDetails!.data.ClientprivKey[0];

                            FormHelper.showSimpleAlertDialog(
                            context,
                            Config.appName,
                            "Client's Public Key : $pcli,$gcli,$ycli \nClient's Private Key : $xcli",
                            "OK",
                            () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => OtherPage(mulai: mulai)));
                            },
                            );
                          },
                          child: Text("Start",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),)
                      ],
                    ),
                  ),
                ],
              ),
            ),
                  ))
    );
  }
}

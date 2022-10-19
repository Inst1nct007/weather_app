import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import 'package:http/http.dart';
import 'package:weather_app/front-end/pages/result_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Rx<String> text;
  late List<TextEditingController> textEditingControllers;
  late List<double> opacityManager;
  late final formKey;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    textEditingControllers = [TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController()];
    opacityManager = [1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0];
    text = 'Bangalore Air Quality Prediction'.obs;
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {

    });
  }

  getApiInfo() async {
    var APIKEY = 'JV480I6W3vOoxEFx9RqBtzEmI5_EQDA5hT7zID7fUAke';
    var tokenResponse = await post(
        Uri.parse('https://iam.cloud.ibm.com/identity/token'),
        body: {
          'apikey': APIKEY,
          'grant_type': 'urn:ibm:params:oauth:grant-type:apikey',
        });
    //print(tokenResponse.body);
    var mlToken = jsonDecode(tokenResponse.body)['access_token'];
    var url =
        'https://us-south.ml.cloud.ibm.com/ml/v4/deployments/541fbf3b-0170-4317-93bb-4a8d66c097d2/predictions?version=2022-10-14';
    var response = await post(Uri.parse(url),
        body: jsonEncode({
          "input_data": [
            {
              "fields": [
                [
                  "PM2.5",
                  "PM10",
                  "NO",
                  "NO2",
                  "NOx",
                  "NH3",
                  "CO",
                  "SO2",
                  "Toluene"
                ]
              ],
              "values": [
                [double.parse(textEditingControllers[0].text), double.parse(textEditingControllers[1].text), double.parse(textEditingControllers[2].text), double.parse(textEditingControllers[3].text), double.parse(textEditingControllers[4].text), double.parse(textEditingControllers[5].text), double.parse(textEditingControllers[6].text), double.parse(textEditingControllers[7].text), double.parse(textEditingControllers[8].text)]
              ]
            }
          ]
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $mlToken'
        }).then((value) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Result(prediction: jsonDecode(value.body)['predictions'][0]['values'][0][0],)));
      //print(jsonDecode(value.body)['predictions'][0]['values'][0][0]);
    });
  }
  

  manageOpacity() {
    setState(() {
      for(int i = 8; i >= 0; i--) {
        opacityManager[i] = 0.0;
        Future.delayed(Duration(milliseconds: 800));
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xffb8b8ff),
            /*gradient: LinearGradient(colors: [
                Color(0xff9381ff),
                Color(0xffb8b8ff),
              ], transform: GradientRotation(math.pi / 2)),*/
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height / 85.09,
                  horizontal: MediaQuery.of(context).size.width / 19.636),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedOpacity(
                    opacity: opacityManager[0],
                    duration: const Duration(milliseconds: 1500),
                    child: TextFormField(
                      validator: (text) {
                        if(text == null || text.isEmpty) {
                          return 'This Field cannot be empty';
                        }
                        return null;
                      },
                      controller: textEditingControllers[0],
                      onChanged: null,
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffb8b8ff),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Color(0xfff8f7ff)),
                        ),
                        labelText: 'Particulate Matter2.5 (PM2.5)',
                        labelStyle: TextStyle(color: Color(0xfff8f7ff)),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: Color(0xfff8f7ff)),
                        ),
                      ),
                      cursorWidth: 1,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 70.909,
                  ),
                  AnimatedOpacity(
                    opacity: opacityManager[1],
                    duration: const Duration(milliseconds: 1500),
                    child: TextFormField(
                      validator: (text) {
                        if(text == null || text.isEmpty) {
                          return 'This Field cannot be empty';
                        }
                        return null;
                      },
                      controller: textEditingControllers[1],
                      onChanged: null,
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffb8b8ff),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Color(0xfff8f7ff)),
                        ),
                        labelText: 'Particulate Matter10 (PM10)',
                        labelStyle: TextStyle(color: Color(0xfff8f7ff)),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: Color(0xfff8f7ff)),
                        ),
                      ),
                      cursorWidth: 1,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 70.909,
                  ),
                  AnimatedOpacity(
                    opacity: opacityManager[2],
                    duration: Duration(milliseconds: 1500),
                    child: TextFormField(
                      validator: (text) {
                        if(text == null || text.isEmpty) {
                          return 'This Field cannot be empty';
                        }
                        return null;
                      },
                    controller: textEditingControllers[2],
                      onChanged: null,
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffb8b8ff),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Color(0xfff8f7ff)),
                        ),
                        labelText: 'Nitric Oxide (NO)',
                        labelStyle: TextStyle(color: Color(0xfff8f7ff)),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: Color(0xfff8f7ff)),
                        ),
                      ),
                      cursorWidth: 1,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 70.909,
                  ),
                  AnimatedOpacity(
                    opacity: opacityManager[3],
                    duration: Duration(milliseconds: 1500),
                    child: TextFormField(
                      validator: (text) {
                        if(text == null || text.isEmpty) {
                          return 'This Field cannot be empty';
                        }
                        return null;
                      },
                      controller: textEditingControllers[3],
                      onChanged: null,
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffb8b8ff),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Color(0xfff8f7ff)),
                        ),
                        labelText: 'Nitrogen Dioxide (No2)',
                        labelStyle: TextStyle(color: Color(0xfff8f7ff)),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: Color(0xfff8f7ff)),
                        ),
                      ),
                      cursorWidth: 1,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 70.909,
                  ),
                  AnimatedOpacity(
                    opacity: opacityManager[4],
                    duration: Duration(milliseconds: 1500),
                    child: TextFormField(
                      validator: (text) {
                        if(text == null || text.isEmpty) {
                          return 'This Field cannot be empty';
                        }
                        return null;
                      },
                      controller: textEditingControllers[4],
                      onChanged: null,
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffb8b8ff),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Color(0xfff8f7ff)),
                        ),
                        labelText: 'Nitrogen Oxides (Nox)',
                        labelStyle: TextStyle(color: Color(0xfff8f7ff)),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: Color(0xfff8f7ff)),
                        ),
                      ),
                      cursorWidth: 1,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 70.909,
                  ),
                  AnimatedOpacity(
                    opacity: opacityManager[5],
                    duration: Duration(milliseconds: 1500),
                    child: TextFormField(
                      validator: (text) {
                        if(text == null || text.isEmpty) {
                          return 'This Field cannot be empty';
                        }
                        return null;
                      },
                      controller: textEditingControllers[5],
                      onChanged: null,
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffb8b8ff),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Color(0xfff8f7ff)),
                        ),
                        labelText: 'Ammonia (NH3)',
                        labelStyle: TextStyle(color: Color(0xfff8f7ff)),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: Color(0xfff8f7ff)),
                        ),
                      ),
                      cursorWidth: 1,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 70.909,
                  ),
                  AnimatedOpacity(
                    opacity: opacityManager[6],
                    duration: Duration(milliseconds: 1500),
                    child: TextFormField(
                      validator: (text) {
                        if(text == null || text.isEmpty) {
                          return 'This Field cannot be empty';
                        }
                        return null;
                      },
                      controller: textEditingControllers[6],
                      onChanged: null,
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffb8b8ff),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Color(0xfff8f7ff)),
                        ),
                        labelText: 'Carbon Monoxide (CO)',
                        labelStyle: TextStyle(color: Color(0xfff8f7ff)),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: Color(0xfff8f7ff)),
                        ),
                      ),
                      cursorWidth: 1,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 70.909,
                  ),
                  AnimatedOpacity(
                    opacity: opacityManager[7],
                    duration: Duration(milliseconds: 1500),
                    child: TextFormField(
                      validator: (text) {
                        if(text == null || text.isEmpty) {
                          return 'This Field cannot be empty';
                        }
                        return null;
                      },
                      controller: textEditingControllers[7],
                      onChanged: null,
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffb8b8ff),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Color(0xfff8f7ff)),
                        ),
                        labelText: 'Sulphur Dioxide (SO2)',
                        labelStyle: TextStyle(color: Color(0xfff8f7ff)),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: Color(0xfff8f7ff)),
                        ),
                      ),
                      cursorWidth: 1,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 70.909,
                  ),
                  AnimatedOpacity(
                    opacity: opacityManager[8],
                    duration: Duration(milliseconds: 1500),
                    child: TextFormField(
                      validator: (text) {
                        if(text == null || text.isEmpty) {
                          return 'This Field cannot be empty';
                        }
                        return null;
                      },
                      controller: textEditingControllers[8],
                      onChanged: null,
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffb8b8ff),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Color(0xfff8f7ff)),
                        ),
                        labelText: 'Toluene (Tol)',
                        labelStyle: TextStyle(color: Color(0xfff8f7ff)),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: Color(0xfff8f7ff)),
                        ),
                      ),
                      cursorWidth: 1,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 70.909,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if(formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Calculating Air Quality...'), backgroundColor: Color(0xff9381ff), duration: Duration(seconds: 5), behavior: SnackBarBehavior.floating,));
                              getApiInfo();
                            }
                              //manageOpacity();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              'Predict',
                              style: TextStyle(
                                  color: Color(0xff9381ff), fontSize: 15),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                              elevation: 1,
                              backgroundColor: const Color(0xfff8f7ff),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              )),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

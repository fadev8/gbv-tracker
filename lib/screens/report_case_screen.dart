import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gbv_tracker/screens/login_screen.dart';
import 'package:gbv_tracker/constants/constants.dart';
import 'package:gbv_tracker/core/api.dart';
import 'package:gbv_tracker/core/init.dart';
import 'package:gbv_tracker/widgets/logout_button.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:toast/toast.dart';




import 'package:gbv_tracker/screens/receivedcases_screen.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;


class ReportCaseScreen extends StatefulWidget {
  static String id = "report-case-screen";
  @override
  _ReportCaseScreenState createState() => _ReportCaseScreenState();
}

//Sex value enumeration
enum Sex { Male, Female }

class _ReportCaseScreenState extends State<ReportCaseScreen> {
  TextEditingController _controller = TextEditingController();
  TextEditingController Namescontroller = new TextEditingController();
  TextEditingController Victimecellcontroller = new TextEditingController();
  TextEditingController Victimevillagecontroller = new TextEditingController();
  TextEditingController perpetratorcellcontroller = new TextEditingController();
  TextEditingController perpetratorvillagecontroller = new TextEditingController();
  TextEditingController emailcontroller = new TextEditingController();
  //variable for set managment
  int _currentStep = 0;

  String Province;

  String Group;
  String District;
  String Sectors;
  bool loadingData = false;

  //===== Step 1 Values
  String fullNames="";
  String victimeSex = 'Male';
  String age="", telephone="", email="";
  String idNumber="";
  String disabilityDescription="";
  bool hasDisability = false;

  //Data about proving
  List data = [];
  List dataGroup = [];

  List Districtdata = [];
  List Sectorsdata = [];

  Future<String> ProvinceData() async {
    setState(() {
      loadingData = true;
    });
    var user_category = await getRef("user_category");

    if (user_category != null) {
      ProvinceListJson = await getProvince();
      setState(() {
        if (ProvinceListJson['status'] == "1") {
          data = ProvinceListJson['data'];
          print(data);
        }
      });
    } else {}
    setState(() {
      loadingData = false;
    });
  }

  Future<String> GroupData() async {
    setState(() {
      loadingData = true;
    });
    var user_category = await getRef("user_category");

    if (user_category != null) {
      GroupListJson = await getGroup();
      setState(() {
        if (GroupListJson['status'] == "1") {
          dataGroup = GroupListJson['data'];
          print(dataGroup);
        }
      });
    } else {}
    setState(() {
      loadingData = false;
    });
  }



  Future<String> DistrictData(String Province) async {

    var user_category = await getRef("user_category");
    Districtdata = [];
    if (user_category != null) {
      DistrictListJson = await getDistrict(Province);
      setState(() {
        if (DistrictListJson['status'] == "1") {
          Districtdata = DistrictListJson['data'];
          print(Districtdata);
        }
      });
    } else {}

  }

  Future<String> SectorData(String District) async {

    var user_category = await getRef("user_category");

    if (user_category != null) {
      SectorListJson = await getSectors(District);
      setState(() {
        if (SectorListJson['status'] == "1") {
          Sectorsdata = SectorListJson['data'];
          print(Sectorsdata);
        }
      });
    } else {}

  }

  //Data about proving
  List Pdata = [];
  List PDistrictdata = [];
  List PSectorsdata = [];

  String ProvinceP;
  String DistrictP;
  String SectorsP;

  Future<String> ProvinceDataP() async {
    setState(() {
      loadingData = true;
    });
    var user_category = await getRef("user_category");

    if (user_category != null) {
      ProvinceListJson = await getProvince();
      setState(() {
        if (ProvinceListJson['status'] == "1") {
          Pdata = ProvinceListJson['data'];
          print(Pdata);
        }
      });
    } else {}
    setState(() {
      loadingData = false;
    });
  }

  Future<String> DistrictDataP(String Province) async {

    var user_category = await getRef("user_category");
    PDistrictdata = [];
    if (user_category != null) {
      DistrictListJson = await getDistrict(Province);
      setState(() {
        if (DistrictListJson['status'] == "1") {
          PDistrictdata = DistrictListJson['data'];
          print(PDistrictdata);
        }
      });
    } else {}

  }

  Future<String> SectorDataP(String District) async {

    var user_category = await getRef("user_category");
    PSectorsdata = [];
    if (user_category != null) {
      SectorListJson = await getSectors(District);
      setState(() {
        if (SectorListJson['status'] == "1") {
          PSectorsdata = SectorListJson['data'];
          print(PSectorsdata);
        }
      });
    } else {}

  }


  String Victimcell="";
  String Victimvillage="";

  //===  Ste3 variables
  String violenceType = 'SELECT';
  String numberOfTimes="", caseDescription="";
  String violenceDescription="";

  //=== Step 4 variables
  String perpetratorSex = 'Male';
  String ageInterval = 'SELECT';
  bool forwardToPolice = false;

  //=== Step5 variables

  String perpetratorcell = "";
  String perpetratorvillage = "";

  //========FONCTIONS to retrieved Provincee and District=====


  AddCase(
      String fullNames,
      String victimeSex,
      String age,
      String idNumber,
      String telephone,
      String email,
      String disabilityDescription,

      String Province,
      String District,
      String Sectors,
      String Victimcell,
      String Victimvillage,

      String violenceType,
      String numberOfTimes,
      String violenceDescription,
      String perpetratorSex,
      String ageInterval,



      String ProvinceP,
      String DistrictP,
      String SectorsP,
      String perpetratorcell,
      String perpetratorvillage,

      String group,



      ) async {
    var user_id = await getRef("user_id");

    setState(() {
      loadingData = true;
    });

 http.Response response = await http.post(BASE_URL + "claims", body: {
      'action': "AddCase",
      'victimName': fullNames,
      'victimGender': victimeSex,
      'victimIdNumber': idNumber,
      'victimDisability': disabilityDescription,
      'victimTelephone': telephone,
      'victimEmail': email,
      'victimGroup': group,
      'victimAge': age,
      'victimProvince': Province,
      'victimDistrict': District,
      'victimSector': Sectors,
      'victimCell': Victimcell,
      'victimVillage':Victimvillage ,
      'victimCaseType': violenceType,
      'victimNumber_times': numberOfTimes,
      'victimCaseDescription': violenceDescription,
      'abuserGender': perpetratorSex,
      'abuser_age_range':ageInterval ,
      'caseFfollowup':"false" ,
      'abuserProvince': ProvinceP,
      'abuserDistrict': DistrictP,
      'abuserSector': SectorsP,
      'abuserCell': perpetratorcell,
      'abuserVillage':perpetratorvillage ,
      'user':user_id
    });
    print(response.statusCode);

    //check http code
    if (response.statusCode == 200) {
      responseJson = convert.jsonDecode(response.body);
      print(responseJson);

      if (responseJson['status'] == "1") {
        Toast.show(responseJson['message'], context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
//        SweetAlert.show(context,
//            title: responseJson['message'], style: SweetAlertStyle.success);

        print(responseJson);

        // save login data

        Navigator.pushNamed(context, ReceivedCaseScreen.id);
      } else if (responseJson['status'] == "0") {
        SweetAlert.show(context,
            title: responseJson['message'], style: SweetAlertStyle.error);
      } else
        Toast.show("Invalid Response Status", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } else if (response.statusCode == 500) {
      Toast.show("Server eror", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } else {
      SweetAlert.show(context,
          title: "Network Error", style: SweetAlertStyle.error);
    }

    setState(() {
      loadingData = false;
    });
  }

  void initState() {
    super.initState();
    this.ProvinceData();
    this.ProvinceDataP();
    this.GroupData();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Report a case'),
          actions: [
            LogoutButton(
              onPressed: () {
                //TODO : Logout operation here
                Logout();
                Navigator.popAndPushNamed(context, LoginScreen.id);
              },
            ),
          ],
        ),

        //============ Screen body =========
        body:loadingData
            ? Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.grey,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
          ),
        )
            :  Stepper(
          currentStep: _currentStep,
          steps: _formSetps(),
          onStepTapped: (step){
            setState(() {
              _currentStep = step;
            });
          },
          onStepContinue: () {
            setState(() {
              if (_currentStep < this._formSetps().length - 1) {
                _currentStep++;
              } else {
                fullNames=Namescontroller.text;
                Victimcell=Victimecellcontroller.text;
                Victimvillage= Victimevillagecontroller.text;

              perpetratorcell = perpetratorcellcontroller.text;
                perpetratorvillage = perpetratorvillagecontroller.text;

                print(fullNames +" "+victimeSex+" "+age+" "+idNumber+" "+telephone+" "+email+" "+disabilityDescription);
                print(Province +" "+District+" "+Sectors+" "+Victimcell +" "+Victimvillage);
                print(violenceType +" "+numberOfTimes+" "+violenceDescription+""+Group);

                print(perpetratorSex +" "+ageInterval);
                    if (fullNames != "" &&
                        victimeSex != "" &&
                        age != "" &&
                        idNumber != "" &&
                        telephone != "" &&
                        email != "" &&
                        Group != "" &&
                        Province != "" &&
                        District != "" &&
                        Sectors != "" &&
                        Victimcell != "" &&
                        Victimvillage != "" &&
                        violenceType != "SELECT" &&
                        numberOfTimes != "" &&
                        violenceDescription != "" &&

                        perpetratorSex != "" &&
                        ageInterval != "SELECT" &&

                        ProvinceP != "" &&
                        DistrictP != "" &&
                        SectorsP != "" &&
                        perpetratorcell != "" &&
                        perpetratorcell != ""
                    )
                    {
                      AddCase(
                         fullNames,
                         victimeSex,
                         age,
                         idNumber,
                         telephone,
                         email,
                         disabilityDescription,

                         Province,
                         District,
                         Sectors,
                         Victimcell,
                         Victimvillage,

                         violenceType,
                         numberOfTimes,
                         violenceDescription,
                         perpetratorSex,
                         ageInterval,



                         ProvinceP,
                         DistrictP,
                         SectorsP,
                         perpetratorcell,
                         perpetratorvillage, Group


                      );
                        print("all fields");
                      }
                    else
                      {
                      Toast.show(
                      "Please fill all the field and proceed",
                      context,
                      duration: Toast.LENGTH_LONG,
                      gravity: Toast.BOTTOM);
                      }









                print(ProvinceP +" "+DistrictP+" "+SectorsP+" "+perpetratorcell +" "+perpetratorcell);

                print('End of form');
              }
            });
          },
          onStepCancel: () {
            setState(() {
              if (_currentStep > 0) {
                _currentStep--;
              }
            });
          },
          controlsBuilder: (BuildContext context, {VoidCallback onStepContinue, VoidCallback onStepCancel}){
              return Row(
                children: [
                  SizedBox(height: 16,),
                  Container(
                    color: Colors.blue,
                    child: FlatButton(
                      child: Text('NEXT',style: kButtonTextStyle,),
                      onPressed: onStepContinue,
                    ),
                  ),

                  FlatButton(
                    child: Text('BACK',style: kButtonTextStyle.copyWith(color: Colors.grey),),
                    onPressed: onStepCancel,
                  ),
                ],
              );
          },
        ),
      ),
    );
  }

  //==== report case form steps===
  List<Step> _formSetps() {
    List<Step> _steps = [
      //=== Step1 Victim information
      Step(
        title: Text('Victim Information'),
        content: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Wrap(
                children: [
                  Text('Names'),
                  TextField(
                    controller: Namescontroller,
                    decoration: InputDecoration(
                      hintText: 'Enter full name here',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),

              Wrap(
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  //Victim sex
                  Text('Victim Sexe'),
                  RadioListTile(
                    title: Text('Male'),
                    value: 'Male',
                    groupValue: victimeSex,
                    selected: victimeSex == 'Male',
                    controlAffinity: ListTileControlAffinity.platform,
                    onChanged: (value) {
                      setState(() {
                        victimeSex = value;
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text('Female'),
                    value: 'Female',
                    selected: victimeSex == 'Female',
                    groupValue: victimeSex,
                    controlAffinity: ListTileControlAffinity.platform,
                    onChanged: (value) {
                      setState(() {
                        victimeSex = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: 12,
                  )
                ],
              ),
              SizedBox(
                height: 16,
              ),
              //======= age ======
              Wrap(
                children: [
                  Text('Age'),
                  TextField(

                    onChanged: (value) {
                      age = value;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter age here',
                    ),
                    keyboardType: TextInputType.number,
                  )
                ],
              ),
              SizedBox(
                height: 16,
              ),

              //======= ID ======
              Wrap(
                children: [
                  Text('ID Number'),
                  TextField(
                    onChanged: (value) {
                      idNumber = value;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter ID Number',
                    ),
                    keyboardType: TextInputType.number,
                  )
                ],
              ),
              SizedBox(
                height: 16,
              ),

              //========== disability ========
              CheckboxListTile(
                title: Text('Has Disability'),
                value: hasDisability,
                selected: hasDisability,
                onChanged: (val) {
                  setState(() {
                    hasDisability = val;
                    print(val);
                  });
                },
              ),
              Wrap(
                children: [
                  hasDisability
                      ? Wrap(
                          children: [
                            Text('Disability Description'),
                            TextField(
                              onChanged: (value) {
                                disabilityDescription = value;
                              },
                              maxLines: 3,
                              decoration: InputDecoration(
                                hintText: 'Enter Disability details here',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ],
                        )
                      : SizedBox(
                          height: 0,
                        )
                ],
              ),
              SizedBox(
                height: 16,
              ),

              //====== telephone =====
              Wrap(
                children: [
                  Text('Telephone'),
                  TextField(
                    onChanged: (value) {
                      telephone = value;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter phone here',
                    ),
                    keyboardType: TextInputType.phone,
                  )
                ],
              ),
              SizedBox(
                height: 16,
              ),

              //====== email ===========
              Wrap(
                children: [
                  Text('Email'),
                  TextField(
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter email here',
                    ),
                    keyboardType: TextInputType.emailAddress,
                  )
                ],
              ),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
        isActive: _currentStep >= 0,
      ),

      //=== Step2 Victim address
      Step(
        title: Text('Victim Address'),
        content: Column(
          children: [
            //province
            Wrap(
              children: [
                Container(
                  width: double.infinity,
                  child: Text('Victim Province'),
                ),
                Container(
                  width: double.infinity,
                  child: DropdownButton<String>(
                    isExpanded: true,
                    items: data.map((item) {
                      return new DropdownMenuItem(
                        child: new Text(item['name']),
                        value: item['id'].toString(),
                      );
                    }).toList(),

                    onChanged: (newVal) {
                      setState(() {
                        Province = newVal;
                        DistrictData(Province);
                      });
                    },
                    value: Province,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),

            //district
            Wrap(
              children: [
                Container(
                  width: double.infinity,
                  child: Text('Victim Distict'),
                ),
                Container(
                  width: double.infinity,
                  child: DropdownButton(
                    isExpanded: true,
                    items: Districtdata.map((item) {
                      return new DropdownMenuItem(
                        child: new Text(item['name']),
                        value: item['id'].toString(),
                      );
                    }).toList(),
                    onChanged: (newVal) {
                      setState(() {
                        District = newVal;
                        print(District);
                        SectorData(District);
                      });
                    },
                    value: District,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 16,
            ),

            //sector
            Wrap(
              children: [
                Container(
                  width: double.infinity,
                  child: Text('Victim Sector'),
                ),
                Container(
                  width: double.infinity,
                  child: DropdownButton(
                    isExpanded: true,
                    items: Sectorsdata.map((item) {
                      return new DropdownMenuItem(
                        child: new Text(item['name']),
                        value: item['id'].toString(),
                      );
                    }).toList(),
                    onChanged: (newVal) {
                      setState(() {
                        Sectors = newVal;
                        print(Sectors);
                      });
                    },
                    value: Sectors,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 16,
            ),

            //cell
            Wrap(
              children: [
                Text('Victim\'s cell'),
                TextField(
                  controller: Victimecellcontroller,
                  onChanged: (value) {
                    Victimcell = value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Victim\'s cell',
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),

            //Village
            Wrap(
              children: [
                Text('Victim\'s village'),
                TextField(
                controller: Victimevillagecontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Victim\'s village',
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
          ],
        ),
        isActive: _currentStep >= 1,
      ),

      //=== Step3 Violence Information
      Step(
        title: Text('Violence case information'),
        content: Column(
          children: [
            //==== violence type =======
            Wrap(
              children: [
                Container(
                  width: double.infinity,
                  child: Text('Type of Violence'),
                ),
                Container(
                  width: double.infinity,
                  child: DropdownButton(
                    isExpanded: true,
                    onChanged: (val) {
                      setState(() {
                        violenceType = val;
                        print(violenceType);
                      });
                    },
                    items: [
                      DropdownMenuItem(
                        child: Text(violenceType),
                      ),
                      DropdownMenuItem(
                        child: Text('Physical'),
                        value: 'Physical',
                      ),
                      DropdownMenuItem(
                        child: Text('Psychological'),
                        value: 'Psychological',
                      ),
                      DropdownMenuItem(
                        child: Text('Sexual'),
                        value: 'Sexual',
                      ),
                      DropdownMenuItem(
                        child: Text('Property'),
                        value: 'Property',
                      ),
                      DropdownMenuItem(
                        child: Text('Teen Pregnancy'),
                        value: 'Teen Pregnancy',
                      ),
                      DropdownMenuItem(
                        child: Text('Child Abuse'),
                        value: 'Child Abuse',
                      ),
                      DropdownMenuItem(
                        child: Text('Other'),
                        value: 'Other',
                      ),
                    ],
                  ),
                ),

                    Container(
                      width: double.infinity,
                      child: Text('Victim Group'),
                    ),
                    Container(
                      width: double.infinity,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        items: dataGroup.map((item) {
                          return new DropdownMenuItem(
                            child: new Text(item['name']),
                            value: item['id'].toString(),
                          );
                        }).toList(),

                        onChanged: (newVal) {
                          setState(() {
                            Group = newVal;
//                            DistrictData(Group);
                          });
                        },
                        value: Group,
                      ),
                    ),



              ],
            ),
            SizedBox(
              height: 16,
            ),

            //==== number of times =====
            Wrap(
              children: [
                Text('Number of times'),
                TextField(
                  onChanged: (value) {
                    numberOfTimes = value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Number of times',
                  ),
                  keyboardType: TextInputType.number,
                )
              ],
            ),
            SizedBox(
              height: 16,
            ),

            //====== violence description ======
            Wrap(
              children: [
                Text('Violence Description'),
                TextField(
                  onChanged: (value) {
                    violenceDescription = value;
                  },
                  maxLines: 2,
                  decoration: InputDecoration(
                    hintText: 'Enter Description details here',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
          ],
        ),
        isActive: _currentStep >= 2,
      ),

      //=== Step4 Perpetrator information
      Step(
        title: Text('Perpetrator Information'),
        content: Column(
          children: [
            Wrap(
              children: [
                SizedBox(
                  height: 16,
                ),
                //Perpetrator sex
                Text('Perpetrator Sexe'),
                RadioListTile(
                  title: Text('Male'),
                  value: 'Male',
                  groupValue: perpetratorSex,
                  selected: perpetratorSex == 'Male',
                  controlAffinity: ListTileControlAffinity.platform,
                  onChanged: (value) {
                    setState(() {
                      perpetratorSex = value;
                    });
                  },
                ),
                RadioListTile(
                  title: Text('Female'),
                  value: 'Female',
                  selected: perpetratorSex == 'Female',
                  groupValue: perpetratorSex,
                  controlAffinity: ListTileControlAffinity.platform,
                  onChanged: (value) {
                    setState(() {
                      perpetratorSex = value;
                    });
                  },
                ),
                SizedBox(
                  height: 12,
                )
              ],
            ),
            SizedBox(
              height: 16,
            ),

            Wrap(
              children: [
                Container(
                  width: double.infinity,
                  child: Text('Age Interval'),
                ),
                Container(
                  width: double.infinity,
                  child: DropdownButton(
                    isExpanded: true,
                    onChanged: (val) {
                      setState(() {
                        ageInterval = val;
                        print(ageInterval);
                      });
                    },
                    items: [
                      DropdownMenuItem(
                        child: Text(ageInterval),
                      ),
                      DropdownMenuItem(
                        child: Text('14-24'),
                        value: '14-24',
                      ),
                      DropdownMenuItem(
                        child: Text('25-34'),
                        value: '25-34',
                      ),
                      DropdownMenuItem(
                        child: Text('35-60'),
                        value: '35-60',
                      ),
                      DropdownMenuItem(
                        child: Text('Over 60'),
                        value: 'Over 60',
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 16,
            ),

//            Wrap(
//              children:[
//                Text('Report'),
//                CheckboxListTile(
//                  title: Text('Forward my case to RIB/Police Directly'),
//                  selected: forwardToPolice,
//                  onChanged: (value){
//                    setState(() {
//                      forwardToPolice = value;
//                    });
//                  },
//                  value: forwardToPolice,
//                ),
//              ]
//            ),
            SizedBox(height: 16,)
          ],
        ),
        isActive: _currentStep >= 3,
      ),

      //==== Step5 Perpetrator address
      Step(
        title: Text('Perpetrator address'),
        content: Column(
          children: [
            //province
            Wrap(
              children: [
                Container(
                  width: double.infinity,
                  child: Text('Perpetrator Province'),
                ),
                Container(
                  width: double.infinity,
                  child: DropdownButton<String>(
                    isExpanded: true,
                    items: Pdata.map((item) {
                      return new DropdownMenuItem(
                        child: new Text(item['name']),
                        value: item['id'].toString(),
                      );
                    }).toList(),
                    onChanged: (newVal) {
                      setState(() {
                        ProvinceP = newVal;
                        DistrictDataP(ProvinceP);
                      });
                    },
                    value: ProvinceP,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),

            //district
            Wrap(
              children: [
                Container(
                  width: double.infinity,
                  child: Text('Perpetrator Distict'),
                ),
                Container(
                  width: double.infinity,
                  child: DropdownButton(
                    isExpanded: true,
                    items: PDistrictdata.map((item) {
                      return new DropdownMenuItem(
                        child: new Text(item['name']),
                        value: item['id'].toString(),
                      );
                    }).toList(),
                    onChanged: (newVal) {
                      setState(() {
                        DistrictP = newVal;
                        print(DistrictP);
                        SectorDataP(DistrictP);
                      });
                    },
                    value: DistrictP,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 16,
            ),

            //sector
            Wrap(
              children: [
                Container(
                  width: double.infinity,
                  child: Text('Perpetrator Sector'),
                ),
                Container(
                  width: double.infinity,
                  child: DropdownButton(
                    isExpanded: true,
                    items: PSectorsdata.map((item) {
                      return new DropdownMenuItem(
                        child: new Text(item['name']),
                        value: item['id'].toString(),
                      );
                    }).toList(),
                    onChanged: (newVal) {
                      setState(() {
                        SectorsP = newVal;
                        print(SectorsP);
                      });
                    },
                    value: SectorsP,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 16,
            ),

            //cell
            Wrap(
              children: [
                Text('Perpetrator\'s cell'),
                TextField(
                  controller: perpetratorcellcontroller,
                  onChanged: (val) {},
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Perpetrator\'s cell',
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),

            //Village
            Wrap(
              children: [
                Text('Perpetrator\'s village'),
                TextField(
                  controller: perpetratorvillagecontroller,
                  onChanged: (val) {

                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Perpetrator\'s village',
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
          ],
        ),
        isActive: _currentStep >= 4,
      ),
    ];

    return _steps;
  }
}

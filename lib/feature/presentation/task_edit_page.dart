import 'package:flutter/material.dart';

class TaskEditPage extends StatefulWidget {
  const TaskEditPage({super.key});

  @override
  State<TaskEditPage> createState() => _TaskEditPageState();
}

class _TaskEditPageState extends State<TaskEditPage> {
  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        child: Center(
          child: Text("This is Edit Page")
        )
      )
    );
  }
}

/*

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:temurejeki/Functions/StringFunctions.dart';

import '../components/StaticWidgets.dart';
import '../components/Button.dart';
import '../components/InputField.dart';
import '../constants/Styles.dart';
import '../constants/ThemeColors.dart';
import '../models/Lists.dart';
import '../models/RequestData.dart';
import '../models/ResponseData.dart';
import '../models/Client.dart';
import '../models/User.dart';
import '../providers/ApiClient.dart';

class ClientEditPage extends StatefulWidget {
  final String token;
  final User userData;
  final int clientId;
  final Size size;
  const ClientEditPage({
    Key? key,
    required this.token,
    required this.userData,
    required this.clientId,
    required this.size,
  }) : super(key: key);

  @override
  _ClientEditPageState createState() => _ClientEditPageState();
}

class _ClientEditPageState extends State<ClientEditPage> {
  ScrollController controller = ScrollController();

  TextEditingController nameController= TextEditingController();
  TextEditingController phoneController= TextEditingController();
  TextEditingController companyController= TextEditingController();
  TextEditingController addressController= TextEditingController();
  TextEditingController zipController= TextEditingController();
  TextEditingController phoneNumbController= TextEditingController();
  TextEditingController positionController= TextEditingController();
  TextEditingController nipController= TextEditingController();
  TextEditingController provinceController= TextEditingController();
  TextEditingController regencyController= TextEditingController();

  FocusNode nameNode= FocusNode();
  FocusNode phoneNode= FocusNode();
  FocusNode companyNode= FocusNode();
  FocusNode addressNode= FocusNode();
  FocusNode zipNode= FocusNode();
  FocusNode phoneNumbNode= FocusNode();
  FocusNode positionNode= FocusNode();
  FocusNode nipNode= FocusNode();
  FocusNode provinceNode= FocusNode();
  FocusNode regencyNode= FocusNode();

  List<TextInputType> inputTypes= [
    TextInputType.text,
    TextInputType.number,
    TextInputType.text,
    TextInputType.text,
    TextInputType.number,
    TextInputType.number,
    TextInputType.text,
    TextInputType.number,
    TextInputType.text,
    TextInputType.text
  ];

  List<TextEditingController> controllerList= [];
  List<FocusNode> nodeList= [];

  bool updateIsLoading= false;
  bool deleteIsLoading= false;
  bool dataIsLoading= false;
  bool isChoosingProvince= false;
  bool isChoosingRegency= false;

  double bottomMargin= 0;
  int? marketingId;
  int searchParameter= 0;
  int provinceId= 1;
  int regencyId= 1;

  String province= "";
  String regency= "";
  String searchText= "";

  Map<String, Lists> regionList= {
    "Provinsi": Lists(),
    "Kabupaten": Lists()
  };

  @override
  void initState() {
    getClientDetail(widget.size);
    addListenerToNode(phoneNumbNode, 0);
    addListenerToNode(positionNode, 1);
    addListenerToNode(nipNode, 2);
    setState(() {
      controllerList= [
        nameController,
        phoneController,
        companyController,
        addressController,
        zipController,
        phoneNumbController,
        positionController,
        nipController,
        provinceController,   //step A5
        regencyController
      ];
      nodeList= [
        nameNode,
        phoneNode,
        companyNode,
        addressNode,
        zipNode,
        phoneNumbNode,
        positionNode,
        nipNode,
        provinceNode,
        regencyNode
      ];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("rebuild with provinceId= $provinceId");
    var size= MediaQuery.of(context).size;
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          body: SizedBox(
            height: size.height,
            width: size.width,
            child: Stack(
              children: [
                getBody(size),
                chooseRegion(size, "Provinsi", isChoosingProvince), //step A2
                chooseRegion(size, "Kabupaten", isChoosingRegency),
                StaticWidgets().loadingWidget(size, dataIsLoading),
              ],
            )
          ),
        )
    );
  }

  Widget getBody(var size) {
    return SizedBox(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          controller: controller,
          child: SizedBox(
            width: size.width,
            height: 905 + bottomMargin,
            child: Stack(
                children: [
                  Positioned(
                      top: 0,
                      left: 0,
                      child: StaticWidgets().getOverlayElement(size)
                  ),
                  SizedBox(
                      width: size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(top: 40, right: size.width- 50- 18),
                              child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    splashColor: const Color.fromRGBO(242, 233, 48, 0.5),
                                    highlightColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    child: Container(
                                        height: 40,
                                        width: 50,
                                        padding: const EdgeInsets.only(left: 6),
                                        child: const Align(
                                            alignment: Alignment.centerLeft,
                                            child: Icon(Icons.arrow_back, color: Colors.white, size: 25)
                                        )
                                    ),
                                  )
                              )
                          ),
                          Container(
                              height: 50,
                              width: size.width- 40,
                              margin: const EdgeInsets.only(bottom: 10),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Detail Client",
                                  style: Styles().getStyle(18, true, Colors.white),
                                ),

                              )
                          ),
                        ] + inputColumn(size, widget.token),
                      )
                  ),
                ]
            )
          )
        )
    );
  }

  List<Widget> inputColumn(var size, String token) {
    List<Widget> inputColumn= [
      getInputField(size, 0, "Nama", 0),
      getInputField(size, 1, "Handphone", 0),
      getInputField(size, 2, "Perusahaan / Instansi", 0),
      getInputField(size, 3, "Alamat", 0),
      getInputField(size, 4, "Kode Pos", 0),
      getInputField(size, 5, "Nomer Telepon", 0),
      getInputField(size, -1, "Provinsi", 0),
      getInputField(size, -2, "Kota", 0),
      getInputField(size, 6, "Jabatan", 0),
      getInputField(size, 7, "Nip (jika ada)", 0),
      Button(
          onTapFunction: submitFunction,
          string: "Update",
          isLoading: updateIsLoading,
          color: ThemeColors().color0,
          data: Client()
      ),
      const SizedBox(height: 7),
      Button(
          onTapFunction: deleteFunction,
          string: "Hapus",
          isLoading: deleteIsLoading,
          color: Colors.deepOrange,
          data: Client()
      ),
    ];
    return inputColumn;
  }

  Widget getInputField(var size, int index, String title, double width) {
    return Container(
      height: 45,
      width: width==0 ? min(size.width- 40, 400): width,
      margin: const EdgeInsets.only(bottom: 18),
      padding: EdgeInsets.only(left: index>=0? 10 : 0, right: index>=0? 5 : 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: const Color.fromRGBO(235, 235, 240, 1),
      ),
      child: index>=0? Align(
        alignment: Alignment.centerLeft,
        child: SizedBox(
          height: 28,
          width: size.width- 30- 36- 20,
          child: InputField(
            controller: controllerList[index],  //step A6
            node: nodeList[index],
            index: 2,
            string: title,
            obscure: false,
            textInputType: inputTypes[index],
            onSubmitFunction: () {
              if(index< 7 && index!=5) {
                FocusScope.of(context).requestFocus(nodeList[index+ 1]);
              } else {
                FocusScope.of(context).requestFocus(FocusNode());
                setState(() {
                  isChoosingProvince= true;
                });
                initiateAutoSearch(provinceController, "province"); //step B1
              }
            },
          ),
        ),
      ) : Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(5),
        child: InkWell(
          onTap: () {
            if(index==-1) {
              setState(() {
                isChoosingProvince= true;  //step A1
                isChoosingRegency= false;
              });
              initiateAutoSearch(provinceController, "province"); //step B1
            } else {
              setState(() {
                isChoosingRegency= true;
                isChoosingProvince= false;
              });
            }
          },
          child: Container(
            height: 45,
            width: min(size.width- 40, 400),
            padding: const EdgeInsets.only(left: 10, right: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title=="Provinsi"? province : regency
              )
            )
          )
        )
      ),
    );
  }

  Widget menuText(var size, String string, Color color) {
    return SizedBox(
        height: 28,
        width: size.width- 40- 45- 15- 3,
        child: SizedBox(
            height: size.width- 40- 40,
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    string,
                    style: Styles().getStyle(15, false, color)
                )
            )
        )
    );
  }

  Widget getClickableIcon(IconData icon) {
    return Container(
        color: Colors.transparent,
        height: 45,
        width: 45,
        padding: const EdgeInsets.only(right: 5),
        child: Align(
            alignment: Alignment.centerRight,
            child: Icon(
                icon,
                color: Colors.black, size: 20
            )
        )
    );
  }

  Widget chooseRegion(var size, String title, bool isChoosing) {
    return isChoosing? GestureDetector( //step A3
      onTap: () {
        setState(() {
          isChoosingProvince= false;
          isChoosingRegency= false;
        });
      },
      child: Container(
          height: size.height,
          width: size.width,
          color: Colors.black12,
          child: Center(
              child: Container(
                  height: min(size.width+ 100+ 45, size.height- 36),
                  width: min(size.width- 60, size.height-36),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 10),
                        child: getInputField(
                            size,
                            title=="Provinsi"? 8 : 9,   //step A4
                            "Cari $title",
                            min(size.width- 70, size.height-56)
                        ),
                      ),
                      getRegionListWidget(size, title, min(size.width- 50, size.height-36))
                    ],
                  )
              )
          )
      )
    ) : const SizedBox(height: 0);
  }

  Widget getRegionListWidget(var size, String title, double width) {
    return SizedBox(
      height: min(size.width+ 80- 23, size.height- 56- 23),
      width: width,
      child: SingleChildScrollView(
        child: Column(
          children: getRegions(title, width),
        )
      )
    );
  }

  List<Widget> getRegions(String title, double width) {
    List<Widget> regions= [];
    int numberOfRegions= regionList[title]!.stringList.length;
    for(int i=0; i< numberOfRegions; i++) {
      regions.add(
        SizedBox(
          height: 40,
          width: width,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.black12,
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async{
                String currentRegion= regionList[title]!.stringList[i]??"";
                int currentRegionId= regionList[title]!.idList[i]??1;
                setState(() {
                  if(title=="Provinsi") {
                    province= currentRegion;
                    provinceId= currentRegionId;
                  } else {
                    regency= currentRegion;
                    regencyId= currentRegionId;
                  }
                  isChoosingProvince= false;
                  isChoosingRegency= false;
                });
                if(title=="Provinsi") {
                  RequestData localReq= RequestData(
                      widget.token, "0", 0,
                      regencyController.text, 1, ""
                  );
                  localReq.setAdditionalSubQuery("province/regency/$currentRegionId");
                  Lists data= await ApiClient().getRegionList(localReq);
                  setState(() {
                    regionList['Kabupaten']= data;
                    regency= regionList['Kabupaten']!.stringList.first??"Tidak Ada Kabupaten";
                  });
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: SizedBox(
                    height: 40,
                    width: width,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            regionList[title]!.stringList[i]??"",
                            style: Styles().getStyle(15, false, Colors.black)
                        )
                    )
                )
              )
            )
          )
        )
      );
      regions.add(
        Container(
          height: i< numberOfRegions-1? 1 : 0,
          width: width+ 30,
          color: Colors.black26,
        )
      );
    }
    return regions;
  }

  void addListenerToNode(FocusNode node, int index) {
    node.addListener(() async{
      if(node.hasFocus) {
        await Future.delayed(const Duration(milliseconds: 300));
        var bottomInsets= MediaQuery.of(context).viewInsets.bottom;
        if(index>0) {
          setState(() {
            bottomMargin= max(bottomInsets- 210+ index*70, 0);
          });
        }
        controller.animateTo(
            905 + bottomMargin- widget.size.height,
            duration: const Duration(milliseconds: 200),
            curve: Curves.bounceIn
        );
        while(bottomMargin!=0) {
          if(bottomInsets==0) {
            setState(() {
              bottomMargin=0;
            });
            FocusScope.of(context).requestFocus(FocusNode());
          } else {
            await Future.delayed(const Duration(milliseconds: 500));
          }
          bottomInsets= MediaQuery.of(context).viewInsets.bottom;
        }
      }
    });
  }

  Future<void> submitFunction(var size) async{
    if(!updateIsLoading) {
      setState(() {
        updateIsLoading= true;
      });
      RequestData req= RequestData(
          widget.token, "0", 0, "",
          widget.clientId,
          ""
      );
      Client data= Client();
      int altProvId= StringFunction().getIdFromString(
        regionList['Provinsi']!,
        province
      );
      int altCityId= StringFunction().getIdFromString(
        regionList['Kabupaten']!,
        regency
      );
      data.setDetailData({
        "name": nameController.text,
        "hp": phoneController.text,
        "company": companyController.text,
        "address": addressController.text,
        "phone": phoneNumbController.text,
        "id_province": provinceId!=-1? provinceId : altProvId,
        "id_city": regencyId!=-1? regencyId : altCityId,
        "zip_code": zipController.text,
        "jabatan": positionController.text,
        "nip": nipController.text,
        "type": 2,
        "id_marketing": marketingId??1
      });
      req.setRole(widget.userData.role??5);
      req.setAdditionalSubQuery("client/${widget.clientId}");
      req.setClientData(data);
      ResponseData response= await ApiClient().modifyClient(req);
      // ignore: use_build_context_synchronously
      StaticWidgets().getFloatingSnackBar(
        size,
        response.message??(response.error??"Terdapat Kesalahan"),
        context
      );
      if("${response.message}%no-message".substring(0, 8)=="Berhasil") {
        // ignore: use_build_context_synchronously
        Navigator.pop(context, true);
      }
      setState(() {
        updateIsLoading= false;
      });
    }
  }

  Future<void> deleteFunction(var size) async{
    if(!deleteIsLoading) {
      setState(() {
        deleteIsLoading= true;
      });
      RequestData req= RequestData(
          widget.token, "0", 0, "",
          widget.clientId,
          ""
      );
      req.setRole(widget.userData.role??5);
      req.setAdditionalSubQuery("client/${widget.clientId}");
      req.setRequestType(1);
      ResponseData data= await ApiClient().modifyClient(req);
      // ignore: use_build_context_synchronously
      StaticWidgets().getFloatingSnackBar(
        size,
        data.message??(data.error??"Terdapat Kesalahan"),
        context
      );
      if(("${data.message}%no-message").substring(0, 8)=="Berhasil") {
        // ignore: use_build_context_synchronously
        Navigator.pop(context, true);
      }
      setState(() {
        deleteIsLoading= false;
      });
    }
  }

  Future<void> getClientDetail(var size) async{
    if(!dataIsLoading) {
      setState(() {
        dataIsLoading= true;
      });
      RequestData req= RequestData(
          widget.token, "0", 0, "",
          widget.clientId,
          ""
      );
      req.setRole(widget.userData.role??5);
      req.setAdditionalSubQuery("client/${widget.clientId}");
      Client data= await ApiClient().getClientDetail(req);
      setState(() {
        nameController.text= data.names.first??"";
        phoneController.text= data.phoneNumbers.first??"";
        companyController.text= data.companies.first??"";
        addressController.text= data.address.first??"";
        zipController.text= data.zipCode??"";
        phoneNumbController.text= data.phone??"";
        positionController.text= data.position??"";
        nipController.text= data.nip??"";
        marketingId= data.marketingId??1;
        province= data.province??"";
        regency= data.city??"";
        provinceId= data.provinceId??11;
        regencyId= data.cityId??11;
        dataIsLoading= false;
      });
      RequestData provReq= RequestData(widget.token, "0", 0, "", 1, "");
      provReq.setAdditionalSubQuery("province");
      Lists localProvinceList= await ApiClient().getRegionList(provReq);
      RequestData regReq= RequestData(widget.token, "0", 0, "", 1, "");
      regReq.setAdditionalSubQuery("province/regency/${data.provinceId}");
      debugPrint("query is set to province/regency/${data.provinceId}");
      Lists localRegencyList= await ApiClient().getRegionList(regReq);
      setState(() {
        regionList= {
          "Provinsi": localProvinceList,
          "Kabupaten": localRegencyList
        };
      });
    }
  }

  Future<void> initiateAutoSearch(TextEditingController controller, String query) async {
    int doneSearchingParameter= -1;
    bool condition1= isChoosingProvince && query=="province";
    bool condition2= isChoosingRegency && query!="province";
    String currentText="";
    while (condition1 || condition2) {
      await Future.delayed(const Duration(milliseconds: 1000));
      // ignore: use_build_context_synchronously
      RequestData localReq= RequestData(
          widget.token, "0", 0,
          query=="province"
              ? provinceController.text
              : regencyController.text,
          1, ""
      );
      currentText= controller.text;
      if (searchText == currentText && (currentText.length> 2 || currentText=="")) {  //step B2
        if (doneSearchingParameter != searchParameter) {
          localReq.setAdditionalSubQuery(query);
          Lists data= await ApiClient().getRegionList(localReq);
          doneSearchingParameter = searchParameter;
          if(query=="province") {
            setState(() {
              regionList['Provinsi']= data;
            });
          } else {
            setState(() {
              regionList['Kabupaten']= data;
            });
          }
        }
      } else {
        setState(() {
          searchText = controller.text;
          doneSearchingParameter= -1;
        });
      }
    }
  }

}

*/
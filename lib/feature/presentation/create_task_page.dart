import 'dart:math';

import 'package:flutter/material.dart';
import 'package:todoapp_mobile/feature/presentation/constants/constants.dart';
import 'package:todoapp_mobile/feature/presentation/constants/priority.dart';
import 'package:todoapp_mobile/feature/presentation/helpers/text_styles.dart';
import 'package:todoapp_mobile/feature/presentation/widget/input_field.dart';


class ClientEditPage extends StatefulWidget {

  @override
  _ClientEditPageState createState() => _ClientEditPageState();
}

class _ClientEditPageState extends State<ClientEditPage> {
  ScrollController controller = ScrollController();

  TextEditingController titleController= TextEditingController();
  TextEditingController deadlineController= TextEditingController();
  TextEditingController priorityController= TextEditingController();

  FocusNode titleNode= FocusNode();

  List<TextEditingController> controllerList= [];

  bool updateIsLoading= false;
  bool deleteIsLoading= false;
  bool dataIsLoading= false;
  bool isChoosingPriority= false;

  double bottomMargin= 0;

  Priority priority= Priority();

  @override
  void initState() {
    addListenerToNode(titleNode, 0);
    setState(() {
      controllerList= [
        titleController,
        priorityController,
        deadlineController,
      ];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                choosePriority(size), //step A2
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
            height: 400,
            child: Stack(
                children: [
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
                                    splashColor: Colors.black12,
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
                                  "Detail Task",
                                  style: TextStyles().getStyle(4),
                                ),

                              )
                          ),
                        ] + inputColumn(size),
                      )
                  ),
                ]
            )
          )
        )
    );
  }

  List<Widget> inputColumn(var size) {
    List<Widget> inputColumn= [
      getInputField(size),
      getDatePicker(size),
      getDropdown(size),
      FloatingActionButton(
        onPressed: () {submitFunction("input");},
        child: Text("Submit", style: TextStyles().getStyle(2))
      )
    ];
    return inputColumn;
  }

  Widget getInputField(var size) {
    return Container(
      height: 40,
      width: size.width- 40,
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 4),
            blurRadius: 3,
            spreadRadius: 3
          )
        ]
      ),
      child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Container(
                  color: Colors.transparent,
                  height: 45,
                  width: 35,
                  child: const Center(
                      child: Icon(
                          Icons.task_alt_outlined,
                          color: Colors.black12,
                          size: 20
                      )
                  )
              ),
              SizedBox(
                height: 28,
                width: size.width- 157,
                child: InputField(
                  controller: titleController,
                  node: titleNode,
                  string: "Task Title",
                  obscure: false,
                  textInputType: TextInputType.text,
                  onSubmitFunction: () {
                    
                  },
                  onTextIsEmptyFunction: () {},
                  onTextIsNotEmptyFunction: () {},
                ),
              ),
            ],
          )
      ),
    );
  }

  Widget choosePriority(var size) {
    return isChoosingPriority? GestureDetector( //step A3
      onTap: () {
        setState(() {
          isChoosingPriority= false;
        });
      },
      child: Container(
          height: size.height,
          width: size.width- 40,
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
                      getPriorityListWidget(size)
                    ],
                  )
              )
          )
      )
    ) : const SizedBox(height: 0);
  }

  Widget getPriorityListWidget(var size) {
    return SizedBox(
      height: min(size.width+ 80- 23, size.height- 56- 23),
      width: size.width- 100,
      child: SingleChildScrollView(
        child: Column(
          children: getPriorityList(size),
        )
      )
    );
  }

  List<Widget> getPriorityList(var size) {
    List<Widget> list= [];
    int numberOfRegions= Constants().priorityList.length;
    for(int i=0; i< numberOfRegions; i++) {
      list.add(
        SizedBox(
          height: 40,
          width: size.width- 100,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.black12,
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async{
                setState(() {
                  priority= 
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
        "title": titleController.text,
        "hp": priorityController.text,
        "company": deadlineController.text,
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
        titleController.text= data.titles.first??"";
        priorityController.text= data.phoneNumbers.first??"";
        deadlineController.text= data.companies.first??"";
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
              ? priorityController.text
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
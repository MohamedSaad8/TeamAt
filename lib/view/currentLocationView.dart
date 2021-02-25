import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:team_at/widget/CustomButton.dart';
import 'package:team_at/widget/custom_text.dart';
import 'package:get/get.dart';
class CurrentLocationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
            color: Colors.black
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              Container(
                width: size.width,
                height: size.height * 0.3,
                child: Image.asset("assets/images/location.png" ,
                width: size.width /2,
                height: size.width/2,),

              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: size.height *0.2,
                width: size.width,
                child: Column(
                  children: [
                    CustomText(
                      text: "Set your location so you can see the neighboring groups".tr,
                      fontWeight: FontWeight.bold,
                      fontColor: Colors.black,
                      fontSize: 20,
                      textAlignment: Alignment.topLeft,
                    ),
                    SizedBox(height: size.height * 0.02,),
                    CustomText(
                      text: "needs your authorization to locate your position".tr,
                      fontColor: Colors.black,
                      fontSize: 15,
                      textAlignment: Alignment.topLeft,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: size.height *0.08,
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: InkWell(
                          child: Icon(
                            Icons.location_on_outlined,
                            color: Colors.grey.shade700,
                            size: 30,
                          ),
                        ),
                      ),
                      SizedBox(width:  10,),
                      CustomText(
                        text: "Set your location".tr,
                        fontColor: Colors.grey.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.05,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomButton(
                  buttonHeight: size.height *0.08,
                  buttonWidth: size.width,
                  text: "continue".tr,
                  onClick: (){

                  },
                  buttonRadius: 15.0,
                ),
              ),
              SizedBox(height: size.height * 0.1,)


            ],
          ) ,
        ),
      ),

    );
  }
}

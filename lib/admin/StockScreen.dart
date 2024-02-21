import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:machine_test/constants/colors.dart';
import 'package:machine_test/widgets/AppText.dart';
import 'package:machine_test/widgets/customButton.dart';

class StockScreen extends StatefulWidget {
  String req_id;
  String product;
  String price;
  String description;
  String stock;
  String image1;
String image2;
String image3;
  StockScreen(
      {super.key,
      required this.req_id,
      required this.product,
      required this.price,
      required this.description,
      required this.stock,
      required this.image1,
      required this.image2,
      required this.image3});

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
 

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.only(left: 20).r,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: customBalck,
                ),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30).r,
            child: Center(
              child: Container(
                height: 650.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15).r,
                  color: maincolor,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 30, right: 30, top: 25).r,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Image.network(
                          "${widget.image1}",
                          fit: BoxFit.fill,
                        ),
                        height: 100,
                        width: 100,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 400.h,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 60,
                                  bottom: 50,
                                  right: 5,
                                ).r,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: const AppText(
                                        text: "Product",
                                        weight: FontWeight.w400,
                                        size: 14,
                                        textcolor: customBalck,
                                      ),
                                    ),
                                   
                                    Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: const AppText(
                                        text: "Price",
                                        weight: FontWeight.w400,
                                        size: 14,
                                        textcolor: customBalck,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: const AppText(
                                        text: "Stock",
                                        weight: FontWeight.w400,
                                        size: 14,
                                        textcolor: customBalck,
                                      ),
                                    ),
                                    // Padding(
                                    //   padding: const EdgeInsets.only(top: 50, right: 10).r,
                                    //   child: SizedBox(width: 20),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 400.h,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 60, bottom: 50)
                                        .r,
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: AppText(
                                        text: ": ${widget.product}",
                                        weight: FontWeight.w500,
                                        size: 14,
                                        textcolor: customBalck,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: AppText(
                                        text: ": ${widget.description}",
                                        weight: FontWeight.w400,
                                        size: 12,
                                        textcolor: customBalck,
                                      ),
                                    ),
                                   
                                    Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: AppText(
                                        text: ": ${widget.stock}",
                                        weight: FontWeight.w400,
                                        size: 12,
                                        textcolor: customBalck,
                                      ),
                                    ),
                                    // Padding(
                                    //   padding: const EdgeInsets.only(left: 10, top: 50).r,
                                    //   child: getButton(),
                                    // ),
                                               
                         
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Center(child: Text('Other Images')),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Image.network(widget.image3,
                                          fit: BoxFit.cover),
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                    color: Colors
                                        .black, // Specify the border color here
                                    width: 1,
                                  ) // Specify the border width here
                                      ),
                                ),
                              ),
                                             Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Image.network(widget.image2,
                                      fit: BoxFit.cover),
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                color: Colors
                                    .black, // Specify the border color here
                                width: 1,
                              ) // Specify the border width here
                                  ),
                            ),
                          ),
                            ],
                          )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        
      ],
    );
  }
}

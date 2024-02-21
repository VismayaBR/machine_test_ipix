import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:machine_test/constants/colors.dart';

import 'apptext.dart';

class StockTile extends StatelessWidget {
  const StockTile({
    super.key,
    required this.image,
    required this.name,
    required this.issue,
    required this.date,
    required this.time,
    required this.place, required this.click,
  });

  final String image;
  final String name;
  final String issue;
  final String date;
  final String time;
  final String place;
  final void Function() click;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10).r,
      child: InkWell(
        onTap: click,
        child: Container(
          height: 120.h,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15).r, color: maincolor),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20).r,
            child: Row(children: [
              SizedBox(
                width: 100.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      image,
                      width: 60.w,
                      height: 60.h,
                      fit: BoxFit.fill,
                    ),
                    AppText(
                        text: name,
                        weight: FontWeight.w400,
                        size: 14,
                        textcolor: customBalck),
                  ],
                ),
              ),
              Expanded(
                child: SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppText(
                          text: issue,
                          weight: FontWeight.w400,
                          size: 14,
                          textcolor: customBalck),
                      AppText(
                          text: date,
                          weight: FontWeight.w400,
                          size: 14,
                          textcolor: customBalck),
                      AppText(
                          text: time,
                          weight: FontWeight.w400,
                          size: 14,
                          textcolor: customBalck),
                      AppText(
                          text: place,
                          weight: FontWeight.w400,
                          size: 14,
                          textcolor: customBalck),
                    ],
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}

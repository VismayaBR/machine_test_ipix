import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:machine_test/constants/colors.dart';

import 'apptext.dart';

class StockTile extends StatelessWidget {
  const StockTile({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.stock,
    required this.category,
     required this.click,
  });

  final String image;
  final String name;
  final String price;
  final String stock;
  final String category;
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
                    Image.network(
                      image,
                      width: 60.w,
                      height: 60.h,
                      fit: BoxFit.fill,
                    ),
                   
                  ],
                ),
              ),
              Expanded(
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text('Product : '),
                          AppText(
                              text: name,
                              weight: FontWeight.w400,
                              size: 14,
                              textcolor: customBalck),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Price : '),
                          AppText(
                              text: price,
                              weight: FontWeight.w400,
                              size: 14,
                              textcolor: customBalck),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Storck : '),
                          AppText(
                              text: stock,
                              weight: FontWeight.w400,
                              size: 14,
                              textcolor: customBalck),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Category : '),
                          AppText(
                              text: category,
                              weight: FontWeight.w400,
                              size: 14,
                              textcolor: customBalck),
                        ],
                      ),
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

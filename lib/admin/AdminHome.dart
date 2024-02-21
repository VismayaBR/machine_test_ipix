import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:machine_test/admin/category.dart';
import 'package:machine_test/admin/stocks.dart';
import 'package:machine_test/constants/colors.dart';
import 'package:machine_test/widgets/AppText.dart';


class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(),

        body: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 30).r,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
              child: Container(
                height: 50.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10).r,
                    color: customBlue),
                child: TabBar(
                  
                  tabs:  [
                    Tab(
                        child: AppText(
                            text: "Stocks",
                            weight: FontWeight.w400,
                            size: 14,
                            textcolor: customBalck)),
                    Tab(
                        child: AppText(
                            text: "Category",
                            weight: FontWeight.w400,
                            size: 14,
                            textcolor: customBalck)),
                  ],
                  indicator: BoxDecoration(
                      borderRadius:
                          BorderRadius.all(const Radius.circular(10).r),
                      // Creates border
                      color: maincolor),
                  dividerColor: Colors.transparent,
                  labelColor: white,
                  unselectedLabelColor: customBalck,
                  indicatorSize: TabBarIndicatorSize.tab,
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
             Expanded(
                child: TabBarView(children: [
              // Tab bar View.......
              Center(child: StocksList()),
              Center(child: CategoryList())
            ]))
          ]),
        ),
      ),
    );
  }
}


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:machine_test/constants/colors.dart';
import 'package:machine_test/widgets/AppText.dart';
import 'package:machine_test/widgets/categoryTile.dart';
import 'package:machine_test/widgets/customButton.dart';
import 'package:machine_test/widgets/customTextfield.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CategoryList extends StatefulWidget {
  CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  final formkey = GlobalKey<FormState>();

  final category = TextEditingController();

 String mechanicId='';

  @override


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20).r,
          child: FutureBuilder<QuerySnapshot>(
            
              future: FirebaseFirestore.instance.collection('category').get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                // Extract CategoryList from the snapshot
                final CategoryList = snapshot.data?.docs ?? [];
                

                return ListView.builder(
                  itemBuilder: (context, index) {
                    return  CategoryTile(
                      title: CategoryList[index]['category'],
                      id:CategoryList[index].id,
                    );
                  },
                  itemCount: CategoryList.length,
                );
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          add(context);
        },
        shape: const CircleBorder(
          side: BorderSide(color: customBalck),
        ),
        backgroundColor: white,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> add(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          child: Container(
            height: 350.h,
            width: 300.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: maincolor),
            child: Padding(
              padding: const EdgeInsets.all(20).r,
              child: Padding(
                padding: const EdgeInsets.all(15).r,
                child: Form(
                  key: formkey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AppText(
                            text: "Add Category",
                            weight: FontWeight.w500,
                            size: 20,
                            textcolor: customBalck),
                        Padding(
                          padding: const EdgeInsets.only(top: 40).r,
                          child: CustomTextField(
                              hint: "Category",
                              controller: category,
                              validator: (value) {
                                if (value!.isEmpty || value == null) {
                                  // validator.........
                                  return "Categrory name";
                                }
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                                  left: 30, right: 30, top: 40)
                              .r,
                          child: CustomButton(
                              btnname: "Add",
                              btntheam: customBlue,
                              textcolor: white,
                              click: () {
                                formkey.currentState!.validate();
                                setState(() {
                                  
                                });
                                addCategory();
                              }),
                        )
                      ]),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> addCategory() async {
    await FirebaseFirestore.instance.collection('category').add({
      'category': category.text,
    });
    category.text='';
    Navigator.pop(context);
 
  }
}


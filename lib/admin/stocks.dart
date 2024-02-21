import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:machine_test/admin/StockScreen.dart';
import 'package:machine_test/constants/colors.dart';
import 'package:machine_test/widgets/AppText.dart';
import 'package:machine_test/widgets/customButton.dart';
import 'package:machine_test/widgets/customTextfield.dart';
import 'package:machine_test/widgets/stockTile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StocksList extends StatefulWidget {
  const StocksList({Key? key});

  @override
  State<StocksList> createState() => _StocksListState();
}

class _StocksListState extends State<StocksList> {
  final formkey = GlobalKey<FormState>();
  final product = TextEditingController();
  final price = TextEditingController();
  final stock = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  XFile? _image;
  String? imageUrl;
  

  String? selectedCategory; // Variable to store the selected category
  List<String> categories = [];

  Future<void> fetchCategories() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('category').get();
      setState(() {
        categories =
            querySnapshot.docs.map((doc) => doc['category'] as String).toList();
      });
      print(categories);
    } catch (e) {
      print('Error fetching categories: $e');
      // Handle error
    }
  }
   XFile? _image2;
  String? imageUrl2;
  // final ImagePicker _picker = ImagePicker();

  Future<void> _getImage2() async {
    // Function to pick an image
    final XFile? image2 = await _picker.pickImage(
        source: ImageSource.gallery); // Pick an image from the gallery
    setState(() {
      _image2 = image2; // Set the picked image to the _image variable
    });
  }

  XFile? _image3;
  String? imageUrl3;

  Future<void> _getImage3() async {
    // Function to pick an image
    final XFile? image3 = await _picker.pickImage(
        source: ImageSource.gallery); // Pick an image from the gallery
    setState(() {
      _image3 = image3; // Set the picked image to the _image variable
    });
     
  }


  Future<void> _getImage() async {
    // Function to pick an image
    final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery); // Pick an image from the gallery
    setState(() {
      _image = image; // Set the picked image to the _image variable
    });
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getData() async {

    try {
      
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('stocks').get();

      print('Firestore Data: ${querySnapshot.docs}');

      return querySnapshot;
    } catch (e) {
      print('Error fetching data: $e');
      throw e; // Rethrow the exception to be caught by the FutureBuilder
    }
  }

  @override
  void initState() {
    print('------------------');
    fetchCategories(); // Fetch categories from Firestore when the widget initializes
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          print('---------------${snapshot.data}');
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
            // return Text('data');
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          // Extract requests from the snapshot
          final stocks = snapshot.data?.docs ?? [];

          return ListView.builder(
            itemBuilder: (context, index) {
              // Access dynamic data from Firestore query
              // print('object');
              var stock = stocks[index].data() as Map<String, dynamic>;
              var id = stocks[index].id;
              print('>>>>>>>>>>>>>$id');

              return StockTile(
                image: stock['image1'],
                // name: '' ?? "Unknown",
                name: stock['product'] ?? "Unknown",
               category: stock['category'] ?? "Unknown",
                price: stock['price'] ?? "Unknown",
                stock: stock['stock'] ?? "Unknown",
                click: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StockScreen(
                        req_id: id,
                        product: stock['product'] ?? "Unknown",
                        price: stock['description'] ?? "Unknown",
                        description: stock['price'] ?? "Unknown",
                        stock: stock['stock'] ?? "Unknown",
                        image1: stock['image1'] ?? "Unknown",
                        image2: stock['image2'] ?? "Unknown",
                        image3: stock['image3'] ?? "Unknown",
                      ),
                    ),
                  );
                },
              );
            },
            itemCount: stocks.length,
          );
        },
      ),
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
          child: SingleChildScrollView(
            child: Container(
              height: 750.h,
              width: 750.w,
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
                              text: "Add Stock",
                              weight: FontWeight.w500,
                              size: 20,
                              textcolor: customBalck),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                _getImage();
                              },
                              child: Container(
                                height: 50,
                                color: white,
                                child: Center(
                                    child: _image == null
                                        ? Center(
                                            child:
                                                Text('Click to upload Image'))
                                        : Image.file(File(_image!.path),
                                            fit: BoxFit.cover)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30).r,
                            child: CustomTextField(
                                hint: "Product",
                                controller: product,
                                validator: (value) {
                                  if (value!.isEmpty || value == null) {
                                    // validator.........
                                    return "Product name";
                                  }
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                    left: 30, right: 30, top: 10)
                                .r,
                            child: Container(
                              color: white,
                              child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  border:
                                      InputBorder.none, // Removes the underline
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10.0), // Example padding
                                ),
                                value: selectedCategory,
                                hint: Text('Select Category'),
                                onChanged: (value) {
                                  setState(() {
                                    selectedCategory = value;
                                  });
                                },
                                items: categories
                                    .map((category) => DropdownMenuItem(
                                          value: category,
                                          child: Text(category),
                                        ))
                                    .toList(),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10).r,
                            child: CustomTextField(
                                hint: "Price",
                                controller: price,
                                validator: (value) {
                                  if (value!.isEmpty || value == null) {
                                    // validator.........
                                    return "Price ";
                                  }
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 0).r,
                            child: CustomTextField(
                                hint: "Stock",
                                controller: stock,
                                validator: (value) {
                                  if (value!.isEmpty || value == null) {
                                    // validator.........
                                    return "Stock count";
                                  }
                                }),
                          ),
                        
                           Center(child: Text('Add other Images of product')),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: InkWell(
                                  onTap: () {
                                    _getImage2();
                                  },
                                  child: _image2 == null
                                      ? Center(child: Icon(Icons.upload))
                                      : Image.file(File(_image2!.path),
                                          fit: BoxFit.cover)),
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
                            child: InkWell(
                              onTap: () {
                                _getImage3();
                              },
                              child: Container(
                                child: _image3 == null
                                    ? Center(child: Icon(Icons.upload))
                                    : Image.file(File(_image3!.path),
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
                          )
                        ],
                      ),
                        Padding(
                            padding: const EdgeInsets.only(
                                    left: 30, right: 30, top: 10)
                                .r,
                            child: CustomButton(
                                btnname: "Add",
                                btntheam: customBlue,
                                textcolor: white,
                                click: () {
                                  formkey.currentState!.validate();
                                  setState(() {});
                                  addStock();
                                }),
                          ),
                        ]),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> addStock() async {
    try {
      if (_image != null) {
        Reference storageReference =
            FirebaseStorage.instance.ref().child('uploads/${_image!.name}');

        await storageReference.putFile(File(_image!.path));

        // Get the download URL
        imageUrl = await storageReference.getDownloadURL();
      }
      if(_image==null){
        imageUrl='';
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
    try {
      if (_image2 != null) {
        Reference storageReference =
            FirebaseStorage.instance.ref().child('uploads/${_image2!.name}');

        await storageReference.putFile(File(_image2!.path));

        // Get the download URL
        imageUrl2 = await storageReference.getDownloadURL();
      }
      if(_image2==null){
        imageUrl2='';
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
    try {
      if (_image3 != null) {
        Reference storageReference =
            FirebaseStorage.instance.ref().child('uploads/${_image3!.name}');

        await storageReference.putFile(File(_image3!.path));

        // Get the download URL
        imageUrl3 = await storageReference.getDownloadURL();
      }
      if(_image3==null){
        imageUrl3='';
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
    await FirebaseFirestore.instance.collection('stocks').add({
      'product': product.text,
      'price': price.text,
      'stock': stock.text,
      'image1': imageUrl,
      'image2':imageUrl2,
      'image3':imageUrl3,
      'category': selectedCategory
    });
    product.text = '';
    Navigator.pop(context);
  }
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:machine_test/constants/colors.dart';
import 'package:machine_test/user/ProductView.dart';

class UserHome extends StatefulWidget {
  const UserHome({Key? key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  late String? selectedCategory;

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  void fetchCategories() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('category').get();
    List<String> categories =
        querySnapshot.docs.map((doc) => doc['category'] as String).toList();

    setState(() {
      selectedCategory = categories.isNotEmpty ? categories.first : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Stock')),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('category').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              final categories = snapshot.data!.docs
                  .map((doc) => doc['category'] as String)
                  .toList();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 60,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                selectedCategory = categories[index];
                              });
                            },
                            child: Container(
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: selectedCategory == categories[index]
                                    ? customBlue
                                    : const Color.fromARGB(255, 237, 207, 161),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(child: Text(categories[index])),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  if (selectedCategory != null)
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('stocks')
                          .where('category', isEqualTo: selectedCategory)
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        }
                        final products = snapshot.data!.docs
                            .map((doc) => doc['product'] as String)
                            .toList();

                        return Column(
                          children: products.map((product) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                color: maincolor,
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (ctx) {
                                      return ProductView(product: product);
                                    }));
                                  },
                                  title: Text(product),
                                  trailing: Icon(Icons.arrow_circle_right),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:machine_test/constants/colors.dart';
import 'package:machine_test/user/Cart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductView extends StatefulWidget {
  String product;
  ProductView({super.key, required this.product});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  late Future<DocumentSnapshot> _productFuture;
  @override
  void initState() {
    super.initState();
    _productFuture = _fetchProductDetails(widget.product);
  }

  Future<DocumentSnapshot> _fetchProductDetails(String productId) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('stocks')
          .where('product', isEqualTo: productId)
          .limit(1)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first;
      } else {
        throw Exception('Product not found');
      }
    } catch (e) {
      throw Exception('Failed to fetch product details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: FutureBuilder(
        future: _productFuture,
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('Product not found'));
          }

          final productData = snapshot.data!.data() as Map<String, dynamic>;
          final productName = productData['product'] ?? 'Unknown Product';
          final price = productData['price'] ?? 'Unknown Product';
          final stock = productData['stock'] ?? 'Unknown Product';
          final image = productData['image1'] ?? 'Unknown Product';

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 150, width: 150, child: Image.network(image),),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Product : ',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        '$productName',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Price : ',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        '$price',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Available Stock : ',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        '$stock',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: InkWell(
                    onTap: () async {
                      SharedPreferences spref =
                          await SharedPreferences.getInstance();
                      var userId = spref.getString('user_id');

                      if (userId != null) {
                        try {
                          await FirebaseFirestore.instance
                              .collection('cart')
                              .add({
                            'product': productName,
                            'user_id': userId,
                          });

                          Navigator.push(context,
                              MaterialPageRoute(builder: (ctx) {
                            return const Cart();
                          }));
                        } catch (e) {
                          print('Error adding to cart: $e');
                        }
                      } else {
                        print('User ID is not available');
                      }
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: customBlue),
                      child: Center(
                          child: Text(
                        'Add to Cart',
                        style: GoogleFonts.poppins(fontSize: 15, color: white),
                      )),
                    ),
                  ),
                )

                // Add more widgets to display other product details here
              ],
            ),
          );
        },
      ),
    );
  }
}

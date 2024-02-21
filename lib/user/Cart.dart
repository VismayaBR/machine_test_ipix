import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:machine_test/constants/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<DocumentSnapshot> cartItems = [];

  @override
  void initState() {
    super.initState();
    _fetchCartItems();
  }

  Future<void> _fetchCartItems() async {
    try {
      // Retrieve the user ID from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('user_id');
      print(userId);

      if (userId != null) {
        // Query Firestore to fetch cart items for the user ID
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('cart')
            .where('user_id', isEqualTo: userId)
            .get();

        setState(() {
          cartItems = querySnapshot.docs;
        });
      } else {
        // User ID not found in SharedPreferences
        print('User ID not found in SharedPreferences');
      }
    } catch (e) {
      print('Error fetching cart items: $e');
    }
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Your Cart'),
    ),
    body: ListView.builder(
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        // Extract data from document snapshot
        String productId = cartItems[index]['product'];
        // String userId = cartItems[index]['userId'];

        // Display the cart item
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              _removeItemFromCart(index);
            },
            child: Container(
              color: maincolor,
              child: ListTile(
                trailing: InkWell(
                  onTap: (){
                    _removeItemFromCart(index);
                  },
                  child: Icon(Icons.clear,size: 15,)),
                title: Text('$productId'),
                // subtitle: Text('User ID: $userId'),
              ),
            ),
          ),
        );
      },
    ),
  );
}

void _removeItemFromCart(int index) async {
  // Get the document ID of the item to be removed
  String docId = cartItems[index].id;

  try {
    // Remove the item from the Firestore collection
    await FirebaseFirestore.instance.collection('cart').doc(docId).delete();

    // Update the local state to remove the item from the cartItems list
    setState(() {
      cartItems.removeAt(index);
    });
  } catch (e) {
    print('Error removing item from cart: $e');
  }
}



}

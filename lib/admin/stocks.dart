import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:machine_test/widgets/stockTile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StocksList extends StatefulWidget {
  const StocksList({Key? key});

  @override
  State<StocksList> createState() => _StocksListState();
}

class _StocksListState extends State<StocksList> {
 Future<QuerySnapshot<Map<String, dynamic>>> getData() async {
  try {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance
            .collection('stocks')
            .get();

    print('Firestore Data: ${querySnapshot.docs}');
    
    return querySnapshot;
  } catch (e) {
    print('Error fetching data: $e');
    throw e; // Rethrow the exception to be caught by the FutureBuilder
  }
}



  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
            var id =stocks[index].id;
            print('>>>>>>>>>>>>>$id');

            return StockTile(
              image: "assets/logo.png",
              name: '' ?? "Unknown",
              issue: stock['product'] ?? "Unknown",
              date: stock['description'] ?? "Unknown",
              time: stock['price'] ?? "Unknown",
              place: stock['stock'] ?? "Unknown",
              click: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => RequestScreen(
                //     req_id: id, 
                //     name: request['name']?? "Unknown",
                //     issue:request['issue']?? "Unknown",
                //     place:request['place']?? "Unknown",
                //     date:request['date']?? "Unknown",
                //     time:request['time']?? "Unknown",
                //     status: request['status']??"unknown"
                //     ),
                //   ),
                // );
              },
            );
          },
          itemCount: stocks.length,
        );
      },
    );
  }
}
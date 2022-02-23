import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shirleys/controllers/auth_controller.dart';
import 'package:shirleys/controllers/order_history_controller.dart';
import 'package:shirleys/modal/order.dart';
import 'package:shirleys/modal/order_history.dart';
import 'package:shirleys/utils/AppSettings.dart';
import 'package:shirleys/view/home_tab.dart';
import 'package:shirleys/view/order_details.dart';
import 'package:shirleys/view/shop_cart_screen.dart';

class CopyOrderHistoryScreen extends StatelessWidget {
  OrderHistoryController _controller = OrderHistoryController();
  RefreshController rController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
            color: Colors.black,
          ),
          leadingWidth: 30,
          title: Text(
            'Orders History',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          actions: [],
        ),
        body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey[600],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          Obx(()=>
                              Text(_controller.sorteditem.value,
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,))),
                          DropdownButton<String>(
                              isExpanded: true,
                              icon: Padding(
                                padding: EdgeInsets.only(right: 3.0),
                                child: Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.grey[600],
                                ),
                              ),
                              iconSize: 30,
                              style: TextStyle(color: AppColors.primaryColor),
                              underline: Container(
                                color: Colors.transparent,
                              ),
                              onChanged: (newValue) {
                                _controller.sorteditem.value = newValue;
                                _controller.sortItems();
                              },
                              items: _controller.sortedTerms.map((value) =>
                                  DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value, style: TextStyle(color: Colors.black),),
                                  )
                              ).toList()
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Expanded(
                  child: Obx(
                      () => _controller.progressing.value ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(5),
                              child: SmartRefresher(
                                controller: rController,
                                enablePullUp: _controller.currentPage.value<_controller.totalPages,
                                onLoading: (){
                                  _controller.loadMoreOrders().then((value){
                                    rController.loadComplete();
                                  });
                                },
                                onRefresh: (){
                                  _controller.loadOrders().then((value){
                                    rController.refreshCompleted();
                                  });
                                },
                                child: ListView(children:
                                  _controller.orderHistoryList
                                      .map((item) => listItem(item))
                                      .toList(),
                                ),
                              ),
                            ),
                    ),
                ),
              ],
            ),
    );
  }

  Widget listItem(OrderHistory order) {
    return GestureDetector(
      onTap: (){
        Get.to(OrderDetailScreen(orderId: order.id,order: order,));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black),
            color: Colors.grey[200]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Order ID : ${order.id}',
                        style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Amount',
                        style:
                            TextStyle( fontSize: 14),
                      ),
                      Text(
                        '\$${order.amount}',
                        style:
                            TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Created On',
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        order.createdDate,
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: Get.width * 0.7,
                    child: Text(
                      'Order Status',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Divider(),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        order.status,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

//   Widget orderItemDetail(OrderDetails orderDetails, int index){
//     return Container(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(15),
//                     color: Colors.black,
//                     image: DecorationImage(image: NetworkImage(orderDetails.productPhoto,),fit: BoxFit.cover,)
//                 ),
//                 width: Get.width*0.3,
//                 height: Get.height*0.25,
// //                                    child: CachedNetworkImage(imageUrl: item.photo,fit: BoxFit.cover,
// //                                      width: Get.width*0.3,
// //                                      height: Get.height*0.25,
// //                                    ),
//               ),
//               // Image.network(
//               //   item.photo,
//               //   fit: BoxFit.contain,
//               //   width: Get.width*0.3,
//               //   height: Get.height*0.25,
//               // ),
//               SizedBox(width: 10,),
//               Container(
//                 width: Get.width*0.48,
//                 height: Get.height*0.25,
//                 //color: Colors.blue,
//                 padding: EdgeInsets.only(bottom: 5),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       orderDetails.productTitle,
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 16,
// //                                              letterSpacing: 1,
//                       ),
//                     ),
//                     SizedBox(height: 5,),
//                     Text(
//                       '',
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 16,
//                       ),
//                       maxLines: 2,
//                     ),
//                     SizedBox(height: 7,),
//                     Text(
//                       orderDetails.details[index].sizeTitle,
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 14,
// //                                              letterSpacing: 1,
//                       ),
//                     ),
//                     // CircleAvatar(backgroundColor: Color(int.parse(item.c)),),
//                     Spacer(),
//                     Text(
//                       '${orderDetails.details[index].quantity} x \$${orderDetails.details[index].amount}',
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 14,
// //                                              letterSpacing: 1,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 height: Get.height*0.25,
//                 child: Column(
// //                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Spacer(),
//                     Text(
//                       '\$${(double.parse(orderDetails.details[index].amount)*double.parse(orderDetails.details[index].quantity)).toStringAsFixed(2)}',
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 14,
// //                                              letterSpacing: 1,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           Divider(),
//         ],
//       ),
//     );
//   }

}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shirleys/controllers/auth_controller.dart';
import 'package:shirleys/controllers/order_history_controller.dart';
import 'package:shirleys/modal/order_history.dart';
import 'package:shirleys/utils/AppSettings.dart';
import 'package:shirleys/view/home_tab.dart';
import 'package:shirleys/view/shop_cart_screen.dart';

class OrderHistoryScreen extends StatelessWidget {

  bool isOrderEmpty = false;
  OrderHistoryController _controller = OrderHistoryController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.black,),
        leadingWidth: 30,
        title: Text('Order History', style: TextStyle(color: Colors.black, fontSize: 20),),
        actions: [
        ],
      ),
      body: isOrderEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(icon: Icon(Icons.search), iconSize: 50,),
            SizedBox(height: 15,),
            Text('No Order Found', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
            SizedBox(height: 15,),
            Text('Manage your orders here', style: TextStyle(fontSize: 16),),
          ],
        ),
      )
          : Obx(
          ()=> _controller.progressing.value ? Center(child: CircularProgressIndicator(),) : Padding(
        padding: const EdgeInsets.all(5),
        child: ListView(
            children: [
              SizedBox(height: 10,),
              ..._controller.orderHistoryList.map((item) =>
                  listItem(item)).toList(),
            ]
        ),
      ),
          )
    );
  }

  Widget listItem(OrderHistory item ){

   return  ExpansionTile(
     title: Column(
       children: [
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Text(
               item.billingAddress,
               style: TextStyle(fontSize: 18),
             ),
             Spacer(),
             Container(
               color: AppColors.primaryColor,
               child: Padding(
                 padding: const EdgeInsets.all(2.0),
                 child: Text(
                   item.status,
                   style: TextStyle(color: Colors.white),
                 ),
               ),
             ),
           ],
         ),
         SizedBox(height:3),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Text(
               item.createdDate,
               style: TextStyle(fontSize: 14),
             ),
             Text(
               'Amount: \$${item.amount}',
               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
             ),
           ],
         ),
         SizedBox(height:3),
       ],
     ),
     subtitle: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Text(
           item.orderNotes,
           style: TextStyle(
             fontSize: 16
           ),
         ),
         Divider(),
       ],
     ),
     textColor: Colors.black,
     collapsedBackgroundColor: Colors.grey[300],
     backgroundColor: AppColors.primaryColor.withOpacity(0.3),
     children: item.orderDetails.map((itemDetail) => Padding(
       padding: const EdgeInsets.all(8.0),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Container(
             color: Colors.white70,
//           width: double.infinity,
             child: Row(
               children: [
                 Container(
                   height: 250,
                   width: Get.width*0.35,
                   child: Image.network(itemDetail.productPhoto, fit: BoxFit.cover,)
                 ),
                 SizedBox(width: 3,),
                 Container(
                  height: 250,
                  width: Get.width*0.5,
//                color: Colors.blue,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          itemDetail.productTitle,
                          style: TextStyle(
                            fontSize: 18
                          ),
                        ),
                      Spacer(),
                      Text(
                          itemDetail.categoryTitle,
                          style: TextStyle(
                              fontSize: 16
                          ),
                        ),
                      Spacer(),
                      Text(
                          itemDetail.subCategoryTitle,
                          style: TextStyle(
                              fontSize: 16
                          ),
                        ),
                    ],
                  ),
                 ),
               ],
             ),
//       children: itemDetail.details.asMap().entries.map((orderDetails) => orderItemDetail(itemDetail, orderDetails.key)).toList(),
           ),
           Container(
             height: 50,
             child: ListView(
               shrinkWrap: true,
               scrollDirection: Axis.horizontal,
               children: itemDetail.details.map((detail) => Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Container(
                     color: Colors.grey[300],
                   child: Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Row(
                       children: [
                         CircleAvatar(backgroundColor: Color(int.parse(detail.choiceColor)),),
                         Text("  \$ ${detail.amount}   "),
                         Text("quantity: ${detail.quantity}    "),
                         Text("size: ${detail.sizeTitle}"),
                         SizedBox(width: 10,)
                       ],
                     ),
                   )
                 ),
               )).toList(),
             ),
           ),
           Divider(),
         ],
       ),
     )).toList(),
   );

  }

  Widget orderItemDetail(OrderDetails orderDetails, int index){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black,
                    image: DecorationImage(image: NetworkImage(orderDetails.productPhoto,),fit: BoxFit.cover,)
                ),
                width: Get.width*0.3,
                height: Get.height*0.25,
//                                    child: CachedNetworkImage(imageUrl: item.photo,fit: BoxFit.cover,
//                                      width: Get.width*0.3,
//                                      height: Get.height*0.25,
//                                    ),
              ),
              // Image.network(
              //   item.photo,
              //   fit: BoxFit.contain,
              //   width: Get.width*0.3,
              //   height: Get.height*0.25,
              // ),
              SizedBox(width: 10,),
              Container(
                width: Get.width*0.48,
                height: Get.height*0.25,
                //color: Colors.blue,
                padding: EdgeInsets.only(bottom: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      orderDetails.productTitle,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
//                                              letterSpacing: 1,
                      ),
                    ),
                    SizedBox(height: 5,),
                    Text(
                      '',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      maxLines: 2,
                    ),
                    SizedBox(height: 7,),
                    Text(
                      orderDetails.details[index].sizeTitle,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
//                                              letterSpacing: 1,
                      ),
                    ),
                    // CircleAvatar(backgroundColor: Color(int.parse(item.c)),),
                    Spacer(),
                    Text(
                      '${orderDetails.details[index].quantity} x \$${orderDetails.details[index].amount}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
//                                              letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: Get.height*0.25,
                child: Column(
//                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Spacer(),
                    Text(
                      '\$${(double.parse(orderDetails.details[index].amount)*double.parse(orderDetails.details[index].quantity)).toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
//                                              letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }

}










import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shirleys/modal/order_history.dart';
import 'package:shirleys/utils/AppSettings.dart';

class OrderDetailScreen extends StatelessWidget {
  String orderId;
  OrderHistory order;
  OrderDetailScreen({this.orderId,this.order});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.black,),
          leadingWidth: 30,
          title: Text('Orders History', style: TextStyle(color: Colors.black, fontSize: 20),),
          actions: [
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(5),
            child: ListView(
          children: [
            SizedBox(height: 10,),
            listItem(order),
          ]
            ),
          )
    );
  }
  Widget listItem(OrderHistory item){
    return  ExpansionTile(
      initiallyExpanded: true,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order ID : ${item.id}',
                style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
              ),
              Text(
                'Amount: \$${item.amount}',
                style: TextStyle( fontSize: 14),
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
            ],
          ),

          SizedBox(height:3),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Billing Address : ${item.billingAddress}",
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),

          SizedBox(height:3),
          Container(
            decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(5)
            ),
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
      textColor: Colors.black,
      // collapsedBackgroundColor: Colors.grey[300],
      backgroundColor: Colors.white,
      children: item.orderDetails.map((itemDetail) => Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white70,
//           width: double.infinity,
              child: Row(
                children: [

                  Container(
                      height: Get.width*0.25,
                      width: Get.width*0.25,
                      child: Image.network(itemDetail.productPhoto, fit: BoxFit.cover,),

                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: Get.width*0.67,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          itemDetail.productTitle,
                          style: TextStyle(
                              fontSize: 18,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          itemDetail.categoryTitle,
                          style: TextStyle(
                              fontSize: 18
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
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: itemDetail.details.map((detail) => Padding(
                  padding: const EdgeInsets.all(4),
                  child: Container(
                    width: Get.width,
                      color: Colors.grey[100],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            detail.choiceId=='1'?Container(): CircleAvatar(backgroundColor: Color(int.parse(detail.choiceColor)),),

                            Text("Quantity: ${detail.quantity}    "),
                            detail.sizeId=='1'?Container(): Text("Size: ${detail.sizeTitle}"),
                            Text("  \$ ${detail.amount}   "),
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
}

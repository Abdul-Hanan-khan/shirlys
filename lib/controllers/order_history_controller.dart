import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shirleys/controllers/auth_controller.dart';
import 'package:shirleys/modal/order_history.dart';
import 'package:shirleys/services/http_services.dart';

class OrderHistoryController extends GetxController{
  OrderHistoryController(){
    loadOrders();
  }
  RxBool progressing = true.obs;
  AuthController controller = Get.find();
  List<OrderHistory> orderHistoryList = <OrderHistory>[].obs;
  List<OrderHistory> orderHistoryListCopy = <OrderHistory>[].obs;
  int totalPages = 0;
  RxInt currentPage = 0.obs;
  List<String>  sortedTerms = ["All Orders","Pending","Processing","In Deliver","Completed"];
  RxString sorteditem = "All Orders".obs;
 Future<void> loadOrders() async {
    Map<String, dynamic> jsonOrderHistory = await HttpService.getOrdersHistory(controller.user.value.id,1.toString());
   List rawList = jsonOrderHistory['orders'];
    orderHistoryList = rawList.map((json) =>OrderHistory.fromJson(json)).toList();
    totalPages = jsonOrderHistory['total_pages'];
    currentPage.value = 1;
    sorteditem.value="All Orders";
    progressing.value = false;
    orderHistoryListCopy.clear();
    orderHistoryListCopy.addAll(orderHistoryList);
  }


  Future<void> loadMoreOrders() async {
    Map<String, dynamic> jsonOrderHistory = await HttpService.getOrdersHistory(controller.user.value.id,(currentPage+1).toString());
    List rawList = jsonOrderHistory['orders'];
    orderHistoryList.addAll(rawList.map((json) =>OrderHistory.fromJson(json)).toList());
    // totalPages = jsonOrderHistory['total_pages'];
    currentPage.value = currentPage.value+1;
    progressing.value = false;
    orderHistoryListCopy.clear();
    orderHistoryListCopy.addAll(orderHistoryList);
  }

  sortItems(){
    if(sorteditem.value=="All Orders"){
      progressing.value = true ;
      orderHistoryList.clear();
      orderHistoryList.addAll(orderHistoryListCopy);
      progressing.value = false;
    }
    if(sorteditem.value=="Pending"){
      progressing.value = true ;
      orderHistoryList.clear();
      orderHistoryList.addAll(orderHistoryListCopy);
      orderHistoryList.removeWhere((element) => element.status!="Pending");
      progressing.value = false ;
    }
    if(sorteditem.value=="Processing"){
      progressing.value = true ;
      orderHistoryList.clear();
      orderHistoryList.addAll(orderHistoryListCopy);
      // orderHistoryListCopy.map((e) => orderHistoryList.addIf(e.status=="Processing", e));
      orderHistoryList.removeWhere((element) => element.status!="Processing");
      progressing.value = false ;
    }
    if(sorteditem.value=="In Deliver"){
      progressing.value = true ;
      orderHistoryList.clear();
      orderHistoryList.addAll(orderHistoryListCopy);
      orderHistoryList.removeWhere((element) => element.status!="In-Deliver");
      progressing.value = false ;
    }
    if(sorteditem.value=="Completed"){
      progressing.value = true ;
      orderHistoryList.clear();
      orderHistoryList.addAll(orderHistoryListCopy);
      orderHistoryList.removeWhere((element) => element.status!="Completed");
      progressing.value = false;
    }

  }
}


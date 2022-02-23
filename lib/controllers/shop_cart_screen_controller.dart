import 'package:cached_map/cached_map.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shirleys/modal/cart_modal.dart';

class CartController extends GetxController {

  RxList<Item> items = <Item>[].obs;
  RxInt totalItems = 0.obs;


  @override
  onInit()  {
    loadCart();
    super.onInit();
  }

  Future<Cart> loadCart() async {
    try{
      Map<String, dynamic> cartJson =
      await Mapped.loadFileDirectly(cachedFileName: 'Cart');

      if (cartJson == null)
        items.value=[];
      else
        {
          items.value = Cart.fromJson(cartJson).items;
         calculateTotalItems();
        }
    }
    catch(e){
      print(e);
    }
  }


 int  calculateTotalItems(){
    int total=0;
    items.forEach((item) {
      total=total+item.quantity;
    });
    totalItems.value = total;
    return total;
  }

  clearCart(){
    Mapped.deleteFileDirectly(cachedFileName: "Cart");
    items.clear();
    calculateTotalItems();
  }

  addItem(Item item) {
    if (items.any((element) =>
    element.choiceID == item.choiceID && element.size.id == item.size.id)) {
      int index = items.indexWhere((element) =>
          element.id == item.id &&
          element.choiceID == item.choiceID &&
          element.size.id == item.size.id
      );
      if (index != null) {
        items[index].quantity++;
      }
    } else {
      items.add(item);
    }
    Mapped.saveFileDirectly(file: Cart(items: items).toJson(), cachedFileName: 'Cart');
    Fluttertoast.showToast(msg: "Added to bag successfully");
    calculateTotalItems();
  }

  removeItem(Item item) {
    int index = items.indexWhere((element) =>
        element.id == item.id &&
        element.choiceID == item.choiceID &&
        element.size.id == item.size.id);
    if (index != null) {
      items.removeAt(index);
      Mapped.saveFileDirectly(
          file: Cart(items: items).toJson(), cachedFileName: 'Cart');
    } else
      print("index not found");
    calculateTotalItems();
  }
}
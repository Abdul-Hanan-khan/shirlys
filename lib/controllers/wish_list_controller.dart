import 'package:cached_map/cached_map.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shirleys/modal/products.dart';
import 'package:shirleys/modal/wish_list_modal.dart';

class WishListController extends GetxController {
  WishList wishList = WishList(items: []);

  RxList<Product> items = <Product>[].obs;



  @override
  onInit()  {
    loadList();
    super.onInit();
  }

  Future<WishList> loadList() async {
    try{
      Map<String, dynamic> wishList =
      await Mapped.loadFileDirectly(cachedFileName: 'WishList');

      if (wishList == null)
        items.value=[];
      else
        items.value = WishList.fromJson(wishList).items;
    }
    catch(e){
      print(e);
    }
  }


  addOrRemoveItem(Product product) {
    if (items.any((element) =>
    element.id == product.id )) {
      removeItem(product);
    }

    else{
      items.add(product);
      Mapped.saveFileDirectly(file: WishList(items: items).toJson(), cachedFileName: 'WishList');
      Fluttertoast.showToast(msg: "Added to wish list");
    }
  }

  removeItem(Product product) {
    int index = items.indexWhere((element) =>
    element.id == product.id );
    if (index != null) {
      items.removeAt(index);
      Mapped.saveFileDirectly(
          file: WishList(items: items).toJson(), cachedFileName: 'WishList');
      Fluttertoast.showToast(msg: "Item removed from wish list");
    } else
      print("index not found");
  }
}

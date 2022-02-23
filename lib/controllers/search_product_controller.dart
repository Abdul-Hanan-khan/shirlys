import 'package:get/get.dart';
import 'package:shirleys/modal/search.dart';
import 'package:shirleys/services/http_services.dart';

class SearchProductController extends GetxController{
  RxList<SearchProduct> searchedProducts = <SearchProduct>[].obs;


  loadSearchProduct(String searchString) async {
    searchedProducts.value = await HttpService.searchProduct(searchString);
  }

  clearSearches(){
    searchedProducts.clear();
  }

}

import 'package:flutter_test/flutter_test.dart';
import 'package:shirleys/modal/categories.dart';
import 'package:shirleys/services/http_services.dart';

void main(){

  test("api test should return the CategoryModal", () async {

    List<CategoryModal> modal = [CategoryModal.fromJson({
      "id": "2",
      "title": "Dresses",
      "sub_categories": [
        {
          "id": "3",
          "title": "Plus Size Dresses",
          "banner": "https://shirleysofficial.com/app/images/sub_categories/default.png"
        },
        {
          "id": "4",
          "title": "Plus Size Midi Dresses",
          "banner": "https://shirleysofficial.com/app/images/sub_categories/default.png"
        }
      ]
    }),
      CategoryModal.fromJson(  {
        "id": "1",
        "title": "Mens",
        "sub_categories": [
          {
            "id": "1",
            "title": "Coats & Jackets",
            "banner": "https://shirleysofficial.com/app/images/sub_categories/default.png"
          },
          {
            "id": "2",
            "title": "Jeans",
            "banner": "https://shirleysofficial.com/app/images/sub_categories/jeans.jpg"
          }
        ]
      })];
    List<CategoryModal> matcher = await HttpService.getAllCategories();

    expect(modal.first.id,matcher.first.id);

  });


}



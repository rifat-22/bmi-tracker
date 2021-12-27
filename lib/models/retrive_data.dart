import 'package:bmi/models/bmi_get_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryService {
  FirebaseFirestore? _instance;

  List<BmiData> _categories = [];

  List<BmiData> getCategories() {
    return _categories;
  }

  Future<void>
      getCategoriesCollectionFromFirebase() async {
    _instance = FirebaseFirestore.instance;
    CollectionReference categories =
        _instance!.collection('bmis');
    BmiData? cat;

    DocumentSnapshot snapshot =
        await categories.doc('bmidata').get();
    if (snapshot.exists) {
      Map<String, dynamic> data =
          snapshot.data() as Map<String, dynamic>;
      var categoriesData = data as List<dynamic>;
      categoriesData.forEach((catData) {
        cat = BmiData.fromJson(catData);
        _categories.add(cat!);
      });
    }
    print(cat.toString());
  }

  // void resetCategoriesToDefaults() {
  //   if (_categories.length > 0) {
  //     _categories.forEach((Category cat) {
  //       cat.subCategories!
  //           .forEach((Category subCat) {
  //         (subCat as SubCategory)
  //             .parts
  //             .forEach((CategoryPart part) {
  //           part.isSelected = false;
  //         });
  //
  //         (subCat as SubCategory).amount = 0;
  //       });
  //     });
  //   }
  // }
}

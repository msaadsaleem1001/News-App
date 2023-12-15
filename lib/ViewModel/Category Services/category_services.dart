
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:news_app/Data/Response/status.dart';
import 'package:news_app/Models/Category%20Modal/categories_modal.dart';
import 'package:news_app/Repository/Categories/categories_repository.dart';


class CategoriesServices extends GetxController{

  final categoryRepository = CategoriesRepository();

  RxInt selectedCategory = 0.obs;

  final rxStatusCodeCategory = Status.LOADING.obs;

  final errorMsgCategory = ''.obs;

  Rx<CategoryModal> categoryModal = CategoryModal().obs;

  void setRxStatusCodeCategory(Status value) => rxStatusCodeCategory.value = value;
  void setErrorMsgCategory(String str) => errorMsgCategory.value = str;
  void setCategoryModal(CategoryModal modal) => categoryModal.value = modal;
  void setSelectedCategory(int val) => selectedCategory.value = val;

  List<String> categoriesList = [
    'General',
    'Entertainment',
    'Health',
    'Sports',
    'Business',
    'Technology'
  ];

  void getCategories(String category) {
    setRxStatusCodeCategory(Status.LOADING);
    categoryRepository.getCategories(category).then((value) {
      setRxStatusCodeCategory(Status.COMPLETED);
      setCategoryModal(CategoryModal.fromJson(value));
      debugPrint(categoryModal.value.totalResults.toString());
    }).onError((error, stackTrace) {
      setRxStatusCodeCategory(Status.ERROR);
      setErrorMsgCategory(error.toString());
    });
  }

}
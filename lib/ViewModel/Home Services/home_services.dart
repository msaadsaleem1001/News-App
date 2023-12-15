
import 'package:get/get.dart';
import 'package:news_app/Data/Response/status.dart';
import 'package:news_app/Models/Category%20Modal/categories_modal.dart';
import 'package:news_app/Models/NewsModal/news_channel_headlines_modal.dart';
import 'package:news_app/Repository/Categories/categories_repository.dart';
import 'package:news_app/Repository/Home%20Repository/home_repository.dart';

class HomeViewModel extends GetxController {

  final homeRepoInstance = HomeRepository();

  final rxStatusCode = Status.LOADING.obs;

  final errorMsg = ''.obs;

  List<String> channelsListEndPoint = [
    'bbc-news',
    'abc-news',
    'cnn',
    'the-times-of-india',
    'cbc-news',
    'news24'
  ];
  List<String> channelsList = [
    'BBC News',
    'ABC News',
    'CNN',
    'The Times of India',
    'CBC News',
    'News24'
  ];


  Rx<NewsModal> newsModal = NewsModal().obs;

  void setRxStatusCode(Status value) => rxStatusCode.value = value;
  void setNewsModal(NewsModal modal) => newsModal.value = modal;
  void setErrorMsg(String str) => errorMsg.value = str;


  void getNews(String endPoint) {
    setRxStatusCode(Status.LOADING);
    homeRepoInstance.getNews(endPoint).then((value) {
      setRxStatusCode(Status.COMPLETED);
      setNewsModal(NewsModal.fromJson(value));
    }).onError((error, stackTrace) {
      setRxStatusCode(Status.ERROR);
      setErrorMsg(error.toString());
    });
  }


//   Below code for general categories


  final categoryRepository = CategoriesRepository();

  final rxStatusCodeCategory = Status.LOADING.obs;

  final errorMsgCategory = ''.obs;

  Rx<CategoryModal> categoryModal = CategoryModal().obs;

  void setRxStatusCodeCategory(Status value) => rxStatusCodeCategory.value = value;
  void setErrorMsgCategory(String str) => errorMsgCategory.value = str;
  void setCategoryModal(CategoryModal modal) => categoryModal.value = modal;


  void getCategories() {
    setRxStatusCodeCategory(Status.LOADING);
    categoryRepository.getCategories('General').then((value) {
      setRxStatusCodeCategory(Status.COMPLETED);
      setCategoryModal(CategoryModal.fromJson(value));
    }).onError((error, stackTrace) {
      setRxStatusCodeCategory(Status.ERROR);
      setErrorMsgCategory(error.toString());
    });
  }

}

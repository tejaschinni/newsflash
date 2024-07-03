import 'package:flutter/foundation.dart';
import 'package:newsflash/model/news_model.dart';
import 'package:newsflash/repository/repository.dart';
import 'package:newsflash/utils/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum TopNewsStatus { initial, loading, success, failed, noNews }

enum AllNewsStatus { initial, loading, success, failed, noNews }

class NewsProvider with ChangeNotifier {
  List<NewsModel> _allList = [];
  List<NewsModel> get allNews => _allList;
  List<NewsModel> _topList = [];
  List<NewsModel> get topNews => _topList;
  TopNewsStatus _status = TopNewsStatus.initial;
  TopNewsStatus get topStatus => _status;
  AllNewsStatus _allstatus = AllNewsStatus.initial;
  AllNewsStatus get allStatus => _allstatus;

  getTopNews() async {
    _status = TopNewsStatus.loading;
    try {
      print("$baseURL/top-headlines?language=as&apiKey=${keyAPI.toString()}");
      var response = await Repository().requestGET(
          url:
              "$baseURL/top-headlines?language=en&apiKey=${keyAPI.toString()}");

      if (response != null) {
        _topList = [];

        _topList = response['articles']
            .map<NewsModel>((item) => NewsModel.fromJson(item))
            .toList();

        if (_topList.isNotEmpty) {
          _status = TopNewsStatus.success;
        } else {
          _status = TopNewsStatus.noNews;
        }
      } else {
        _status = TopNewsStatus.failed;
      }
    } catch (E, trace) {
      _status = TopNewsStatus.failed;
      print("==================Error while getting all news");
      print(E);
      print(trace);
      print("===============================================");
    }
    notifyListeners();
  }

  getAllNews() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String code;
    if (pref.containsKey("code")) {
      code = pref.getString("code").toString();
    } else {
      code = 'en';
    }
    _allstatus = AllNewsStatus.loading;
    try {
      var allnewsResponse = await Repository().requestGET(
          url:
              "$baseURL/everything?q=bitcoin&language=$code&apiKey=${keyAPI.toString()}");
      print(allnewsResponse);
      if (allnewsResponse != null) {
        _allList = allnewsResponse['articles']
            .map<NewsModel>((item) => NewsModel.fromJson(item))
            .toList();
        if (_allList.isNotEmpty) {
          _allstatus = AllNewsStatus.success;
        } else {
          _allstatus = AllNewsStatus.noNews;
        }
      }
    } catch (E) {
      print("object");
      print(E);
      _allstatus = AllNewsStatus.failed;
    }
    notifyListeners();
  }
}

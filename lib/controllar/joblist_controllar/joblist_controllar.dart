import 'dart:convert';

import 'package:connect/Const/const.dart';
import 'package:connect/model/joblist_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

class JobListControllar extends ChangeNotifier {
  int ofssetpage = 0;
  int limit = 3;
  var pageloder = false;
  ScrollController scrollController = ScrollController();

  List<JobMsg> joblist = [];

  // JobListRepository jobListRepository = JobListRepository();
  // // Future getJobList() async {
  // //   print("offf..${ofssetpage}");
  // //   var net = await jobListRepository.jobListRepo(ofssetpage, limit);
  // //   if (net != null) {
  // //     pageloder = false;
  // //
  // //     for (var msg in net.msg!) {
  // //       if (joblist.contains(msg)) {
  // //       } else {
  // //         joblist.add(msg);
  // //       }
  // //     }
  // //
  // //     print("pageCheng....${ofssetpage}");
  // //     ofssetpage = ofssetpage + 3;
  // //     notifyListeners();
  // //     // joblistdata.msg!.forEach((element) {
  // //     //   joblist.add(element);
  // //     // });
  // //     print(joblist.length);
  // //   }
  // //   notifyListeners();
  // // }

  final List<JobMsg> _data = [];
  List<JobMsg> get data => _data;

  int _currentPage = 1;
  bool _isLoading = false;
  bool _isError = false;
  bool get isLoading => _isLoading;
  bool get isError => _isError;

  Future<void> fetchData() async {
    var box = Hive.box("login");
    if (_isLoading) {
      return;
    }

    try {
      print('User ID${box.get("userid")}');
      _isLoading = true;
      notifyListeners();
      final url =
          "$BaseUrl/job/listing?user_id=${box.get("userid")}&limit=$limit&offset=$_currentPage";
      // final headers = {'Authorization': 'Bearer your_token_here'};

      final newData = await fetchData1<JobListModel>(
        url,
        (json) => JobListModel.fromJson(json),
      );

      _data.addAll(newData.msg);
      _currentPage = _currentPage + 3;
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isError = true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  reset() {
    _data.clear();
    fetchData();
  }

  Future fetchData1<T>(
    String url,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    final response = await http.get(
      Uri.parse(url),
    );
    final jsonData = json.decode(response.body);
    if (jsonData['error'] == 0) {
      return fromJson(jsonData);
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}

import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import '../../model/mylinkModel/my-apply_link_model.dart';

class MyApplyJobs {
  var box = Hive.box('login');
  List<MyApply> applys = [];
  static Future<List<MyApply>>getUsers()async{
  const url = 'https://randomuser.me/api/?results=30';
  final uri = Uri.parse(url);
  final response = await http.get(uri);
  final body = response.body;
  final json = jsonDecode(body);
  final result = json['msg']as List<dynamic>;
  final users=result.map((e) => MyApply.fromJson(e)).toList();
  return users;
  }
}

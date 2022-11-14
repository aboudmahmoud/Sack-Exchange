import 'dart:convert';

import 'package:get/get.dart';
import 'package:stack_exchange/moudel/QusteionMoudel.dart';



import '../../utils/Constans.dart';
import 'package:http/http.dart' as http;

import '../localStroreg/localdataRepo.dart';
class Respostry {
  static final LoactDataRepo loactDataRepo = LoactDataRepo();
   static Future<QusteionMoudel> fetchQusteionMoudel() async {
    final response = await http.get(Uri.parse(BASE_URL));

    if (response.statusCode == 200) {
      //We gwt The Data From Api and also save it on sahred Prefnase
      loactDataRepo.save("items",response.body);

      return QusteionMoudel.fromJson(json.decode(response.body));
    } else {

      throw Exception('Failed to load QusteionMoudel');

    }
  }
   static var _itemsRobo = Items().obs ;

   static Items get itemsRobo => _itemsRobo.value;

   static set itemsRobo(Items value) {
    _itemsRobo.value = value;
  }

   static var _isLoading = false.obs;


   static get isLoading => _isLoading;

   static Future loadMore() async {

     _isLoading.value = true;

   }

  static  loadSharedPrefs() async {
    try {
      Map<String,dynamic> jsondatais =jsonDecode(await loactDataRepo.read("items")!);

      LoactDataRepo.qusteionMoudel= QusteionMoudel.fromJson(jsondatais);

    } catch (Excepetion) {
print( Excepetion);
    }
  }
}
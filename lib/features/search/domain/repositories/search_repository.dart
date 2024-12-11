import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixam_mart/api/api_client.dart';
import 'package:sixam_mart/features/item/domain/models/item_model.dart';
import 'package:sixam_mart/features/search/domain/repositories/search_repository_interface.dart';
import 'package:sixam_mart/util/app_constants.dart';

class SearchRepository implements SearchRepositoryInterface {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  SearchRepository({required this.apiClient, required this.sharedPreferences});

  @override
  Future<bool> saveSearchHistory(List<String> searchHistories) async {
    return await sharedPreferences.setStringList(AppConstants.searchHistory, searchHistories);
  }

  @override
  List<String> getSearchAddress() {
    return sharedPreferences.getStringList(AppConstants.searchHistory) ?? [];
  }

  @override
  Future<bool> clearSearchHistory() async {
    return sharedPreferences.setStringList(AppConstants.searchHistory, []);
  }

  @override
  Future add(value) {
    throw UnimplementedError();
  }

  @override
  Future delete(int? id) {
    throw UnimplementedError();
  }

  @override
  Future get(String? id) {
    throw UnimplementedError();
  }

  @override
  Future getList({int? offset, String? query, bool? isStore, bool isSuggestedItems = false,List <int>? categorysId=const []}) async {
    if(isSuggestedItems) {
      return await _getSuggestedItems();
    } else {
      return await _getSearchData(query, isStore!,categorysId:categorysId,offSet: offset );
    }
  }

  Future<List<Item>?> _getSuggestedItems() async {
    List<Item>? suggestedItemList;
    Response response = await apiClient.getData(AppConstants.suggestedItemUri);
    if(response.statusCode == 200) {
      suggestedItemList = [];
      response.body.forEach((suggestedItem) => suggestedItemList!.add(Item.fromJson(suggestedItem)));
    }
    return suggestedItemList;
  }

  Future<Response> _getSearchData(String? query, bool isStore,{List <int>? categorysId,offSet=1}) async {
    return await apiClient.getData('${AppConstants.searchUri}${isStore ? 'stores' : 'items'}/search?name=$query&offset=$offSet&limit=50&category_ids=$categorysId');
  }

  @override
  Future update(Map<String, dynamic> body, int? id) {
    throw UnimplementedError();
  }

}
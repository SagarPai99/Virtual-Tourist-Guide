import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_api/youtube_api.dart';

import 'package:vrtguide/helpers/DataProvider.dart';

/*
Directory appDocDir = await getApplicationDocumentsDirectory();
var cj = PersistCookieJar(dir: appDocDir.path, ignoreExpires: true);
var dio = Dio();
dio.interceptors.add(CookieManager(cj));
*/

class ApiConnect {
  static Future<Map> getLandmarks() async {
    try {
      var dio = Dio();
      Response response = await dio.get(DataProvider.getLandmarks);
      Map data = json.decode(response.toString());
      if (data.containsKey("success") && data['success'])
        return data;
      else
        return {"success": false};
    } catch (e) {
      print(e);
      return {"success": false};
    }
  }

  static Future<Map> getSimilarLandmarks(int lid) async {
    try {
      var dio = Dio();
      Response response =
          await dio.post(DataProvider.getSimilarLandmarks, data: {"lid": lid});
      Map data = json.decode(response.toString());
      if (data.containsKey("success") && data["success"])
        return data;
      else
        return {"success": false};
    } catch (e) {
      print(e);
      return {"success": false};
    }
  }

  static Future<Map> getNearbyLandmarks(int lid) async {
    try {
      var dio = Dio();
      Response response =
          await dio.post(DataProvider.getNearbyLandmarks, data: {"lid": lid});
      Map data = json.decode(response.toString());
      if (data.containsKey("success") && data["success"])
        return data;
      else
        return {"success": false};
    } catch (e) {
      print(e);
      return {"success": false};
    }
  }

  static Future<Map> getLandmarkPictures(int lid) async {
    try {
      var dio = Dio();
      Response response =
          await dio.post(DataProvider.getLandmarkPictures, data: {"lid": lid});
      Map data = json.decode(response.toString());
      if (data.containsKey("success") && data["success"])
        return data;
      else
        return {"success": false};
    } catch (e) {
      print(e);
      return {"success": false};
    }
  }

  static Future<Map> findOrRegisterUser(Map info) async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      var cj = PersistCookieJar(dir: appDocDir.path, ignoreExpires: true);
      var dio = Dio();
      dio.interceptors.add(CookieManager(cj));
      Response response =
          await dio.post(DataProvider.findOrRegisterUser, data: {
        "gid": info["gid"],
        "name": info["name"],
        "email": info["email"],
        "photoUrl": info["photoUrl"]
      });
      Map data = json.decode(response.toString());
      print(data);
      if (data.containsKey("success") && data["success"])
        return data;
      else
        return {"success": false};
    } catch (e) {
      print(e);
      return {"success": false};
    }
  }

  static Future<void> visitLandmark(int lid) async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      var cj = PersistCookieJar(dir: appDocDir.path, ignoreExpires: true);
      var dio = Dio();
      dio.interceptors.add(CookieManager(cj));
      await dio.post(DataProvider.visitLandmark, data: {"lid": lid});
    } catch (e) {
      print(e);
    }
  }

  static Future<Map> predict(String imageBase64) async {
    try {
      var dio = Dio();
      Response response = await dio
          .post(DataProvider.predictEndpoint, data: {"string": imageBase64});
      Map data = json.decode(response.toString());
      print(data);
      if (data.containsKey("success") && data["success"]) {
        await visitLandmark(int.parse(data["data"]));
        await setHistoryLandmark(int.parse(data["data"]));
        return data;
      } else
        return {"success": false};
    } catch (e) {
      print(e);
      return {"success": false};
    }
  }

  static Future<Map> getLandmarkInfoById(int lid) async {
    try {
      var dio = Dio();
      Response response =
          await dio.post(DataProvider.getLandmarkInfoById, data: {"lid": lid});
      Map data = json.decode(response.toString());
      if (data.containsKey("success") && data["success"]) {
        data["data"]["landmark_info"]["tags"] = data["data"]["tags"];
        return data;
      } else
        return {"success": false};
    } catch (e) {
      print(e);
      return {"success": false};
    }
  }

  static Future<Map> forEachLandmark( List<int> lids ) async{
    try{
      Map ret = Map();
      for( int ele in lids ){
        ret[ele] = (await getLandmarkInfoById( ele ))["data"]["landmark_info"];
      }
      return ret;
    }catch(e){
      print(e);
      return {};
    }
  }

  static Future<List<String>> getHistoryLandmark() async {
    try {
      SharedPreferences storage = await SharedPreferences.getInstance();
      String contents = storage.getString("landmarkHistory");
      if (contents == null || contents == "")
        return [];
      else
        return (json.decode(contents) as List<dynamic>).cast<String>();
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<void> setHistoryLandmark(int lid) async {
    try {
      SharedPreferences storage = await SharedPreferences.getInstance();
      List<String> contents = await getHistoryLandmark();
      contents.add(lid.toString());
      await storage.setString("landmarkHistory", json.encode(contents));
    } catch (e) {
      print(e);
    }
  }

  static Future<Map> youtubeApiFetch(String query) async {
    try {
      YoutubeAPI ytApi = new YoutubeAPI(DataProvider.youtubeDataApiKey,maxResults: 10);
      List<YT_API> ytResult = [];
      ytResult = await ytApi.search(query);
      List<Map> data = List<Map>();
      for( int i = 0 ; i < ytResult.length ; i++ ){
        data.add({
          "thumbnail" : ytResult[i].thumbnail["medium"]["url"],
          "url" : ytResult[i].url,
          "title" : ytResult[i].title
        });
      }
      return {"success": true, "data" : data};
    } catch (e) {
      print(e);
      return {"success": false};
    }
  }
}

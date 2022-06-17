import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_dot_technical_app/helper/url_helper.dart';
import 'package:test_dot_technical_app/model/gallery.dart';
import 'package:test_dot_technical_app/model/place.dart';
import 'package:test_dot_technical_app/model/user.dart';

class APIService {
  Future<Place> getListPlace() async {
    try {
      final result = await http.get(Uri.parse(URLHelper.url + '/place.json'));
      if (result.statusCode == 200) {
        // ignore: avoid_print
        print('ok from getListPlace');
        return Place.fromJson(jsonDecode(result.body));
      } else {
         // ignore: avoid_print
        print('bad from getListPlace');
       Place badResponse = Place.fromJson(jsonDecode(result.body));
        return Place(statusCode: badResponse.statusCode, message: badResponse.message, data: badResponse.data);
      }
    } catch (e) {
       // ignore: avoid_print
        print('error from getListPlace');
      return Place(statusCode: 0, message: e.toString(), data: null);
    }
  }

  Future<Galery> getListGallery() async {
    try {
      final result = await http.get(Uri.parse(URLHelper.url + '/gallery.json'));
      if (result.statusCode == 200) {
         // ignore: avoid_print
        print('ok from getListGallery');
        return Galery.fromJson(jsonDecode(result.body));
      } else {
        // ignore: avoid_print
        print('bad from getListGallery');
       Galery badResponse = Galery.fromJson(jsonDecode(result.body));
        return  Galery(statusCode: badResponse.statusCode, message: badResponse.message, data: badResponse.data);
      }
    } catch (e) {
      // ignore: avoid_print
        print('error from getListGallery');
      return Galery(statusCode: 0, message: e.toString(), data: null);
    }
  }

  Future<User> getUser() async {
    try {
      final result = await http.get(Uri.parse(URLHelper.url + '/user.json'));
      if (result.statusCode == 200) {
        // ignore: avoid_print
        print('ok from getListUser');
        return User.fromJson(jsonDecode(result.body));
      } else {
        // ignore: avoid_print
        print('bad from getListUser');
        User badResponse = User.fromJson(jsonDecode(result.body)); 
        return User(statusCode: badResponse.statusCode, message: badResponse.message, data: badResponse.data);
      }
    } catch (e) {
      // ignore: avoid_print
        print('error from getListUser');
      return User(statusCode: 0, message: e.toString(), data: null);
    }
  }
}

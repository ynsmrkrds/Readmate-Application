import 'dart:convert';
import 'dart:io';

import 'package:readmate_app/models/ebook.dart';
import 'package:readmate_app/models/library.dart';
import 'package:http/http.dart' as http;

class LibraryApi {
  // base url of library api
  static const String _baseUrl = "http://20.86.32.53/books";

  // fetches ebook that given id from the library on the server
  static Future<Ebook?> fetch(int id) async {
    final http.Response response = await http.get(Uri.parse("$_baseUrl/$id"));

    // if status code == 200
    if (response.statusCode == HttpStatus.ok) {
      return Ebook.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  // fetches ebooks that are related to the given keyword(s) from the library on the server
  static Future<Library?> search(String keyword) async {
    final http.Response response = await http.get(Uri.parse("$_baseUrl?search=$keyword"));

    return _checkResponse(response);
  }

  /* checks the status code of response 
    - returns a Library object if status code is equals to 200 
    - returns null if status code is not equals to 200 */
  static Library? _checkResponse(http.Response response) {
    // if status code == 200
    if (response.statusCode == HttpStatus.ok) {
      return Library.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }
}

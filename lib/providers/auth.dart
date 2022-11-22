import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  String _userId;
  DateTime _expiryDate;

  bool get isAuth {
    return token != null;
  }

  String get userId {
    return _userId;
  }

  String get token {
    if (_expiryDate != null &&
        _token != null &&
        _expiryDate.isAfter(
          DateTime.now(),
        )) return _token;
    return null;
  }

  Future<void> _authenticate(
      String email, String password, String urlSegmant) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/$urlSegmant?key=AIzaSyDHT3oYoIFGDwmS3e-YGarvrhaDYYSRcbA');
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signUp(String email, String password) async {
    return _authenticate(
      email,
      password,
      'accounts:signUp',
    );
    // when we return the future thats mean that we will wait till the response get back then we return it
  }

  Future<void> logIn(String email, String password) async {
    return _authenticate(
      email,
      password,
      'accounts:signInWithPassword',
    );
    // when we return the future thats mean that we will wait till the response get back then we return it
  }
}

import 'dart:convert';

import 'package:unlockd_assignment/core/constants/api_constants.dart';
import 'package:unlockd_assignment/core/error/exceptions.dart';

import 'package:unlockd_assignment/features/auth/data/models/user_model.dart';
import 'package:http/http.dart' as http;

// class to interact with server

abstract class AuthRemoteDataSource {
  Future<UserModel> userLogin(String userName, String password);
  Future<bool> logOutUser(String token);
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl({required this.client});

// Function to call login user and return User Model

  @override
  Future<UserModel> userLogin(String userName, String password) async {
    final response = await client.post(Uri.parse(ApiURLConstants.login),
        body: {"username": userName, "password": password},
        headers: {'Accept': 'application/json'});

    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }

// Function to logout user

  @override
  Future<bool> logOutUser(String token) async {
    final response = await client.post(
      Uri.parse(ApiURLConstants.logout),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw ServerException();
    }
  }
}

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// class to handle user token securely

abstract class SecureStorage {
  Future<void> saveToken(String token);
  Future<void> logout();
  Future<bool> checkLogin();

  Future<String?> getToken();
}

class SecureStorageImp implements SecureStorage {
  // innitiating FlutterSecureStorage library
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

// _tokenKey is a key to save,delete and fetch token by key

  final String _tokenKey = "auth_token";

// function to save user token

  @override
  Future<void> saveToken(String token) async {
    // Remove token from storage
    await _secureStorage.write(key: _tokenKey, value: token);
  }

// function to delete token

  @override
  Future<void> logout() async {
    // Remove token from storage
    await _secureStorage.delete(key: _tokenKey);
  }

//function to check user token is pressent

  @override
  Future<bool> checkLogin() async {
    // Check if a token exists
    String? token = await _secureStorage.read(key: _tokenKey);

    return token != null;
  }

// funnction to get user token by key
  @override
  Future<String?> getToken() async {
    var token = await _secureStorage.read(key: _tokenKey);

    return token;
  }
}

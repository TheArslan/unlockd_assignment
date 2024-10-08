import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:unlockd_assignment/core/constants/api_constants.dart';
import 'package:unlockd_assignment/core/error/exceptions.dart';
import 'package:unlockd_assignment/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:http/http.dart' as http;
import 'package:unlockd_assignment/features/auth/data/models/user_model.dart';
import '../../../../../core/helpers/helper_functions.dart';
import '../../../../../core/helpers/test_helpers.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late AuthRemoteDataSourceImpl userRemoteDataSourceImpl;
  const testUserName = "String";
  const testPassword = "String";

  setUp(() {
    mockHttpClient = MockHttpClient();
    userRemoteDataSourceImpl = AuthRemoteDataSourceImpl(client: mockHttpClient);
  });

  group(
    "get user loggin User",
    () {
      test(
        "should return user model when the response is 200",
        () async {
          // arrange
          when(mockHttpClient.post(
                  Uri.parse(
                    ApiURLConstants.login,
                  ),
                  body: {"username": testUserName, "password": testPassword}))
              .thenAnswer((_) async => http.Response(
                  readJson("core/dummy_data/dummy_user_response.json"), 200));

          // act

          final result = await userRemoteDataSourceImpl.userLogin(
              testUserName, testPassword);

          //assert

          expect(result, isA<UserModel>());
        },
      );
      test(
        "should throw Exception when the response is 404 or other",
        () async {
          // arrange
          when(mockHttpClient.post(
                  Uri.parse(
                    ApiURLConstants.login,
                  ),
                  body: {"username": testUserName, "password": testPassword}))
              .thenAnswer((_) async => http.Response("Server Error", 404));

          // act

          final result =
              userRemoteDataSourceImpl.userLogin(testUserName, testPassword);

          //assert

          expect(result, throwsA(isA<ServerException>()));
        },
      );
    },
  );
}

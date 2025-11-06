import 'package:car_parts_app/core/appUrls/api_urls.dart';
import 'package:car_parts_app/data/model/auth/sign_up_model.dart';
import 'package:dio/dio.dart';

abstract class AuthRemoteDatasource {
  Future<Map<String, dynamic>> signUp(SignupModel signupModel);
}

class AuthRemotedatasourceImpl extends AuthRemoteDatasource {
  final Dio dio;

  AuthRemotedatasourceImpl(this.dio);

  @override
  Future<Map<String, dynamic>> signUp(SignupModel signupModel) async {
    final response = await dio.post(ApiUrls.signUp , data: signupModel.toJson(),
    options: Options(
      headers: {
        'Content-Type': 'application/json',
      },
    )
    );
    if (response.statusCode == 201) {
      final data = response.data as Map<String, dynamic>;
      print(data);
      return data;
    } 
     throw Exception('❌ Failed to sign in: ${response.statusCode}');
  }

}
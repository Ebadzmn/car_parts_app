import 'package:car_parts_app/core/appUrls/api_urls.dart';
import 'package:car_parts_app/data/data_source/local/auth_local_datasource.dart';
import 'package:car_parts_app/data/model/auth/signIn_response_model.dart';
import 'package:car_parts_app/data/model/auth/sign_In_model.dart';
import 'package:car_parts_app/data/model/auth/sign_up_model.dart';
import 'package:car_parts_app/data/model/auth/verify_account_model.dart';
import 'package:car_parts_app/data/model/user/userProfile_model.dart';
import 'package:car_parts_app/domain/entities/user/userProfile.dart';
import 'package:car_parts_app/presentation/userProfile/pages/user_profile.dart';
import 'package:dio/dio.dart';

abstract class AuthRemoteDatasource {
  Future<Map<String, dynamic>> signUp(SignupModel signupModel);
  Future<Map<String, dynamic>> verifyAccount(
    VerifyAccountModel verifyAccountModel,
  );
  Future<LoginResponseModel> signIn(SignInModel signInModel);
  Future<ProfileModel> getUserProfile();
}

class AuthRemotedatasourceImpl extends AuthRemoteDatasource {
  final Dio dio;
  final AuthLocalDatasource authLocalDatasource;

  AuthRemotedatasourceImpl(this.dio, this.authLocalDatasource);

  @override
  Future<Map<String, dynamic>> signUp(SignupModel signupModel) async {
    try {
      final response = await dio.post(
        ApiUrls.signUp,
        data: signupModel.toJson(),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        // debug
        print('SignUp Response: $data');
        return data;
      }

      throw Exception(
        'Sign up failed: ${response.statusCode} ${response.statusMessage}',
      );
    } on DioError catch (e) {
      final msg = e.response?.data ?? e.message;
      throw Exception('DioError signUp: $msg');
    } catch (e) {
      throw Exception('Unknown error signUp: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> verifyAccount(
    VerifyAccountModel verifyAccountModel,
  ) async {
    try {
      final response = await dio.post(
        ApiUrls.verifyOtp,
        data: verifyAccountModel.toJson(),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        print('Verify Response: $data');
        return data;
      }

      throw Exception(
        'Verify failed: ${response.statusCode} ${response.statusMessage}',
      );
    } on DioError catch (e) {
      final msg = e.response?.data ?? e.message;
      throw Exception('DioError verifyAccount: $msg');
    } catch (e) {
      throw Exception('Unknown error verifyAccount: $e');
    }
  }

  @override
  Future<LoginResponseModel> signIn(SignInModel signInModel) async {
    try {
      final response = await dio.post(
        ApiUrls.signIn,
        data: signInModel.toJson(),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        print('🔑 SignIn Response: $data');
        return LoginResponseModel.fromJson(data);
      }

      throw Exception(
        'Sign in failed: ${response.statusCode} ${response.statusMessage}',
      );
    } on DioError catch (e) {
      final msg = e.response?.data ?? e.message;
      throw Exception('DioError signIn: $msg');
    } catch (e) {
      throw Exception('Unknown error signIn: $e');
    }
  }

  @override
  Future<ProfileModel> getUserProfile() async {
    final token = await authLocalDatasource.getToken();
    //authenticate user
    try {
      final response = await dio.get(
        ApiUrls.userProfile,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        print('🔑 getUserProfile Response: $data');
        return ProfileModel.fromJson(data);
      } else {
        throw Exception(
          'Get user profile failed: ${response.statusCode} ${response.statusMessage}',
        );
      }
    } catch (e) {
      throw Exception('Unknown error getUserProfile: $e');
    }
  }
}

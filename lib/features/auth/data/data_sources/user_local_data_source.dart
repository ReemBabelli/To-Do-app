import 'package:appwrite/models.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/features/auth/data/models/user_model.dart';

abstract class UserLocalDataSource {
  Future<Unit> cacheSession(Session session,UserModel user);
  Future<UserModel> getSession();
  Future<Unit> setLoggedIn(bool value);
   Future<bool> isLoggedIn();
   Future<Unit> logout();
}

class UserLocalDataSourceImp implements UserLocalDataSource{
  final SharedPreferences sharedPreferences;

  UserLocalDataSourceImp({required this.sharedPreferences});

  @override
  Future<Unit> cacheSession(Session session , UserModel user) {
    sharedPreferences.setString('userId', session.userId);
    sharedPreferences.setString('email', user.email);
    sharedPreferences.setString('password', user.password);
    setLoggedIn(true);
    return Future.value(unit);
  }

  @override
  Future<UserModel> getSession() {
    final email = sharedPreferences.getString('email');
    final password = sharedPreferences.getString('password');
    UserModel session = UserModel(email: email!, password: password!);
    return Future.value(session);
  }

  @override
  Future<Unit> setLoggedIn(bool value) {
    sharedPreferences.setBool('isLoggedIn', value);
    return Future.value(unit);
  }

  @override
  Future<bool> isLoggedIn() async {
    return  sharedPreferences.getBool('isLoggedIn') ??  false;
  }

  @override
  Future<Unit> logout() async {
    sharedPreferences.remove('userId');
    sharedPreferences.remove('email');
    sharedPreferences.remove('password');
    setLoggedIn(false);
    return Future.value(unit);
  }



  
}
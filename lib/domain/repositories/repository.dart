import 'package:math_playground/data/datasources/remote/authentication_datasource.dart';

import '../../data/datasources/remote/user_datasource.dart';
import '../models/user.dart';

class Repository {
  late AuthenticationDatatasource _authenticationDataSource;
  late UserDataSource _userDatatasource;
  late UserDataSource _userDataSource;

  String token = "";

  // the base url of the API should end without the /
  final String _baseUrl =
      "http://10.0.2.2:8000/api/auth";

  Repository() {
    _authenticationDataSource = AuthenticationDatatasource();
    // _userDatatasource = UserDataSource();
    _userDataSource = UserDataSource();
  }

  
  Future<User> getUser() async => await _userDataSource.getUser(_baseUrl, token);

  



  // --------------------------------------------------------------------------

  Future<bool> login(String email, String password) async {
    token = await _authenticationDataSource.login(_baseUrl, email, password);
    return true;
  }

  Future<bool> signUp(String email, String password) async =>
      await _authenticationDataSource.signUp(_baseUrl, email, password);

  Future<bool> logOut() async => await _authenticationDataSource.logOut();

  // Future<List<User>> getUsers() async => await _userDatatasource.getUsers();

  // Future<bool> addUser(User user) async =>
  //     await _userDatatasource.addUser(user);

  // Future<bool> updateUser(User user) async =>
  //     await _userDatatasource.updateUser(user);

  // Future<bool> deleteUser(int id) async =>
  //     await _userDatatasource.deleteUser(id);

  // Future<bool> simulateProcess() async =>
  //     await _userDatatasource.simulateProcess(_baseUrl, token);

  // // check if logging for the first time
  // Future<bool> checkIsFirstTime() async =>
  //     await _userDatatasource.checkIsFirstTime();
}
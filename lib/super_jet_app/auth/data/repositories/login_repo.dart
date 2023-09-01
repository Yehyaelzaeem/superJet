import 'package:superjet/super_jet_app/auth/data/models/user_model.dart';
import '../../domain/repositories/base_auth_repo.dart';
import '../data_sources/remote_datasource.dart';
import '../models/login_model.dart';
import '../models/register_model.dart';

class AuthRepo extends BaseAuthRepo{
  final BaseAuthDataSource baseAuthDataSource;

  AuthRepo(this.baseAuthDataSource);

  @override
  Future login(LoginModel loginModel,context) async{
   return await baseAuthDataSource.login(loginModel,context);
  }

  @override
  Future register(RegisterModel registerModel ,context)async {
   return await baseAuthDataSource.register(registerModel,context);
  }

  @override
  Future createUserDate(UserModel userModel, context) async {
    return await baseAuthDataSource.createUserData(userModel, context);
  }
}
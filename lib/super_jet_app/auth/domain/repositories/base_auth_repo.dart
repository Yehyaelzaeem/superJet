import 'package:superjet/super_jet_app/auth/data/models/user_model.dart';
import '../../data/models/login_model.dart';
import '../../data/models/register_model.dart';

abstract class BaseAuthRepo{
  Future login(LoginModel loginModel,context);
  Future register(RegisterModel registerModel ,context);
  Future createUserDate(UserModel userModel ,context);
}
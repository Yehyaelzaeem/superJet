import 'package:superjet/super_jet_app/auth/data/models/user_model.dart';
import '../../data/models/login_model.dart';
import '../../data/models/register_model.dart';
import '../repositories/base_auth_repo.dart';

class AuthUseCase {
  final BaseAuthRepo baseAuthRepo;
  AuthUseCase(this.baseAuthRepo);

  Future login(LoginModel loginModel ,context)async{
    return await baseAuthRepo.login(loginModel,context);
  }

  Future register(RegisterModel registerModel ,context)async{
    return await baseAuthRepo.register(registerModel ,context);
  }
  Future createUserData(UserModel userModel ,context)async{
    return await baseAuthRepo.createUserDate(userModel, context);
  }
}
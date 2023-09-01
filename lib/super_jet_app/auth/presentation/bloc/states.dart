import '../../data/models/login_model.dart';
import '../../data/models/register_model.dart';
abstract class AppAuthStates{}

class  AppAuthInitialStates extends AppAuthStates{}

class  ChangeEyePasswordStates extends AppAuthStates{}

class  GetPermissionStates extends AppAuthStates{}

class  AppGetTokenStates extends AppAuthStates{}

class  ChickUsersStates extends AppAuthStates{}

class  ResetPasswordStates extends AppAuthStates{}

class  LoginGoogleStates extends AppAuthStates{}

class  LoginGetDataModelStates extends AppAuthStates{}


//Login States
class  LoginSuccessStates extends AppAuthStates{
  final LoginModel loginModel;
  LoginSuccessStates(this.loginModel);
}
class  LoginLoadingStates extends AppAuthStates{}
class  LoginErrorStates extends AppAuthStates{
  final LoginModel loginModel;
  LoginErrorStates(this.loginModel);
}


//Register States
class  RegisterWaitingStates extends AppAuthStates{}
class  RegisterSuccessStates extends AppAuthStates{
  final RegisterModel registerModel ;
  RegisterSuccessStates(this.registerModel);
}
class  RegisterErrorStates extends AppAuthStates{
  final RegisterModel registerModel ;
  RegisterErrorStates(this.registerModel);
}




abstract class LoginStates {}

class LoginInitialState extends LoginStates{}
class LoginLoadingState extends LoginStates{}
class LoginSuccessState extends LoginStates{
  final loginModel;
  LoginSuccessState(this.loginModel);
}
class LoginErrorState extends LoginStates{
  final String error;
  LoginErrorState(this.error);
}
class DeleteUserSuccessState extends LoginStates{}
class DeleteUserErrorState extends LoginStates{}


class ChangePasswordVisibilityState extends LoginStates{}
class LoginUpdateLoadingState extends LoginStates{}
class LoginUpdateSuccessState extends LoginStates{

}
class LoginUpdateErrorState extends LoginStates{
  final String error;
  LoginUpdateErrorState(this.error);
}
class getDataState extends LoginStates{}
class GetSuccessState extends LoginStates{}
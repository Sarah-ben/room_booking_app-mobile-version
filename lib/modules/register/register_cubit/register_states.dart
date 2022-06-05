class RegisterState{}
class RegisterinitialState extends RegisterState{}
class RegisterLoadingState extends RegisterState{}
class RegisterSuccessState extends RegisterState{
  final loginModel;
  RegisterSuccessState(this.loginModel);
}
class RegisterErrorState extends RegisterState{
  final String error;
  RegisterErrorState(this.error);
}
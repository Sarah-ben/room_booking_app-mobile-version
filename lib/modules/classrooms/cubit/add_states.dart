
abstract class AddStates {}

class AddInitialState extends AddStates{}
class AddLoadingState extends AddStates{}
class UpdateDataState extends AddStates{}
class AddSuccessState extends AddStates{

}
class AddErrorState extends AddStates{
  final String error;
  AddErrorState(this.error);
}
class ChangePasswordVisibilityState extends AddStates{}
class getDataState extends AddStates{}
class GetSuccessState extends AddStates{}
class DeleteSuccessState extends AddStates{}
class UpdateSuccessState extends AddStates{}
class UpdateErrorState extends AddStates{}
class DeleteErrorState extends AddStates{}
class GetErrorState extends AddStates{}
class LoginUpdateLoadingState extends AddStates{}
class LoginUpdateSuccessState extends AddStates{

}
class LoginUpdateErrorState extends AddStates{
  final String error;
  LoginUpdateErrorState(this.error);
}
class SearchState extends AddStates{}
class SearchLoadingState extends AddStates{}
class SearchErrorState extends AddStates{}



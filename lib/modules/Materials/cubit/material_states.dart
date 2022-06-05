
abstract class MaterialStates {}

class AddInitialState extends MaterialStates{}
class AddLoadingState extends MaterialStates{}
class AddSuccessState extends MaterialStates{

}
class AddErrorState extends MaterialStates{
  final String error;
  AddErrorState(this.error);
}
class getDataState extends MaterialStates{}
class GetSuccessState extends MaterialStates{}
class DeleteSuccessState extends MaterialStates{}
class DeleteErrorState extends MaterialStates{}
class GetErrorState extends MaterialStates{}


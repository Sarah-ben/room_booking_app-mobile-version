
abstract class ReservationStates {}

class ReservationInitialState extends ReservationStates{}
class ReservationAddLoadingState extends ReservationStates{}
class ReservationADDSuccessState extends ReservationStates{

}
class ReservationAddErrorState extends ReservationStates{
  final String error;
  ReservationAddErrorState(this.error);
}
class ReservationUpdateLoadingState extends ReservationStates{}
class ReservationUpdateSuccessState extends ReservationStates{

}
class ReservationUpdateErrorState extends ReservationStates{

}
class ReservationGetLoadingState extends ReservationStates{}
class ReservationGetSuccessState extends ReservationStates{}
class ReservationDeleteSuccessState extends ReservationStates{}
class ReservationDeleteErrorState extends ReservationStates{}
class ReservationGetErrorState extends ReservationStates{}
class ReservationallGetErrorState extends ReservationStates{}
class ReservationallGetLoadingState extends ReservationStates{}
class ReservationallGetSuccessState extends ReservationStates{}



abstract class MaterialReservationStates {}

class ReservationInitialState extends MaterialReservationStates{}
class ReservationAddLoadingState extends MaterialReservationStates{}
class ReservationADDSuccessState extends MaterialReservationStates{

}
class ReservationAddErrorState extends MaterialReservationStates{
  final String error;
  ReservationAddErrorState(this.error);
}
class ReservationUpdateLoadingState extends MaterialReservationStates{}
class ReservationUpdateSuccessState extends MaterialReservationStates{

}
class ReservationUpdateErrorState extends MaterialReservationStates{

}
class ReservationGetLoadingState extends MaterialReservationStates{}
class ReservationGetSuccessState extends MaterialReservationStates{}
class ReservationDeleteSuccessState extends MaterialReservationStates{}
class ReservationDeleteErrorState extends MaterialReservationStates{}
class ReservationGetErrorState extends MaterialReservationStates{}
class ReservationallGetErrorState extends MaterialReservationStates{}
class ReservationallGetLoadingState extends MaterialReservationStates{}
class ReservationallGetSuccessState extends MaterialReservationStates{}



class ReservationModel{
  ReservationData? data;
  ReservationModel.fromJson(Map<String,dynamic>json){
    data=json['reservations']!=null?ReservationData.fromJson(json['reservations']):null;
  }

}

class ReservationData{
  int? id;
  String? time;
  String? date;
  String? goal;
  String? etat;
  int? id_classroom;
  int? id_user;
  ReservationData.fromJson(Map<String,dynamic>json){
    id=json['id'];
    time=json['time'];
    date=json['date'];
    goal=json['goal'];
    etat=json['etat'];
    id_classroom=json['id_classroom'];
    id_user=json['id_user'];
  }
}
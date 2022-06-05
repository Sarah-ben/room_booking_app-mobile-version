
class MaterialReservationModel{
  MaterialReservationData? data;
  MaterialReservationModel.fromJson(Map<String,dynamic>json){
    data=json['reservations']!=null?MaterialReservationData.fromJson(json['reservations']):null;
  }

}

class MaterialReservationData{
  int? id;
  String? time;
  String? date;
  String? goal;
  int? id_material;
  int? id_user;
  MaterialReservationData.fromJson(Map<String,dynamic>json){
    id=json['id'];
    time=json['time'];
    date=json['date'];
    goal=json['goal'];
    id_material=json['id_material'];
    id_user=json['id_user'];
  }
}
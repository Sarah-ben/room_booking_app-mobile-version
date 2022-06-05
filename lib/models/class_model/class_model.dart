

class ClassModel{
  Data? data;
  ClassModel.fromJson(Map<String,dynamic>json){
    data=json['salle']!=null?Data.fromJson(json['salle']):null;
  }

}

class Data{
  int? id;
  String? name;
  String? type;
  int? etage;
  int? capcity;
  bool? particulier;
  Data.fromJson(Map<String,dynamic>json){
    id=json['id'];
    name=json['name'];
    type=json['type'];
    etage=json['etage'];
    capcity=json['capcity'];
    particulier=json['particulier']==0?false:true;
  }
}
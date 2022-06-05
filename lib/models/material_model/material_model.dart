

class MaterialModel{
  MaterialData? data;
  MaterialModel.fromJson(Map<String,dynamic>json){
    data=json['datashows']!=null?MaterialData.fromJson(json['datashows']):null;
  }

}

class MaterialData{
  int? id;
  String? name;
  String? category;

  MaterialData.fromJson(Map<String,dynamic>json){
    id=json['id'];
    name=json['name'];
    category=json['category'];

  }
}
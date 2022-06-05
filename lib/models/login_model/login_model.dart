class LoginModel{

  UserData? userData;
  String? token;
  LoginModel.fromJson(Map<String,dynamic>json){
    userData=json['user']!=null?UserData.fromJson(json['user']):null;
    token=json['token'];

  }
}

class UserData{
  int? id;
  String? first_name;
  String? last_name;
  String? grade;
  String? place;
  String? email;
  String? role;

  UserData.fromJson(Map<String,dynamic>json){

    id=json['id'];
    first_name=json['first_name'];
    last_name=json['last_name'];
    grade=json['grade'];
    place=json['place'];
    email=json['email'];
    role=json['role'];

  }
}
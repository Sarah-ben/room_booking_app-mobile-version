import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memoire_mobile/models/material_model/material_model.dart';
import '../../../shared/network/dio_helper.dart';
import 'material_states.dart';



class MaterialCubit extends Cubit<MaterialStates>{
  MaterialCubit( ) : super(AddInitialState());

  static MaterialCubit get(context)=>BlocProvider.of(context);
  // add material
 late MaterialModel materialModel;
 late MaterialData materialData;
  void addMaterial({
    required String  name,
    required String category,
  }){
    emit(AddLoadingState());
    DioHelper.postData(url: 'http://10.0.2.2:8000/api/addMaterial', data:{
      'category':category,
      'name':name,
    },).then((value)  {
      getMaterial();
      materialModel=MaterialModel.fromJson(value.data);
      print(materialModel.data!.name);
      emit(AddSuccessState());
    }).catchError((onError){
      print(onError);
      emit(AddErrorState(onError.toString()));
    });
  }

  //delete material
  void deleteMaterial(id,context){
    DioHelper.deleteData(url:'http://10.0.2.2:8000/api/deleteMateria/$id' ).then((value){
      getMaterial();
      print(value.data);// this shows that salle deleted that i put in my api
      emit(DeleteSuccessState());
    }).catchError((onError){
      emit(DeleteErrorState());
    });
  }

  //get all materials
  List<MaterialData> materials=[];
  void getMaterial(){
    materials=[];
    // print(classModel!.data!.name);
    emit(getDataState());
    DioHelper.getData(url: 'http://10.0.2.2:8000/api/getMaterial').then((value) {
      //print('hello world');
      print('data');
      // classModel=ClassModel.fromJson(value.data);
      print(value.data);
      value.data.forEach((e){
        materialData=MaterialData.fromJson(e);
        print(materialData.name);
        print(materialData.id);
        //print(data.id);
        materials.add(MaterialData.fromJson(e));
      });
      // this one worked fine
      /*salles=value.data;
      print(salles);
      print(value.data[0]);
       data=Data.fromJson(value.data[0]);
      print(data.name);*/


      // print(classModel);
      //salles.add(value.data);
      //print(value.data);
      //  salles=value.data;
      // print(salles.length);
      //print(s);
      /* s.forEach((element) {
      // print(element['id']);
      classModel=ClassModel.fromJson(element['id']);
      print(ClassModel.fromJson(element['id']));
     });*/
      //print(salles.length);
      //
      //print(salles[0][1]['name']);
      //print(salles[0][0]['name']);
      // salles.forEach((element) {
      // s=element.data();
      //  print(element);
      // classModel=ClassModel.fromJson(element);
      // s.add(element.data());
      // print('the sec list is $s');
      // });
      emit(GetSuccessState());
    }).catchError((onError){
      print(onError);
      //emit(GetErrorState());
    });
  }



}
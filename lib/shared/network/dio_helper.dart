import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

class DioHelper {
  static late final Dio dio;
  static init ()async{

    dio =  Dio(
        BaseOptions(
            baseUrl: 'http://10.0.2.2:8000/api/',
            receiveDataWhenStatusError: true,
            headers:{
              'Content-Type':'application/json',

//https://www.getpostman.com/collections/94db931dc503afd508a5
            }
    )
    );
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

  }

  static Future getData({required url, query,
    token})async{
    return await dio.get(url,queryParameters: query);
  }

  static Future deleteData({required url}){
    return dio.delete(url);
  }
  static Future updateData({required url,required data}){
    return dio.put(url, data: data);
  }

  static Future<Response> postData({
    required  url,
    query,
    required data,
    token
  })async{

    return  dio.post(url,
        queryParameters: query,
        data: data
    );
  }
}
import 'dart:convert';
import 'dart:core';
import 'dart:core';
import 'package:dbsync_app/Model/NameModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../database_helper.dart';



class SendNameProvider with ChangeNotifier {
  List<NameModel> _items = [];
  final dbHelper = DatabaseHelper.instance;
  List<NameModel> get items {
    return [..._items];
  }



  Future<void> addName(text,_connectionStatus) async {
    print(text.toString());
    int a = 1;
    print(_connectionStatus.toString());
    try {
      if(_connectionStatus == true){
        Response response = await Dio().post('http://192.168.42.175/SqliteSync/saveName.php',
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          }),
          data:  jsonEncode(<String, dynamic>{
            "name": text.toString(),
            "status": a
          }),
        );
        // final http.Response response = await http.post(
        //   ' http://localhost/SqliteSync/saveName.php',
        //   headers: <String, String>{
        //     'Content-Type': 'application/json; charset=UTF-8',
        //   },
        //   body: jsonEncode(<String, dynamic>{
        //     "name": text.toString(),
        //     "status": a
        //   }),
        // );
        if (response.statusCode == 200) {
          String body = response.statusMessage;
          print(body);
          Map<String, dynamic> row = {
            DatabaseHelper.columnName : text.toString(),
            DatabaseHelper.status : 1,
          };
           await dbHelper.insert(row);
        } else {
          print('Request failed with status: ${response.statusCode}.');
        }
      }else{
        Map<String, dynamic> row = {
          DatabaseHelper.columnName : text.toString(),
          DatabaseHelper.status : 0,
        };
        final id = await dbHelper.insert(row);
        print('inserted row id: $id');
      }

      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }





  Future<void> sync(text,_connectionStatus) async {
    print(text.toString());
    int a = 1;
    print(_connectionStatus.toString());
    try {
      if(_connectionStatus == true){
        Response response = await Dio().post('http://192.168.42.175/SqliteSync/saveName.php',
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          }),
          data:  jsonEncode(<String, dynamic>{
            "name": text.toString(),
            "status": a
          }),
        );
        if (response.statusCode == 200) {
          String body = response.statusMessage;
          print(body);
        } else {
          print('Request failed with status: ${response.statusCode}.');
        }
      }else{

      }

      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
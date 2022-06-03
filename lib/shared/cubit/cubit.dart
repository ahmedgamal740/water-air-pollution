
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollution/shared/cubit/states.dart';
import 'package:http/http.dart' as http;
import '../../models/all_record_model.dart';
import '../../models/sensor_model.dart';
import '../../models/user_model.dart';
import '../../modules/circle_chart.dart';
import '../../modules/profile_screen.dart';
import '../../modules/save_screen.dart';
import '../components/global_variable.dart';
import '../network/end_points.dart';
import '../network/remote/dio_helper.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppInitialState());
  int currentIndex = 1;
  List<Widget> screens = [
    ProfileScreen(),
    const CircleChartScreen(),
    SaveScreen(),
  ];
  List<String> titles = [
    'Profile',
    'Home',
    'Save',
  ];
  static AppCubit get(context) => BlocProvider.of(context);
  void changeBottomNav(int index){
    currentIndex = index;
    emit(AppChangeBottomNavigationBar());
  }


  void getUser(){
    emit(GetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      print(value.data());
      userModel = UserModel.fromJson(value.data());
      emit(GetUserSuccessState(userModel!.uId!));
    }).catchError((error) {
      print(error.toString());
      emit(GetUserErrorState(error.toString()));
    });
  }
  SensorModel? phMeterModel;
  void getLastPhmeterData(){
    emit(GetLastPhmeterDataLoading());
    DioHelper.getData(
      url: baseUrlPh,
      query: {
        'x-aio-key':baseKey,
      }
    ).then((value){
      //print(value.data);
      phMeterModel = SensorModel.fromJson(value.data);
      emit(GetLastPhmeterDataSuccess());
    }).catchError((error){
      print(error.toString());
      emit(GetLastPhmeterDataError(error.toString()));
    });
  }

  SensorModel? turbidityModel;
  void getLastTurbidityData(){
    emit(GetLastTurbidityDataLoading());
    DioHelper.getData(
        url: baseUrlTurbidity,
        query: {
          'x-aio-key':baseKey,
        }
    ).then((value){
      print('turbidiy ${value.data}');
      turbidityModel = SensorModel.fromJson(value.data);
      emit(GetLastTurbidityDataSuccess());
    }).catchError((error){
      print(error.toString());
      emit(GetLastTurbidityDataError(error.toString()));
    });
  }

  SensorModel? gasModel;
  void getLastGasData(){
    emit(GetLastGasDataLoading());
    DioHelper.getData(
        url: baseUrlGas,
        query: {
          'x-aio-key':baseKey,
        }
    ).then((value){
      print('GAs ${value.data}');
      gasModel = SensorModel.fromJson(value.data);
      emit(GetLastGasDataSuccess());
    }).catchError((error){
      print(error.toString());
      emit(GetLastGasDataError(error.toString()));
    });
  }

  SensorModel? soundModel;
  void getLastSoundData(){
    emit(GetLastSoundDataLoading());
    DioHelper.getData(
        url: baseUrlSound,
        query: {
          'x-aio-key':baseKey,
        }
    ).then((value){
      print('Sound ${value.data}');
      soundModel = SensorModel.fromJson(value.data);
      emit(GetLastSoundDataSuccess());
    }).catchError((error){
      print(error.toString());
      emit(GetLastSoundDataError(error.toString()));
    });
  }
  List<AllRecordModel> parsePhotos(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<AllRecordModel>((json) => AllRecordModel.fromJson(json)).toList();
  }

  Future<List<AllRecordModel>> fetchRecords(http.Client client,{required String nameSensor}) async {
    final response = await client
        .get(Uri.parse(nameSensor));

    //print(response.body);
    // Use the compute function to run parsePhotos in a separate isolate.
    return parsePhotos(response.body);
  }
  // List<AllRecordModel> allRecordModel = [];
  //  void getPhMeterDetails(){
  //   emit(GetPhMeterDetailsLoading());
  //   DioHelper.getData(
  //       url: 'v2/fisherman2022/feeds/phmeter/data',
  //       query: {
  //         'x-aio-key':baseKey,
  //       }
  //   ).then((value){
  //     final parsed = jsonDecode(value.data).cast<Map<String, dynamic>>();
  //     parsed.map<AllRecordModel>((json) {
  //       allRecordModel.add(AllRecordModel.fromJson(json));
  //     });
  //     print(allRecordModel.first.value);
  //     emit(GetPhMeterDetailsSuccess());
  //   }).catchError((error){
  //     print(error.toString());
  //     emit(GetPhMeterDetailsError(error.toString()));
  //   });
  // }
  // bool isPh = false;
  // void changePh(){
  //   isPh = true;
  //   emit(AppChangeModeState());
  // }

  // bool isDark = false;
  // void changeMode({bool? fromShared}){
  //   if(fromShared != null){
  //     isDark = fromShared;
  //     emit(AppChangeModeState());
  //   }
  //   else{
  //     isDark = !isDark;
  //     CacheHelper.putBoolean(
  //       key: 'isDark',
  //       value: isDark,
  //     ).then((value) {
  //       emit(AppChangeModeState());
  //     });
  //   }
  //
  // }
}
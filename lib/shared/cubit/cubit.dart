
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollution/shared/cubit/states.dart';
import 'package:http/http.dart' as http;
import '../../models/all_record_model.dart';
import '../../models/sensor_model.dart';
import '../../models/user_model.dart';
import '../../modules/home_screen.dart';
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
    const HomeScreen(),
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

    ).then((value){
      print('GAs ${value.data}');
      gasModel = SensorModel.fromJson(value.data);
      emit(GetLastGasDataSuccess());
    }).catchError((error){
      print(error.toString());
      emit(GetLastGasDataError(error.toString()));
    });
  }

  // late SensorModel gasModels;
  // Future getLastGas() async{
  //   emit(GetLastGasDataLoading());
  //   return await DioHelper.getData(
  //     url: baseUrlGas,
  //
  //   ).then((value){
  //     print('GAs ${value.data}');
  //     gasModel = SensorModel.fromJson(value.data);
  //     emit(GetLastGasDataSuccess());
  //   }).catchError((error){
  //     print(error.toString());
  //     emit(GetLastGasDataError(error.toString()));
  //   });
  //
  // }
  // Stream productsStream() async* {
  //   while (true) {
  //     await Future.delayed(const Duration(milliseconds: 500));
  //     // gasModels = getLastGas() as SensorModel;
  //     yield await getLastGas();
  //   }
  // }

  SensorModel? soundModel;
  void getLastSoundData(){
    emit(GetLastSoundDataLoading());
    DioHelper.getData(
        url: baseUrlSound,
    ).then((value){
      print('Sound ${value.data}');
      soundModel = SensorModel.fromJson(value.data);
      emit(GetLastSoundDataSuccess());
    }).catchError((error){
      print(error.toString());
      emit(GetLastSoundDataError(error.toString()));
    });
  }

  List<AllRecordModel> parseRecord(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<AllRecordModel>((json) => AllRecordModel.fromJson(json)).toList();
  }

  Future<List<AllRecordModel>> fetchRecords(http.Client client,{required String nameSensor}) async {
    final response = await client
        .get(Uri.parse(nameSensor));

    //print(response.body);
    // Use the compute function to run parsePhotos in a separate isolate.
    return parseRecord(response.body);
  }

  void addServoMotor({
    required int angleValue,
  }){
    emit(PostServoLoadingState());
    DioHelper.postData(
      url: servoMotor,
      data: {
        "angleValue": angleValue,

      },
    ).then((value) {
      emit(PostServoSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(PostServoErrorState(error.toString()));
    });
  }

  void addPushMotor({
    required int delay,
  }){
    emit(PostPushLoadingState());
    DioHelper.postData(
      url: pushMotor,
      data: {
        "delay": delay,

      },
    ).then((value) {
      emit(PostPushSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(PostPushErrorState(error.toString()));
    });
  }

}
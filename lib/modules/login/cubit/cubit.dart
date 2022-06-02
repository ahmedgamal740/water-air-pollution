import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pollution/modules/login/cubit/states.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../../models/user_model.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/components/global_variable.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../login_screen.dart';


class LoginCubit extends Cubit<LoginStates>{
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String phone,
    required String email,
    required String password,
  }){
    emit(RegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
    ).then((value) {
      uId = value.user!.uid;
      userCreate(
        name: name,
        phone: phone,
        email: email,
        uId: value.user!.uid,
      );
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String name,
    required String phone,
    required String email,
    required String uId,
  }){
    UserModel model = UserModel(
      name: name,
      email: email,
      phone: phone,
      image: baseImage,
      uId: uId,
    );
    FirebaseFirestore.instance.collection('users').doc(uId).set(
        model.toMap()
    ).then((value) {
      //emit(CreateSuccessState(model));
      getUser();
    }).catchError((error) {
      emit(CreateErrorState(error.toString()));
    });
  }

  void userLogin({
  required String email,
  required String password,
}){
    emit(LoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    ).then((value) {
      //emit(LoginSuccessState(value.user!.uid));
      uId = value.user!.uid;
      getUser();
    }).catchError((error){
      emit(LoginErrorState(error.toString()));
    });
  }

  void getUser(){
    //emit(GetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      print(value.data());
      userModel = UserModel.fromJson(value.data());
      emit(GetUserSuccessState(userModel!.uId!));
    }).catchError((error) {
      print(error.toString());
      emit(GetUserErrorState(error.toString()));
    });
  }

  void updateUser({
    required String name,
    required String phone,
    String? image,
  }) {
    emit(UpdateUserLoadingState());
    UserModel model = UserModel(
      name: name,
      email: userModel!.email,
      phone: phone,
      image: image??userModel!.image,
      uId: userModel!.uId,
    );
    FirebaseFirestore.instance.collection('users').doc(userModel!.uId).update(model.toMap()).then((value) {
      getUser();
    }).catchError((error) {
      emit(UpdateUserErrorState());
    });
  }

  File? profileImage;
  var picker = ImagePicker();
  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(ProfileImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(ProfileImagePickedErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
  }) {
    emit(UploadProfileImageLoadingState());
    firebase_storage.FirebaseStorage.instance.ref().child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!).then((value) {
          value.ref.getDownloadURL().then((value) {
            updateUser(
              name: name,
              phone: phone,
              image: value,
            );
            profileImage = null;
            }).catchError((error) {
              print(error.toString());
              emit(UploadProfileImageErrorState());
              });
          }).catchError((error) {
            emit(UploadProfileImageErrorState());
            });
  }

  void logout(context){
    emit(SignOutLoadingState());
    FirebaseAuth.instance.signOut().then((value) {
      CacheHelper.removeData(key: 'uId').then((value) {
        navigateAndFinish(
          context,
          LoginScreen(),
        );
        emit(SignOutSuccessState());
      });
    }).catchError((error) {
      emit(SignOutErrorState(error.toString()));
    });
  }
  bool isPassword = true;
  IconData suffix = Icons.visibility_off_rounded;
  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_off_rounded : Icons.visibility_rounded;
    emit(LoginChangePasswordVisibilityState());
  }
}
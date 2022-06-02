

import '../../../models/user_model.dart';

abstract class LoginStates{}
class LoginInitialState extends LoginStates{}
class LoginLoadingState extends LoginStates{}
//login
class LoginSuccessState extends LoginStates{
  final String uId;
  LoginSuccessState(this.uId);
}
class LoginErrorState extends LoginStates{
  final String error;
  LoginErrorState(this.error);
}

//change Bot Nav
class LoginChangePasswordVisibilityState extends LoginStates{}

// Sign up
class RegisterLoadingState extends LoginStates{}
class RegisterSuccessState extends LoginStates{
  // final ShopLoginModel registerModel;
  //
  // SocialRegisterSuccessState(this.registerModel);
}
class RegisterErrorState extends LoginStates{
  final String error;
  RegisterErrorState(this.error);
}
// get user
class GetUserLoadingState extends LoginStates{}
class GetUserSuccessState extends LoginStates{
  final String uId;
  GetUserSuccessState(this.uId);
}
class GetUserErrorState extends LoginStates{
  final String error;
  GetUserErrorState(this.error);
}

// image picker
class ProfileImagePickedSuccessState extends LoginStates{}
class ProfileImagePickedErrorState extends LoginStates{}

// update user
class UpdateUserLoadingState extends LoginStates{}
class UpdateUserSuccessState extends LoginStates{}
class UpdateUserErrorState extends LoginStates{}

// update user and image
class UploadProfileImageLoadingState extends LoginStates{}
class UploadProfileImageSuccessState extends LoginStates{}
class UploadProfileImageErrorState extends LoginStates{}

//create user
class CreateSuccessState extends LoginStates{
  final UserModel model;
  CreateSuccessState(this.model);
}
class CreateErrorState extends LoginStates{
  final String error;
  CreateErrorState(this.error);
}

// SignOut
class SignOutLoadingState extends LoginStates{}
class SignOutSuccessState extends LoginStates{}
class SignOutErrorState extends LoginStates{
  final String error;
  SignOutErrorState(this.error);
}


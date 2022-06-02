abstract class AppStates {}

class AppInitialState extends AppStates{}
class AppChangeBottomNavBar extends AppStates{}
class AppChangeModeState extends AppStates{}
class AppChangeBottomSheet extends AppStates{}
class AppChangeBottomNavigationBar extends AppStates{}
//get user
class GetUserLoadingState extends AppStates{}
class GetUserSuccessState extends AppStates{
  final String uId;
  GetUserSuccessState(this.uId);
}
class GetUserErrorState extends AppStates{
  final String error;
  GetUserErrorState(this.error);
}
//get last phmeter data
class GetLastPhmeterDataLoading extends AppStates{}
class GetLastPhmeterDataSuccess extends AppStates{}
class GetLastPhmeterDataError extends AppStates{
  final String error;
  GetLastPhmeterDataError(this.error);
}

//get last turbidity data
class GetLastTurbidityDataLoading extends AppStates{}
class GetLastTurbidityDataSuccess extends AppStates{}
class GetLastTurbidityDataError extends AppStates{
  final String error;
  GetLastTurbidityDataError(this.error);
}

//get last sound data
class GetLastSoundDataLoading extends AppStates{}
class GetLastSoundDataSuccess extends AppStates{}
class GetLastSoundDataError extends AppStates{
  final String error;
  GetLastSoundDataError(this.error);
}

//get last gas data
class GetLastGasDataLoading extends AppStates{}
class GetLastGasDataSuccess extends AppStates{}
class GetLastGasDataError extends AppStates{
  final String error;
  GetLastGasDataError(this.error);
}
//get Details phmeter
class GetPhMeterDetailsLoading extends AppStates{}
class GetPhMeterDetailsSuccess extends AppStates{}
class GetPhMeterDetailsError extends AppStates{
  final String error;
  GetPhMeterDetailsError(this.error);
}



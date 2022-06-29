import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollution/layout/layout_screen.dart';
import 'package:pollution/modules/login/cubit/cubit.dart';
import 'package:pollution/shared/components/global_variable.dart';
import 'package:pollution/shared/cubit/bloc_observer.dart';
import 'package:pollution/shared/cubit/cubit.dart';
import 'package:pollution/shared/cubit/states.dart';
import 'package:pollution/shared/network/local/cache_helper.dart';
import 'package:pollution/shared/network/remote/dio_helper.dart';
import 'package:pollution/shared/styles/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'modules/login/login_screen.dart';
import 'modules/on_boarding/on_boarding_screen.dart';

void main() {
  BlocOverrides.runZoned(
        ()async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        //options: DefaultFirebaseOptions.currentPlatform,
      );
      DioHelper.init();
      await CacheHelper.init();
      Widget widget;
      //bool? isDark = CacheHelper.getData(key: 'isDark');
      bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
      uId = CacheHelper.getData(key: 'uId');
      if(onBoarding != null){
        if(uId != null){
          widget = const LayoutScreen();
        }else{
          widget = LoginScreen();
        }
      }else{
        widget = const OnBoardingScreen();
      }
      runApp(MyApp(startWidget: widget));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  Widget? startWidget;
  MyApp({Key? key, this.startWidget}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (BuildContext context) => LoginCubit()..getUser()),
          BlocProvider(create: (BuildContext context) => AppCubit()..getLastPhmeterData()..getLastGasData()..getLastSoundData()..getLastTurbidityData()..getUser()),
        ],
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              themeMode: ThemeMode.light,
              home: startWidget,
            );
          },
        ),
    );
  }
}

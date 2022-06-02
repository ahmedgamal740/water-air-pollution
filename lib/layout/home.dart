import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollution/shared/cubit/cubit.dart';
import 'package:pollution/shared/cubit/states.dart';
import '../shared/components/constants.dart';
import '../shared/components/global_variable.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
            appBar: AppBar(
              title: Text(
                cubit.titles[cubit.currentIndex],
              ),
              actions: [
                if(userModel != null)
                  CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(userModel!.image!),
                ),
                if(userModel != null)
                  defaultWidthSizeBox,
                // IconButton(onPressed: (){navigatorTo(context,  const LineChartSample2());}, icon: const Icon(Icons.add))
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: CircleNavBar(
              activeIcons: const [
                Icon(Icons.person, color: Colors.deepPurple),
                Icon(Icons.home, color: Colors.deepPurple),
                Icon(Icons.save, color: Colors.deepPurple),
              ],
              inactiveIcons: const [
                Text("Profile"),
                Text("Home"),
                Text("Save"),
              ],
              color: Colors.white,
              height: 60,
              circleWidth: 60,
              initIndex: cubit.currentIndex,
              onChanged: (v) {
                cubit.changeBottomNav(v);
              },
              // tabCurve: ,
              // padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
              cornerRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(24),
                bottomLeft: Radius.circular(24),
              ),
              shadowColor: Colors.deepPurple,
              elevation: 5,
            ));
      },
    );
  }
}

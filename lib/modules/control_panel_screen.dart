import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/components/components.dart';
import '../shared/components/constants.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';
import '../shared/styles/colors.dart';

class ControlPanelScreen extends StatelessWidget {
  ControlPanelScreen({Key? key}) : super(key: key);
  var secondsController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        // var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Control Panel'
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text(
                  'Push Motor',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                defaultHeightSizeBox15,
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 2,
                          color: Colors.black38
                      ),
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey[300]
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        defaultFormField(
                          controller: secondsController,
                          type: TextInputType.number,
                          validate: (value){
                            if(value.isEmpty){
                              return 'please enter your number';
                            }
                            return null;
                          },
                          label: 'Seconds',
                          prefix: Icons.access_time_outlined,
                        ),
                        defaultHeightSizeBox15,
                        defaultButton(
                            function: (){
                              if(formKey.currentState!.validate()){
                                AppCubit.get(context).addPushMotor(delay: int.parse(secondsController.text));
                              }
                            },
                            text: 'Go'
                        ),
                      ],
                    ),
                  ),
                ),
                defaultHeightSizeBox15,
                Text(
                  'Servo Motor',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                defaultHeightSizeBox15,
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 2,
                          color: Colors.black38
                      ),
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey[300]
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 10
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: (){
                          AppCubit.get(context).addServoMotor(angleValue: 90);
                        },
                        child: const CircleAvatar(
                          radius: 35,
                          backgroundColor: defaultColor,
                          child: Icon(
                            Icons.arrow_drop_up,
                            size: 70,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  [
                          InkWell(
                            onTap: (){
                              AppCubit.get(context).addServoMotor(angleValue: 135);
                            },
                            child: const CircleAvatar(
                              radius: 35,
                              backgroundColor: defaultColor,
                              child: Icon(
                                Icons.arrow_left,
                                size: 70,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 60,
                          ),
                          InkWell(
                            onTap: (){
                              AppCubit.get(context).addServoMotor(angleValue: 45);
                            },
                            child: const CircleAvatar(
                              radius: 35,
                              backgroundColor: defaultColor,
                              child: Icon(
                                Icons.arrow_right,
                                size: 70,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
import 'package:circle_chart/circle_chart.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollution/shared/components/global_variable.dart';
import 'package:pollution/shared/cubit/cubit.dart';
import 'package:pollution/shared/cubit/states.dart';
import '../shared/components/components.dart';
import '../shared/components/constants.dart';
import '../shared/styles/colors.dart';
import 'control_panel_screen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.phMeterModel != null && cubit.gasModel != null && cubit.soundModel != null && cubit.turbidityModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(userModel != null)
                    Row(
                      children: [
                        Text(
                          'Welcome ',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text(
                          '${userModel!.name}',
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: defaultColor,
                          ),
                        ),
                      ],
                    ),
                  if(userModel != null)
                    const SizedBox(
                      height: 30,
                    ),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            cubit.getLastPhmeterData();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: Colors.black38,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: chart(
                                name: 'Ph Meter',
                                maxNumber: 14,
                                progressNumber: cubit.phMeterModel!.value!.roundToDouble()
                            ),
                          ),
                        ),
                      ),
                      defaultWidthSizeBox,
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            cubit.getLastTurbidityData();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 2,
                                  color: Colors.black38
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: chart(
                                name: 'Turbidity',
                                maxNumber: 3500,
                                progressNumber: cubit.turbidityModel!.value?.toDouble()
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  defaultHeightSizeBox,
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            cubit.getLastSoundData();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: Colors.black38,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: chart(
                                name: 'Sound',
                                maxNumber: 1200,
                                progressNumber: cubit.soundModel!.value?.toDouble()
                            ),
                          ),
                        ),
                      ),
                      defaultWidthSizeBox,
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            cubit.getLastGasData();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 2,
                                  color: Colors.black38
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: chart(
                                name: 'Gas',
                                maxNumber: 500,
                                progressNumber: cubit.gasModel!.value?.toDouble()
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  defaultHeightSizeBox15,
                  defaultButton(
                      function: (){
                        navigatorTo(
                          context,
                          ControlPanelScreen(),
                        );
                      },
                      text: 'Control panel'
                  ),
                ],),
            ),
          ),
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}


Widget chart({
  required int maxNumber,
  double? progressNumber,
  required String name,
}) => CircleChart(
    progressNumber: progressNumber,
    maxNumber: maxNumber,
    height: 200,
    width: 300,
    progressColor: defaultColor,
    children:
    [
      const Icon(Icons.keyboard_arrow_up_outlined),
      defaultHeightSizeBox,
      Text(
        name,
        style: const TextStyle(
          color: defaultColor,
          fontWeight: FontWeight.bold
        ),
      ),
      defaultHeightSizeBox,
    ]
);


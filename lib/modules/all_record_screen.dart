

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:pollution/shared/cubit/cubit.dart';
import 'package:pollution/shared/cubit/states.dart';
import '../models/all_record_model.dart';
import '../shared/components/constants.dart';
import '../shared/styles/colors.dart';

class AllRecordsScreen extends StatelessWidget {
  String name;
  AllRecordsScreen({Key? key, required this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('All Records'),
          ),
          body: FutureBuilder<List<AllRecordModel>>(
            future: AppCubit.get(context).fetchRecords(http.Client(),nameSensor:  name),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('An error has occurred!'),
                );
              } else if (snapshot.hasData) {
                // List modelValue = [];
                // snapshot.data!.forEach((element) {
                //   modelValue.addAll(element.value!);
                // });
                return RecordList(
                    model: snapshot.data!,
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        );
      },
    );
  }
}

class RecordList extends StatelessWidget {

  final List<AllRecordModel> model;

  RecordList({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) => buildRecordItem(context, model[index] ),
        separatorBuilder: (context, index) => const SizedBox(),
        itemCount: model.length);
  }
  Widget buildRecordItem(context, AllRecordModel model) => Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(
      children: [
        Expanded(
          child: Container(
          height: 110,
          decoration: BoxDecoration(
            borderRadius:const BorderRadiusDirectional.only(
                topStart:Radius.circular(4),
                bottomStart: Radius.circular(5)
          ),
          border: Border.all(color:borderColor,width: 1 ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 10.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Text(
                        'Name: ',
                        style: TextStyle(
                          color: greyTextColor,
                        ),
                      ),
                      defaultWidthSizeBox,
                      Text(
                        '${model.sensorName}',
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: textColor
                        ),
                      ),
                    ],
                  ),
                ),
                defaultHeightSizeBox,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Text(
                        'Create at: ',
                        style: TextStyle(
                          color: greyTextColor,
                        ),
                      ),
                      defaultWidthSizeBox,
                      Expanded(
                        child: Text(
                          '${model.dateTime}',
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: textColor
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //defaultHeightSizeBox,
              ],
            ),
          ),
      ),
        ),
        Container(
          height: 110,
          width: 90,
          decoration: BoxDecoration(
            borderRadius:const BorderRadiusDirectional.only(
                topEnd:Radius.circular(4),
                bottomEnd: Radius.circular(5),
            ) ,
            border: Border.all(color:borderColor,width: 1 ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 3
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //sound sensor
                if(model.sensorName == 'Sound' && model.value! > 100)
                  Text(
                  '${model.value}',
                  style: const TextStyle(
                    color: primaryColor1,
                      fontWeight: FontWeight.bold
                  ),
                ),
                if(model.sensorName == 'Sound' && model.value! <= 100)
                  Text(
                    '${model.value}',
                    style: const TextStyle(
                      color: primaryColor2,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                //phmeter sensor
                if(model.sensorName == 'PhMeter' && (model.value! >= 5 && model.value! < 10))
                  Text(
                    '${model.value!.roundToDouble()}',
                    style: const TextStyle(
                      color: primaryColor2,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                if(model.sensorName == 'PhMeter' && (model.value! >= 10 && model.value! >= 5))
                  Text(
                    '${model.value!.roundToDouble()}',
                    style: TextStyle(
                      color: primaryColor3,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                if(model.sensorName == 'PhMeter' && model.value! < 5)
                  Text(
                    '${model.value!.roundToDouble()}',
                    style: const TextStyle(
                      color: primaryColor1,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                //gas sensor
                if(model.sensorName == 'Gaz' && model.value! > 300)
                  Text(
                    '${model.value}',
                    style: const TextStyle(
                        color: primaryColor1,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                if(model.sensorName == 'Gaz' && model.value! <= 300)
                  Text(
                    '${model.value}',
                    style: const TextStyle(
                        color: primaryColor2,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                //turbidity sensor
                if(model.sensorName == 'Turbidity' && model.value! > 700)
                  Text(
                    '${model.value}',
                    style: const TextStyle(
                        color: primaryColor1,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                if(model.sensorName == 'Turbidity' && model.value! <= 700)
                  Text(
                    '${model.value}',
                    style: const TextStyle(
                        color: primaryColor2,
                        fontWeight: FontWeight.bold
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}


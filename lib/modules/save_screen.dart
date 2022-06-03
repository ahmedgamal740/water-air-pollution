import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollution/modules/phmeter_screen.dart';
import 'package:pollution/shared/cubit/cubit.dart';
import 'package:pollution/shared/cubit/states.dart';
import 'package:pollution/shared/styles/colors.dart';
import 'package:http/http.dart' as http;

import '../shared/components/components.dart';
import '../shared/network/end_points.dart';
class BoardingModel{
  late final String image;
  late final String title;
  late final String nameSensor;
  BoardingModel(
      this.image,
      this.title,
      this.nameSensor,
      );

}
class SaveScreen extends StatelessWidget {
  SaveScreen({Key? key}) : super(key: key);

  List<BoardingModel> board = [
    BoardingModel(
      'assets/images/gas.jpg',
      'Gas Records',
      gasRecords,
    ),
    BoardingModel(
      'assets/images/sound.jpg',
      'Sound Records',
        soundRecords,
    ),
    BoardingModel(
      'assets/images/ph.jpg',
      'Ph Meter Records',
        phRecords,
    ),
    BoardingModel(
      'assets/images/turbidity.jpg',
      'Turbidity Records',
        turbidityRecords,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
          return ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => buildCatItem(context, board[index]),
          separatorBuilder: (context, index) => myDivider(),
          itemCount: 4);
          },
    );
  }
  Widget buildCatItem(context,BoardingModel model) => Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(
      children: [
        Image(
          image: AssetImage(model.image),
          height: 160,
          width: 145,
          fit: BoxFit.cover,
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Text(
            model.title,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        IconButton(
          onPressed: (){
            AppCubit.get(context).fetchRecords(
              http.Client(),
              nameSensor: model.nameSensor,
            );
            navigatorTo(context, AllRecordsScreen(name: model.nameSensor,));
          },
          icon: const Icon(
              Icons.arrow_forward_ios_outlined,
              color: defaultColor,
          ),
        ),
      ],
    ),
  );
}

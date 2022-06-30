import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../styles/colors.dart';
Widget defaultFallback({
  required String text,
}) => Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Icon(
        Icons.menu_outlined,
        size: 100,
        color: Colors.grey,
      ),
      Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    ],
  ),
);

Widget defaultButton({
  double width = double.infinity,
  Color background = defaultColor,
  required VoidCallback function,
  required String text,
  bool isUpper = true,
  double radius = 10,
}) => Container(
  width: width,
  height: 45,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    color: background,
  ),

  child: MaterialButton(
    onPressed: function,
    child: Text(
      isUpper ? text.toUpperCase() : text,
      style: const TextStyle(
        color: Colors.white,
      ),
    ),
  ),
);
Widget defaultTextButton({
  required VoidCallback? function,
  required String text,
}) => TextButton(
    onPressed: function,
    child: Text(
      text.toUpperCase(),
    ),
);

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  ValueChanged? onSubmit,
  ValueChanged? onChange,
  GestureTapCallback? onTap,
  required FormFieldValidator validate,
  bool isPassword = false,
  bool isEnabled = true,
  required String label,
  required IconData prefix,
  IconData? suffix,
  VoidCallback? suffixPressed,
}) => TextFormField(
  controller: controller,
  enabled: isEnabled,
  keyboardType: type,
  onFieldSubmitted: onSubmit,
  onChanged: onChange,
  onTap: onTap,
  validator: validate,
  obscureText: isPassword,
  decoration: InputDecoration(
    label: Text(
      label,
    ),
    prefixIcon: Icon(
      prefix,
    ),
    suffixIcon: IconButton(
      onPressed: suffixPressed,
      icon: Icon(
        suffix,
      ),
    ),
    border: const OutlineInputBorder(),
  ),
);


Widget myDivider() => Padding(
  padding: const EdgeInsets.symmetric(
    horizontal: 10,
  ),
  child: Container(
    width: double.infinity,
    height: 1,
    color: Colors.grey[300],
  ),
);

void navigatorTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
      builder: (context) => widget),
);
void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
        builder: (context) => widget),
    (route) => false,
);

void showToast(context, {
  required String message,
  required ToastStates state,
}){
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0
  );
}

enum ToastStates{success, error, warning}
Color chooseToastColor(ToastStates state){
  Color color;
  switch(state){
    case ToastStates.success:
      color = Colors.green;
      break;
    case ToastStates.error:
      color = Colors.red;
      break;
    case ToastStates.warning:
      color = Colors.yellow;
      break;
  }
  return color;
}


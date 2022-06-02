import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollution/modules/login/cubit/cubit.dart';
import 'package:pollution/modules/login/cubit/states.dart';
import 'package:pollution/shared/styles/colors.dart';
import '../shared/components/components.dart';
import '../shared/components/constants.dart';
import '../shared/components/global_variable.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {},
      builder: (context, state) {
        nameController.text = userModel!.name!;
        phoneController.text = userModel!.phone!;
        emailController.text = userModel!.email!;
        var profileImage = LoginCubit.get(context).profileImage;
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                if(state is UpdateUserLoadingState || state is UploadProfileImageLoadingState || state is SignOutLoadingState)
                  const LinearProgressIndicator(),
                if(state is UpdateUserLoadingState || state is UploadProfileImageLoadingState || state is SignOutLoadingState)
                  defaultHeightSizeBox,
                Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                     CircleAvatar(
                      radius: 67,
                      backgroundColor: defaultColor,
                      child: CircleAvatar(
                        radius: 65,
                        backgroundImage: profileImage == null ? NetworkImage('${userModel?.image}') : FileImage(profileImage) as ImageProvider,
                      ),
                    ),

                    CircleAvatar(
                      radius: 20,
                      child: IconButton(
                        iconSize: 18,
                        onPressed: (){
                          LoginCubit.get(context).getProfileImage();
                        },
                        icon: const Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                defaultHeightSizeBox15,
                defaultFormField(
                  controller: nameController,
                  type: TextInputType.name,
                  validate: (value){
                    if(value.isEmpty){
                      return 'please enter your name';
                    }
                    return null;
                  },
                  label: 'User Name',
                  prefix: Icons.person_outline_outlined,
                ),
                defaultHeightSizeBox15,
                defaultFormField(
                  controller: phoneController,
                  type: TextInputType.phone,
                  validate: (value){
                    if(value.isEmpty){
                      return 'please enter your phone';
                    }
                    return null;
                  },
                  label: 'Phone',
                  prefix: Icons.phone_outlined,
                ),
                defaultHeightSizeBox15,
                defaultFormField(
                  controller: emailController,
                  isEnabled: false,
                  type: TextInputType.emailAddress,
                  validate: (value){
                    if(value.isEmpty){
                      return 'please enter your email address';
                    }
                    return null;
                  },
                  label: 'Email Address',
                  prefix: Icons.email_outlined,
                ),
                defaultHeightSizeBox15,
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: (){
                          if(formKey.currentState!.validate()){
                            if(profileImage != null){
                              LoginCubit.get(context).uploadProfileImage(
                                name: nameController.text,
                                phone: phoneController.text,
                              );
                            }else{
                              LoginCubit.get(context).updateUser(
                                name: nameController.text,
                                phone: phoneController.text,
                              );
                            }
                          }
                        },
                        child: const Text(
                            'Update'
                        ),
                      ),
                    ),
                    defaultWidthSizeBox,
                    OutlinedButton(
                      onPressed: (){
                        LoginCubit.get(context).logout(context);
                      },
                      child: const Icon(
                        Icons.logout_outlined,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

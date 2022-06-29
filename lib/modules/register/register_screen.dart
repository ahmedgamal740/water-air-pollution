import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/components/components.dart';
import '../../layout/layout_screen.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/styles/colors.dart';
import '../login/cubit/cubit.dart';
import '../login/cubit/states.dart';



class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if(state is GetUserSuccessState){
          CacheHelper.saveData(
            key: 'uId',
            value: state.uId,
          ).then((value) {
            navigateAndFinish(
              context,
              const LayoutScreen(),
            );
          });
        }
        if(state is RegisterErrorState){
          showToast(
            context,
            message: state.error,
            state: ToastStates.error,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/images/log.png'),
                ),
                defaultWidthSizeBox,
                Text(
                  'Pollution Detection',
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: Colors.white
                  ),
                ),
              ],
            ),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Text(
                        'SIGN UP',
                        style: Theme.of(context).textTheme.headline4?.copyWith(
                            color: defaultColor
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
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
                      defaultFormField(
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        validate: (value){
                          if(value.isEmpty){
                            return 'password is short';
                          }
                          return null;
                        },
                        label: 'Password',
                        prefix: Icons.lock_outlined,
                        suffix: LoginCubit.get(context).suffix,
                        isPassword: LoginCubit.get(context).isPassword,
                        suffixPressed: (){
                          LoginCubit.get(context).changePasswordVisibility();
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ConditionalBuilder(
                        condition: state is! RegisterLoadingState,
                        builder: (context) => defaultButton(
                            function: (){
                              if(formKey.currentState!.validate()){
                                LoginCubit.get(context).userRegister(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  email: emailController.text.trim(),
                                  password: passwordController.text,
                                );
                              }
                            },
                            text: 'signup'
                        ),
                        fallback: (context) => const Center(child: CircularProgressIndicator()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

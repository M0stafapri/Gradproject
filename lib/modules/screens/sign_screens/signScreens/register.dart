import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simpleui/layout/cubit/layout_cubit.dart';
import 'package:simpleui/layout/layout_screen.dart';
import 'package:simpleui/modules/widgets/snackBar_widget.dart';
import '../../../../shared/style/colors.dart';
import '../../../widgets/alert_dialog_widget.dart';
import '../../../widgets/buttons_widget.dart';
import '../cubit/signCubit.dart';
import '../cubit/signStates.dart';
import 'login.dart';

class RegisterScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final userNameController = TextEditingController();
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignCubit,SignStates>(
        listener: (context,state)
        {
          if(state is CreateUserErrorState )
          {
            ScaffoldMessenger.of(context).showSnackBar(snackBarWidget(message: state.error.toString(), context: context, color: Colors.red));
          }
          if(state is SaveUserDataErrorState)
          {
            ScaffoldMessenger.of(context).showSnackBar(snackBarWidget(message: state.error.toString(), context: context, color: Colors.red));
          }
          if( state is CreateUserLoadingState )
          {
            {
              showAlertDialog(
                  context: context,
                  content: Column(
                    mainAxisSize:MainAxisSize.min,
                    mainAxisAlignment:MainAxisAlignment.center,
                    children:
                    [
                      CircularProgressIndicator(color: mainColor,),
                      const SizedBox(height: 10,),
                      const Text("Loading...",style: TextStyle(color: mainColor,fontSize: 16),),
                    ],
                  )
              );
            }
          }
          if(state is SaveUserDataSuccessState)
          {
            LayoutCubit.getInstance(context).getMyData().then((value){
              Navigator.pop(context);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const HomeLayoutScreen()));
            });
          }
        },
        builder: (context,state){
          final cubit = SignCubit.get(context);
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 50),
                      Text(
                        'Create Account',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: mainColor,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Center(
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Container(
                              height: 125,
                              width: 125,
                              clipBehavior: Clip.hardEdge,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: mainColor,
                              ),
                            ),
                            Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Container(
                                  height: 120,
                                  width: 120,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: whiteColor,
                                  ),
                                  child: cubit.userImageFile != null
                                      ? Image(image: FileImage(cubit.userImageFile!))
                                      : const Text(""),
                                ),
                                InkWell(
                                  onTap: () {
                                    cubit.getUserImageFile();
                                  },
                                  child: const CircleAvatar(
                                    backgroundColor: mainColor,
                                    maxRadius: 15,
                                    child: Icon(
                                      Icons.photo_camera,
                                      color: whiteColor,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            textFieldItem(
                                userNameController, "Username", Icons.person),
                            const SizedBox(height: 20),
                            textFieldItem(
                                phoneController, "Phone Number", Icons.phone),
                            const SizedBox(height: 20),
                            textFieldItem(
                                emailController, "Email", Icons.email),
                            const SizedBox(height: 20),
                            textFieldItem(
                                passwordController, "Password", Icons.password,
                                isSecure: true),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      defaultButton(
                        contentWidget: state is CreateUserLoadingState
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                    color: whiteColor),
                              )
                            : const Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: whiteColor,
                                  fontSize: 16,
                                ),
                              ),
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            if (cubit.userImageFile != null &&
                                formKey.currentState!.validate()) {
                              cubit.createUser(
                                  userName: userNameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phoneNumber: phoneController.text);
                            } else if (cubit.userImageFile == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  snackBarWidget(
                                      message:
                                          'Choose an Image and try again!',
                                      context: context,
                                      color: Colors.grey.withOpacity(1)));
                            }
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account? ',
                            style: TextStyle(fontSize: 16),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                            },
                            child: const Text(
                              'Sign In',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: mainColor),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }

  Widget textFieldItem(TextEditingController controller,String title,IconData iconData,{bool isSecure=false}){
    return TextFormField(
      controller: controller,
      obscureText: isSecure,
      validator: (val)
      {
        return controller.text.isEmpty ? "$title must not be empty" : null ;
      },
      decoration: InputDecoration(
        labelText: title,
        prefixIcon: Icon(iconData),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
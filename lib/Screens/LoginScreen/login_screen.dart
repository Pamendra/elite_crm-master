// ignore_for_file: use_build_context_synchronously

import 'package:elite_crm/Utils/TextWidgets.dart';
import 'package:elite_crm/Utils/gradient_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../Bloc/Login_Bloc/LoginBloc.dart';
import '../../Bloc/Login_Bloc/LoginEvent.dart';
import '../../Bloc/Login_Bloc/LoginState.dart';
import '../../Utils/SizedSpace.dart';
import '../../Utils/color_constants.dart';
import '../../Utils/drawer_login.dart';
import '../../Utils/setget.dart';
import '../Splash_Screen/splash_screen.dart';
import '../bottomNavigationPages.dart';
import '../registrationPage.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _passwordVisible = false;
  bool isLoading = false;




  void showLoaderDialog(BuildContext context) {
    setState(() {
      isLoading = true;
    });
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(

          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          side: BorderSide(
              color: ColorConstants.deppp, width: 2
          )),
      backgroundColor: ColorConstants.DarkBlueColor,
      content: Row(
       // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            color: Colors.deepOrange,
          ),
          const SizedBox(width: 10,),
          Container(
            margin: const EdgeInsets.only(left: 7),
            child:  Text("Loading...",style: TextStyle(color: ColorConstants.white),),
          ),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void hideLoaderDialog(BuildContext context) {
    setState(() {
      isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;


  }



  @override
  Widget build(BuildContext context) {

    return BlocProvider(
        create: (context) => LoginBloc(),
    child: Scaffold(
    drawer: DrawerLogin(),
      appBar: AppBar(

          backgroundColor: ColorConstants.deppp),
      body: Container(
        height: 100.h,
        decoration: gradient_login,
        child: BlocConsumer<LoginBloc,LoginState>(
        listener: (context,state){
          if(state is LoginSuccessState){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> const Homepage()), (route) => false);
          }else if(state is LoginErrorState){

              Fluttertoast.showToast(msg: 'Login Failed');
              hideLoaderDialog(context);

          }
        },builder: (context,state){
         return Container(
           // height: 100.h,
           // width: 100.w,
           // decoration: DecorationConstants.decorationGradient,
           child: Padding(
             padding: const EdgeInsets.only(right: 20,left: 20),
             child: SingleChildScrollView(
               scrollDirection: Axis.vertical,
               child: Column(
                 children: [
                    const SizedBox(height: 150,),
                   Padding(
                     padding: const EdgeInsets.all(10.0),
                     child: Image.asset('assets/images/logo.png'),
                   ),

                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: TextFormField(
                       controller: emailController,
                       decoration: InputDecoration(
                           hintText: 'Username or UserID',
                           fillColor: Colors.white,
                           filled: true,
                           focusedBorder:  OutlineInputBorder(
                             borderSide: BorderSide(
                               color:ColorConstants.deppp,style: BorderStyle.solid
                             )
                           ),
                           suffixIcon:  Icon(Icons.person,color: ColorConstants.deppp,),
                           border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(5))),
                     ),
                   ),
                   const SizedBox(height: 20),

                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: TextFormField(
                       controller: passwordController,
                       obscureText: !_passwordVisible,
                       decoration: InputDecoration(
                           hintText: 'Password',
                           fillColor: Colors.white,
                           filled: true,
                           focusedBorder:  OutlineInputBorder(
                               borderSide: BorderSide(
                                   color: ColorConstants.deppp,style: BorderStyle.solid
                               )
                           ),
                           suffixIcon: IconButton(
                             icon: Icon(
                               _passwordVisible
                                   ? Icons.visibility
                                   : Icons.visibility_off,
                               color:ColorConstants.deppp,
                             ),
                             onPressed: () {
                               setState(() {
                                 _passwordVisible = !_passwordVisible;
                               });
                             },
                           ),
                           border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(5))),
                     ),
                   ),
                   const SizedBox(height: 10,),
                   Padding(
                     padding: const EdgeInsets.only(right: 10),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.end,
                       children: const [
                         Text('Forget Password?',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)
                       ],
                     ),
                   ), const SizedBox(height: 10,),
                   SizedBox(width: 350,height: 50,
                       child: ElevatedButton(onPressed: () async {
                         if (emailController.text.isEmpty) {
                           // Dialogs.showValidationMessage(context,
                           //     MessageConstants.emailEmptyValidation);
                           showDialog(
                               context: context,
                               builder: (BuildContext context){
                                 return  AlertDialog(
                                   shape: RoundedRectangleBorder(

                                       borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                       side: BorderSide(
                                           color: ColorConstants.deppp, width: 2
                                       )),
                                   backgroundColor: ColorConstants.DarkBlueColor,
                                    title: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Message",style: TextStyle(color: Colors.white)),
                                        InkWell(
                                            onTap: (){
                                              Navigator.pop(context);
                                            },
                                            child: const Icon(Icons.close,color: Colors.white,))
                                      ],
                                    ),
                                   content: const Text("Please enter username",style: TextStyle(color: Colors.white),),
                                 );
                               }
                           );
                         } else if (passwordController.text.isEmpty) {
                           // Dialogs.showValidationMessage(context,
                           //     MessageConstants.passwordEmptyValidation);
                           showDialog(
                               context: context,
                               builder: (BuildContext context){
                                 return  AlertDialog(
                                   shape: RoundedRectangleBorder(

                                       borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                       side: BorderSide(
                                           color: ColorConstants.deppp, width: 2
                                       )),
                                   backgroundColor: ColorConstants.DarkBlueColor,
                                   title: Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children: [
                                       const Text("Message",style: TextStyle(color: Colors.white)),
                                       InkWell(
                                           onTap: (){
                                             Navigator.pop(context);
                                           },
                                           child: const Icon(Icons.close,color: Colors.white,))
                                     ],
                                   ),
                                   content: const Text("Please enter password",style: TextStyle(color: Colors.white)),
                                 );
                               }
                           );
                         } else  {
                           BlocProvider.of<LoginBloc>(context).add(
                               LoginPressedEvent(emailController.text, passwordController.text));
                           showLoaderDialog(context);
                           Utils().setUsername(emailController.text);
                           var sharedpref = await SharedPreferences.getInstance();
                           sharedpref.setBool(SplashScreenState.KEYLOGIN, true);
                         }
                       },style: ElevatedButton.styleFrom(
                           backgroundColor: ColorConstants.deppp
                       ), child: const Text('Sign in'))),
                   SmallSpace(),
                   Padding(
                     padding: const EdgeInsets.only(right: 10),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.end,
                       children:  [
                         InkWell(
                           onTap: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context) => const registration_page()));
                           },
                           child:  headingTextwithsmallwhite2(title: 'Create new ?',),
                         )
                       ],
                     ),
                   )
                 ],
               ),
             ),
           ),
         );
        },
        ),
      ))
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memoire_mobile/modules/login/cubit/cubit.dart';
import 'package:memoire_mobile/modules/login/cubit/states.dart';
import 'package:memoire_mobile/modules/register/register_mobile.dart';
import '../../main_layout/admin_home_layout.dart';
import '../../main_layout/user_home_layout.dart';
import '../../shared/components/mobile_components.dart';
import '../../shared/components/mobile_constants.dart';
import '../../shared/network/cache_helper.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit,LoginStates>(builder: (BuildContext context, state) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize:const Size.fromHeight(200),
          child: AppBar(
            backgroundColor: Colors.white,
            title:const Text('Login',style: TextStyle(color: Colors.white,fontSize: 25.0),),
            flexibleSpace: CustomPaint(
              child: Container(
                height: 200.0,
              ),
              painter: CurvePainter(),
            ) ,
          ),
        ),
        body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SizedBox(
                width: getWidth(context),
                height: getHeight(context),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      verticalSizedBox( 30.0,),
                      customTextField( controller: emailController,label: 'Email', icon: Icons.alternate_email, textInputType: TextInputType.emailAddress
                        ,),
                      verticalSizedBox( 10.0,),
                      customTextField( controller: passwordController,label: 'Password', icon: Icons.lock_outline, textInputType: TextInputType.text,obscureText: true
                      ),
                      verticalSizedBox( 20.0,),
                     /* defaultTextButton(function: (){
                        navigateTo(context, RegisterScreen());
                      }, text: 'I don\'t have an account? Register'),*/
                      verticalSizedBox( 50.0,),
                      defaultButton(function: (){
                        if(formKey.currentState!.validate()){
                          if(state is! LoginLoadingState){
                            LoginCubit.get(context).userLogin(email: emailController.text, password: passwordController.text);
                          }
                        }

                        //navigateTo(context,const ClassWidgetMobile());
                      }, text: 'Enter')
                    ],
                  ),
                ),),
            )
        ),
      );
    }, listener: (BuildContext context,  state){
      if (state is LoginSuccessState){
        CacheHelper.saveData(
            key: 'token', val: state.loginModel.token).then((value) =>print('${CacheHelper.getData(key: 'token')}')).
        then((value) => navigateTo(context,CacheHelper.getData(key: 'role')=='admin'? AdminHomeScreen():HomeLayout()));
      }
    },);
  }
}

// CUSTOM APP BAR SHAPE
class CurvePainter extends CustomPainter{
  Color colorOne = Colors.green.withOpacity(.6);
  Color? colorTwo = Colors.green[300];
  Color? colorThree = Colors.green[100];

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint();


    path.lineTo(0, size.height *0.75);
    path.quadraticBezierTo(size.width* 0.10, size.height*0.70,   size.width*0.17, size.height*0.90);
    path.quadraticBezierTo(size.width*0.20, size.height, size.width*0.25, size.height*0.90);
    path.quadraticBezierTo(size.width*0.40, size.height*0.40, size.width*0.50, size.height*0.70);
    path.quadraticBezierTo(size.width*0.60, size.height*0.85, size.width*0.65, size.height*0.65);
    path.quadraticBezierTo(size.width*0.70, size.height*0.90, size.width, 0);
    path.close();

    paint.color = colorThree!;
    canvas.drawPath(path, paint);

    path = Path();
    path.lineTo(0, size.height*0.50);
    path.quadraticBezierTo(size.width*0.10, size.height*0.80, size.width*0.15, size.height*0.60);
    path.quadraticBezierTo(size.width*0.20, size.height*0.45, size.width*0.27, size.height*0.60);
    path.quadraticBezierTo(size.width*0.45, size.height, size.width*0.50, size.height*0.80);
    path.quadraticBezierTo(size.width*0.55, size.height*0.45, size.width*0.75, size.height*0.75);
    path.quadraticBezierTo(size.width*0.85, size.height*0.93, size.width, size.height*0.60);
    path.lineTo(size.width, 0);
    path.close();

    paint.color = colorTwo!;
    canvas.drawPath(path, paint);

    path =Path();
    path.lineTo(0, size.height*0.75);
    path.quadraticBezierTo(size.width*0.10, size.height*0.55, size.width*0.22, size.height*0.70);
    path.quadraticBezierTo(size.width*0.30, size.height*0.90, size.width*0.40, size.height*0.75);
    path.quadraticBezierTo(size.width*0.52, size.height*0.50, size.width*0.65, size.height*0.70);
    path.quadraticBezierTo(size.width*0.75, size.height*0.85, size.width, size.height*0.60);
    path.lineTo(size.width, 0);
    path.close();

    paint.color = colorOne;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }

}
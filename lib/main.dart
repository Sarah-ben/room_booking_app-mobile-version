import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memoire_mobile/modules/Materials/cubit/material_cubit.dart';
import 'package:memoire_mobile/modules/Reservations/material_cubit/material_reservation_cubit.dart';
import 'package:memoire_mobile/modules/login/login_screen_mobile.dart';
import 'package:memoire_mobile/modules/onBoardingScreen/welcome_screen.dart';
import 'package:memoire_mobile/shared/network/cache_helper.dart';
import 'package:memoire_mobile/shared/network/dio_helper.dart';
import 'package:memoire_mobile/shared/styles/themes.dart';
import 'main_layout/admin_home_layout.dart';
import 'main_layout/cubit/app_cubit.dart';
import 'main_layout/cubit/app_states.dart';
import 'main_layout/user_home_layout.dart';
import 'modules/Reservations/material_reservation_by_user.dart';
import 'modules/classrooms/cubit/add_cubit.dart';
import 'modules/login/cubit/cubit.dart';
import 'modules/login/cubit/states.dart';
import 'modules/Reservations/cubit/reservation_cubit.dart';
import 'modules/register/register_cubit/register_cubit.dart';



void main()async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();

  DioHelper.init();
  var isDark=CacheHelper.getData(key: 'isDark');
  var token=CacheHelper.getData(key: 'token');
  var id=CacheHelper.getData(key: 'ID');
  var isOnBoarding=CacheHelper.getData(key: 'onBoarding');
  Widget widget;
  if(isOnBoarding!=null){
    if(id!=null){
      widget= CacheHelper.getData(key: 'role')=='admin'? AdminHomeScreen():HomeLayout();
    }
    else {
      widget=const LoginScreen();
    }
  }else{
    widget=OnBoardingScreen();
  }
  runApp( MyApp(startWidget: widget,));

}

class MyApp extends StatelessWidget {
  final  isDark;
  final Widget startWidget;
  MyApp({this.isDark, required this.startWidget});

// This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(providers: [
      BlocProvider(create: (BuildContext context)=>AppCubit()..changeAppMode(Dark: isDark)),
      BlocProvider(create: (BuildContext context)=>LoginCubit()..getUsers()),
      BlocProvider(create: (BuildContext context)=>AddCubit()..getSalle()),
      BlocProvider(create: (BuildContext context)=>ReservationCubit()..getReservation(context)),
      BlocProvider(create: (BuildContext context)=>MaterialReservationCubit()..getReservation(context)..getAllReservation(context)),
      BlocProvider(create: (BuildContext context)=>RegisterCubits()),
      BlocProvider(create: (BuildContext context)=>MaterialCubit()..getMaterial()),
    ],
      child: BlocConsumer<AppCubit,AppStates>(
        builder: (context,state){
          return  MaterialApp(
              theme: lightTheme,
              themeMode: ThemeMode.light,
              darkTheme: darkTheme,
              debugShowCheckedModeBanner: false,
              //AppCubit.get(context).isDark?ThemeMode.dark:
              home: startWidget
            //we can add directionality to change direction of all app if am  using arabic
          );
        },
        listener: (context,state){},
      ),);
  }
}



import 'package:bottom_bar/bottom_bar.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memoire_mobile/main_layout/cubit/app_states.dart';
import 'package:memoire_mobile/shared/components/mobile_components.dart';

import 'cubit/app_cubit.dart';
class HomeLayout extends StatefulWidget {
  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {

  @override
  Widget build(BuildContext context) {
    AppCubit cubit=AppCubit.get(context);
    return BlocConsumer<AppCubit,AppStates>(builder: (context,state){
      return Scaffold(
      //appBar:customAppBar(context, size:cubit.currentPage==0? 100:40, text: ''),
        body:cubit.pages[cubit.currentPage],
        extendBody: true,
        bottomNavigationBar: BottomBar(
          selectedIndex: cubit.currentPage,
          onTap: (int index) {
            cubit.changeBottom(index);
          },
          items:cubit.items
        ),
      );
    }, listener: (context,state){});
  }
}

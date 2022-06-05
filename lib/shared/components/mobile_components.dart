import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:memoire_mobile/shared/styles/colors.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../main_layout/cubit/app_cubit.dart';
import '../../modules/classrooms/cubit/add_cubit.dart';
import '../../modules/login/login_screen_mobile.dart';
import '../network/cache_helper.dart';
import 'mobile_constants.dart';
Widget customText({required String text,double? fontSize,Color? color,FontWeight? fontWeight})=>Text('$text ',style: TextStyle(fontWeight:fontWeight?? FontWeight.bold,fontSize:fontSize?? 17,color: color??Colors.black),);
Widget classInfoItem({required String text,required String info})=>Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    customText(text: text),
    customText(text: info),
  ],);

Widget userInfoItem({String? see, IconData? icon,required String text, String? subText,required String label})=>  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      customText(text: label,color: Colors.grey,fontSize: 13,fontWeight: FontWeight.normal),
      const SizedBox(height: 10,),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          icon!=null?Icon(icon,color: Colors.green,size: 15,):const Text(''),
          icon!=null?const SizedBox(width: 15,):const SizedBox(width: 0,),
          customText(text: '$text ${subText ?? ""}',fontWeight: FontWeight.w600),
          const Spacer(),
          icon==null?
              customText( text: see??'SEE ALL',fontSize: 13.0,color: Colors.green):const SizedBox(),
          //icon==null?Icon(IconBroken.Arrow___Right_2,color: Colors.green,):SizedBox()
        ],),
      const SizedBox(height: 10),
      icon!=null?Container(
          color: Colors.green.withOpacity(.1),
        height: .5,
      ):Container(),




    ],
  );
Widget customListTile({
  required IconData icon,
  required String text,
  Color? color,
  Color? textColor,
  onTap
}) =>
    Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
       //   padding:const EdgeInsets.only(top: 5.0,bottom: 5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.0),
          ),
          child: ListTile(
            leading:  Icon(icon,color:color??  Colors.grey,),

            title: Text(
              text,
              style:  TextStyle(fontWeight: FontWeight.bold,color:textColor?? Colors.white),
            ),
          ),
        )
      ),
    );
Widget defaultButton({
  double width = double.infinity,
  Color? background ,
  @required function,
  @required text,
  bool iconText = false,
  icon,
  Color? color1,
  Color? color2,
  Color? color3,
  Color? color4,
  double? radius
}) =>
    Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                color1??Colors.green,
                color2??Colors.green.withOpacity(.9),
                color3??Colors.green.withOpacity(.7),
                color4??Colors.green.withOpacity(.5),
              ]),
          color: Colors.red,
          borderRadius:  BorderRadius.all(Radius.circular(radius??30.0))),
      width: width,
      height: 50,
      child: MaterialButton(
        onPressed: function,
        child: iconText == false
            ? Text(
          text,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.w600),
        )
            : Icon(icon),
      ),
    );

Widget deleteButton({
  double width = double.infinity,
  Color background = Colors.red,
  @required function,
  @required text,
  bool iconText = false,
  icon,
  Color? color1,
  Color? color2,
  Color? color3,
  Color? color4,
  double? radius
}) =>
    Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                color1??Colors.green,
                color2??Colors.green.withOpacity(.9),
                color3??Colors.green.withOpacity(.7),
                color4??Colors.green.withOpacity(.5),
              ]),
          color: background,
          borderRadius:  BorderRadius.all(Radius.circular(radius??30.0))),
      width: width,
      height: 50,
      child: MaterialButton(
        onPressed: function,
        child: iconText == false
            ? Text(
          text,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.w600),
        )
            : Icon(icon),
      ),
    );
PreferredSizeWidget customAppBar(context,
    {elevation = .3,
      required double size,
      required String text,
      Color color = Colors.white}) =>
    PreferredSize(
      preferredSize: Size.fromHeight(size),
      child: AppBar(
        backgroundColor: color,
        title: Text(
          text,
          style: const TextStyle(color: Colors.black),
        ),
        //toolbarHeight: 140,
        elevation: elevation,
        // AppCubit.get(context).index == 0 : IF IT'S IN THE  HOME PAGE
        flexibleSpace: AppCubit.get(context).currentPage == 0
            ? Padding(
          padding:
          const EdgeInsets.only(top: 50.0, right: 20.0, left: 20.0),
          child: Row(
            children: [
             // const Image(image: AssetImage('assets/images/fod.webp'),width: 60.0,),
              /*const Icon(
                      Icons.payment,
                      color: Colors.yellowAccent,
                      size: 30,
                    ),*/
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Card(
                  elevation: 3.0,
                  child: Container(
                    //width: MediaQuery.of(context).size.width - 70,
                      height: 40,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: const TextField(
                        //textAlign: TextAlign.center,
                        // controller: search,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            filled: true,
                            fillColor: Colors.white,
                            suffixIcon:
                            Icon(Icons.search, color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none),
                            hintStyle: TextStyle(color: Colors.black38),
                            hintText: "Search products"),
                      )),
                ),
              ),
            ],
          ),
        )
            : null,
        /* actions: [
    AppCubit.get(context).index==0?
    Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Container(
        //margin:const EdgeInsets.only(right: 10.0,top: 30.0),
        width: MediaQuery.of(context).size.width-50,
        //height: 70.0,
        child: Container(
          color: Colors.red,
            height: 60.0,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0,right: 10.0),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: TextFormField(
                        decoration:const InputDecoration(
                            border:   OutlineInputBorder(
                              borderRadius:BorderRadius.all(Radius.circular(20.0)),
                              borderSide:  BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:   BorderSide.none,
                            ),
                            enabledBorder:  OutlineInputBorder(
                                borderSide: BorderSide.none),
                            hintText: 'Search Products'
                        ),
                      ),
                    ),
                  ),
                 const Icon(Icons.search,color: Colors.grey)
                ],
              ),
            ),
          ),

      ),
    ):Icon(Icons.add,)
  ],*/
      ),
    );

Widget defaultTextButton({
  required function,
  required String text,
  fontSize,
  color
}){
  return  TextButton(onPressed: function, child: Text(text,style: TextStyle(color:color ?? defaultColor,fontSize:fontSize??fontSize ),)) ;
}

Widget verticalSizedBox(double height)=>SizedBox(height: height);
Widget horizontalSizedBox(double width)=>SizedBox(height: width);
enum toastStates { success, error, warning }

toastColor(toastStates state) {
  Color color;
  switch (state) {
    case toastStates.success:
      color = Colors.green;
      break;
    case toastStates.warning:
      color = Colors.amber;
      break;
    case toastStates.error:
      color = Colors.red;
      break;
  }
  return color;
}

Future flutterToast(
    {required String msg,
      Color color = Colors.red,
      required toastStates state}) =>
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: toastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

deleteConfirmation(context, {required String text1, String? text2, function}) =>
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(
                'Are you sure you want to delete ${text1} ${text2 ?? ''}?'),
            actions: [
              Row(
                children: [
                  Expanded(
                      child: defaultButton(
                        color1: Colors.grey,
                        color2: Colors.grey,
                        color3: Colors.grey,
                        color4: Colors.grey,
                          function: () {
                            Navigator.pop(context);
                          },
                          text: 'Cancel',
                          )),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: defaultButton(
                          color1: Colors.red,
                          color2: Colors.red,
                          color3: Colors.red,
                          color4: Colors.red,
                          text: 'Delete',
                          function: function)),
                ],
              )
            ],
          );
        });
Widget customTextField({
  required TextEditingController controller,
  required String label,
   IconData? icon,
  required TextInputType textInputType,
  //dynamic onFieldSubmitted,
  bool obscureText=false,
  bool enabled=true,
  onTap,
  Color? color,
  int?  maxLines,
  onChanged
})=>TextFormField(
  onChanged: onChanged,
  maxLines: maxLines??1,
  onTap: enabled==false?onTap:null,
  enabled: enabled,
  //onFieldSubmitted:onFieldSubmitted,
    keyboardType:textInputType,
    obscureText: obscureText,
    style:const TextStyle(color: Colors.black,fontSize: 16.0),
    controller:controller,
    validator: (value){
      if(value!.isEmpty){
        return '$label field is Empty';
      }
      return null;
    },
    decoration: InputDecoration(
      prefixIcon:icon!=null? Icon(icon,color: Colors.black38,):null,
      filled: true,
      fillColor: Colors.white12,
      labelText: label,
       labelStyle:  TextStyle(color: color ?? Colors.green.withOpacity(.6)),
      border:  OutlineInputBorder(
        borderRadius:const BorderRadius.all(Radius.circular(30.0)),
        borderSide: BorderSide(width: 3, color: Colors.green.withOpacity(.6)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide:  BorderSide(color: Colors.green.withOpacity(.6)),
        borderRadius: BorderRadius.circular(30.0),
      ),
      enabledBorder:  OutlineInputBorder(
          borderRadius:const BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(.4),
          )),
    )
);

void navigateAndReplace(context,widget)=>Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>widget), (route) => false);
void navigateTo(context,widget)=>Navigator.push(context, MaterialPageRoute(builder: (context)=>widget));
/*PreferredSizeWidget customAppBar(context,
    {elevation = .3,
      required double size,
      required String text,
      Color color = Colors.white}) =>
    PreferredSize(
      preferredSize: Size.fromHeight(size),
      child: AppBar(
        backgroundColor: color,
        title: Text(
          text,
          style: const TextStyle(color: Colors.black),
        ),
        //toolbarHeight: 140,
        elevation: elevation,

      ),
    );*/

/*Widget customListTile({ required IconData icon,
  required String text,
   Color? color,
})=> Padding(
  padding:const EdgeInsets.only(top: 11.0),
  child: FlatButton(
    padding:const EdgeInsets.all(10.0),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)),
    color: Colors.grey.withOpacity(.08),
    onPressed: () {
     // myInfoSheet(context);
    },
    child:ListTile(
      leading: Icon(icon,color:color ?? Colors.black,),
      title: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing:text=='Log Out'|| text=='Delete Account'?null:   Icon(Icons.arrow_forward_ios,color: secondColor,),
    ) ,
  ),
);*/

Widget customUpdateItem(context,{
 required TextEditingController controller,
  onPressed
})=> Row(
  children: [
    Expanded(
        child: TextField(
          controller: controller,
          decoration:const InputDecoration(
            hintText: 'Choose the time',
            enabledBorder:  OutlineInputBorder(
                borderSide: BorderSide.none
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide.none
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none
            ),
          ),
        )
    ),
    const SizedBox(
      width: 5.0,
    ),
    FloatingActionButton(
      backgroundColor: Colors.green,
      heroTag: 'addTime',
      onPressed:onPressed,
      mini: true,
      child:const Icon(Icons.edit),
    )
  ],
);

Widget customProgressIndicator()=>
 const Center(
    child:CircularProgressIndicator(color: Colors.black,),

);
Widget defaultEmptyScreen(context,{required String text,onTap})=>SizedBox(
  width: getWidth(context),
  height: getHeight(context),
  child:  Center(child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      customText(text: 'No $text yet',color: Colors.grey),
      defaultTextButton(function:onTap, text: 'Add new $text',color: Colors.green)
    ],
  )),
);

logout(context)=>showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        title:const Text(
            'Are you sure you want to logout?'),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 80,
                  child: defaultButton(
                    color1: Colors.grey,
                    color2: Colors.grey,
                    color3: Colors.grey,
                    color4: Colors.grey,
                    function: () {
                      Navigator.pop(context);
                    },
                    text: 'no',
                  )),
              const SizedBox(
                width: 30,
              ),
              SizedBox(
                  width: 80,

                  child: defaultButton(
                      color1: Colors.red,
                      color2: Colors.red,
                      color3: Colors.red,
                      color4: Colors.red,
                      text: 'yes',
                      function: (){
                        CacheHelper.clearData();
                        navigateAndReplace(context,const LoginScreen());
                      })),
            ],
          )
        ],
      );
    });

sendEmail(String toMailId, String subject) async {
  var url = 'mailto:$toMailId?subject=$subject';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

socialMedia(text,color,url)=> InkWell(
  onTap: (){
    launchUrl(url);
  },
  child:   Container(

      alignment: AlignmentDirectional.center,
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child:                        customText(text: text,color: Colors.white)

  ),
);
void launchUrl(url) async {
  var urllaunchable =
  await canLaunch(url); //canLaunch is from url_launcher package
  if (urllaunchable) {
    await launch(url); //launch is from url_launcher package to launch URL
  } else {
    print("URL can't be launched.");
  }
}
particular _updateParticular = particular.False;
updateClassDialog(context,{id,name,function,classStage,classCapacity})=> showDialog(
    barrierColor: Colors.grey.withOpacity(.4) ,
    context: context,
    builder: (_) => AlertDialog(
        backgroundColor:  Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Builder(
              builder: (context) {
                return SizedBox(
                  height: 400.0,
                  width: getWidth(context),
                  child:  SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10.0),
                          child: SizedBox(
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  //customFormField(sallename),
                                  customTextField(
                                      controller: classStage,
                                      textInputType: TextInputType.number,
                                      label: 'Stage',
                                      ),
                                  /* customTextField(context,controller:salleEtage , label: '  Stage', textInputType: TextInputType.number,
                                             color: dark(context)?Colors.white:Colors.black54,inputFormatters:  <TextInputFormatter>[
                                                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                              ],),*/
                                  verticalSizedBox(
                                    10.0,
                                  ),
                                  customTextField(
                                      controller: classCapacity,
                                      textInputType: TextInputType.number,

                                      label: 'Capacity'),
                                  /* customTextField(context,controller:salleCapacity , label: '  Capacity', textInputType: TextInputType.number,color:dark(context)?Colors.white:Colors.black54,inputFormatters:  <TextInputFormatter>[
                                                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                              ],),*/
                                  verticalSizedBox(
                                    20.0,
                                  ),
                                  Text(
                                    'Is it particular?',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:  Colors.black),
                                  ),
                                  verticalSizedBox(
                                    20.0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 120,
                                        child: ListTile(
                                          title: Text('No',
                                              style: TextStyle(
                                                  color: Colors.black)),
                                          leading: Radio(
                                            fillColor:
                                            MaterialStateColor.resolveWith(
                                                    (states) => Colors.green),
                                            focusColor:
                                            MaterialStateColor.resolveWith(
                                                    (states) => Colors.green),
                                            value: particular.False,
                                            groupValue: _updateParticular,
                                            onChanged: (particular? value) {
                                              setState(() {
                                                _updateParticular = value!;
                                                print(_updateParticular.name);
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 140,
                                        child: ListTile(
                                          title: Text('Yes',
                                              style: TextStyle(
                                                  color: Colors.black)),
                                          leading: Radio<particular>(
                                            fillColor:
                                            MaterialStateColor.resolveWith(
                                                    (states) => Colors.green),
                                            value: particular.True,
                                            groupValue: _updateParticular,
                                            onChanged: (particular? value) {
                                              setState(() {
                                                _updateParticular = value!;
                                                print('salle partic ${_updateParticular.name}');
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  verticalSizedBox(
                                    30.0,
                                  ),
                                  SizedBox(
                                      width: 300.0,
                                      child: defaultButton(
                                          function:(){
                                            if (formKey.currentState!
                                                .validate()) {
                                              AddCubit.get(context).updateSalle(context,id, particular:_updateParticular.name,  capcity:  int.parse(classCapacity.text), etage:  int.parse(classStage.text),);
                                            }
                                          },
                                          text: 'Update')),
                                  SizedBox(height: 5,),
                                  SizedBox(
                                      width: 300.0,
                                      child: defaultButton(
                                        color1:Colors.grey ,
                                        color2:Colors.grey ,
                                        color3:Colors.grey ,
                                        color4:Colors.grey ,
                                        background: Colors.grey,
                                          function:(){
                                            Navigator.pop(context);
                                          },
                                          text: 'Cancel')),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        )));

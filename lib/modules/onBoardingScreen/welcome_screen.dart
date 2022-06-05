
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../shared/components/mobile_components.dart';
import '../../shared/network/cache_helper.dart';
import '../../shared/styles/colors.dart';
import '../login/login_screen_mobile.dart';


class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List <BoardingModel>model=[
    BoardingModel(img:
    'https://th.bing.com/th/id/R.fc404ad0c04586cdf5bf174ed6c4ce8f?rik=6hFDU8OliPLurw&riu=http%3a%2f%2fwww.develter.com%2fdevelter_images%2fuploads%2flogos%2funiversite_constantine.jpg&ehk=pS0ZXXf0EOzbFDsSyZvERNmWHuU4HGF0LZ63Tbtbmik%3d&risl=&pid=ImgRaw&r=0'
        , title: 'ABDELHAMID MEHRI University', body:'UC2'),
    BoardingModel(img: 'https://scontent.fczl1-2.fna.fbcdn.net/v/t31.18172-8/11265504_1460367547593936_5405412813532170327_o.jpg?_nc_cat=110&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeEAV5cvSUpTXZTIVGpR38lDePF8NcY9MlF48Xw1xj0yUSZFDFmYWsbfA0gqyGIWkxrzHAo72FxgESylfag9Zgy_&_nc_ohc=9fk_NqCbt0cAX_7Eqlv&_nc_ht=scontent.fczl1-2.fna&oh=00_AT9fWAkl8MDJh54zQP-aT2NszeYCK-M4knh-u-9NT7X6mw&oe=62C0DF2C', title:'New technologies faculty', body:'NTIC'),
  ];
  bool isLast=false;
  PageController controller=PageController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          actions: [
            defaultTextButton(function:submit, text: 'Skip')
          ],
        ),
        body:Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  onPageChanged: (int i){
                    if(i==model.length-1){
                      setState(() {
                        isLast=true;
                      });
                    }else{
                      setState(() {
                        isLast=false;
                      });
                    }
                  },
                  controller:controller,
                  physics:const BouncingScrollPhysics(),
                  itemBuilder: (context,index)=>
                      buildBoardingItem(context,model[index]),
                  itemCount:3,
                ),
              ),
              const SizedBox(height: 30.0,),
              Row(
                children: [
                  SmoothPageIndicator(controller: controller,
                      effect: ExpandingDotsEffect(
                          dotColor: Colors.grey,
                          activeDotColor: defaultColor,
                          dotHeight: 10.0,
                          expansionFactor: 4,
                          dotWidth:10 ,
                          spacing: 5.0
                      ),
                      count: model.length),
                  const Spacer(),
                  FloatingActionButton(
                    backgroundColor: defaultColor,
                    onPressed: (){
                      if(isLast){
                        submit();
                      }
                      else{
                        controller.nextPage(duration:const Duration(milliseconds: 750), curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                    child:const Icon(Icons.arrow_forward_ios),
                  )
                ],
              )
            ],
          ),
        )
    );
  }

  Widget buildBoardingItem(context, BoardingModel model)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:  [
      Expanded(
        child: SizedBox(
            width:double.infinity,
            height: MediaQuery.of(context).size.height*.4,
            child:Image(image:NetworkImage(model.img) ,)),
      ),
      const  SizedBox(height: 20.0,),
      Text(
        '${model.title}',
        style:const TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold
        ),
      ),
      const  SizedBox(height: 15.0,),
      Text(
        '${model.body}',
        style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold
        ),
      ),
    ],
  );
  void submit(){
    CacheHelper.saveData(key: 'onBoarding', val: true).then((value){
      if(value==true){
        navigateAndReplace(context,const LoginScreen());
      }
    });
  }
}
class BoardingModel{
  final  img;
  final title;
  final body;
  BoardingModel({required this.img,required this.title,required this.body});
}


import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workspace/Utils/AppColors.dart';
import 'package:workspace/Utils/Dimensions.dart';
import 'package:workspace/Widgets/app_column.dart';
import 'package:workspace/Widgets/big_text.dart';
import 'package:workspace/Widgets/icon_text_widget.dart';
import 'package:workspace/Widgets/small_text.dart';
import 'package:workspace/helper/RouteHelper.dart';
import 'package:workspace/models/PopularProduct.dart';
import 'package:workspace/models/Recommended.dart';

import '../../Utils/AppConstants.dart';
import '../../controllers/PopularProductController.dart';

class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key});

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {


  PageController pageController = PageController(viewportFraction: 0.85);
  var currPageValue = 0.0;
  double scaleFactor = 0.8;
  double bigCardHeight = Dimensions.pageViewContainers;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        currPageValue = pageController.page!;
      });
    });

  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
        return  Column(
        children: [
          // Slider section
          GetBuilder<ProductController>(builder: (popularProductController){
            return popularProductController.isLoaded? Container(
              height: Dimensions.pageView,
              child: PageView.builder(
                  controller: pageController,
                  itemCount: popularProductController.popularProductList.length,
                  itemBuilder: (context, position) {
                    return _buildPageItem(
                        position,
                        popularProductController.popularProductList[position]
                    );
                  }),
            ): Container();
          }),
          // dots
          GetBuilder<ProductController>(builder: (popularProductController){
              return DotsIndicator(
                  dotsCount: popularProductController.popularProductList.isEmpty?1:popularProductController.popularProductList.length ,
                  position: currPageValue,
                  decorator: DotsDecorator(
                    activeColor: AppColors.mainColor,
                    size: const Size.square(9.0),
                    activeSize: const Size(18.0, 9.0),
                    activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                  )
              );
          }),

          // Popular text
          SizedBox(height: Dimensions.height10,),
          Container(
            margin: EdgeInsets.only(left: Dimensions.width30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                BigText(text: "Recommended"),
                SizedBox(width: Dimensions.width10,),
                Container(
                  margin: EdgeInsets.only(bottom: 3),
                  child: BigText(text: ". ", color: Colors.black26,),
                ),
                // SizedBox(width: Dimensions.width10,),
                // Container(
                //   margin: EdgeInsets.only(bottom: 6),
                //   child: SmallText(text: "Food pairing",),
                // )
              ],
            ),
          ),
          // bottom list of popular restaurants
          GetBuilder<ProductController>(builder: (controller) {
            return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.recommendedFood.length,
                itemBuilder: (context, index) {
                  return buildListViewItem(index, controller.recommendedFood[index]);
                });
          })
        ]
      );
  }

  Widget _buildPageItem(int index, ProductModel model) {
    Matrix4 matrix = new Matrix4.identity();
    if (index == currPageValue.floor()) {
      var currScale = 1 - (currPageValue - index) * (1 - scaleFactor);
      var currTrans = bigCardHeight * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    } else if (index == currPageValue.floor() + 1) {
      var currScale = scaleFactor + (currPageValue - index + 1) * (1 - scaleFactor);
      var currTrans = bigCardHeight * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    } else if (index == currPageValue.floor() - 1) {
      var currScale = 1 - (currPageValue - index) * (1 - scaleFactor);
      var currTrans = bigCardHeight * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    } else {
      matrix = Matrix4.diagonal3Values(1, scaleFactor, 1)..setTranslationRaw(0, bigCardHeight*(1 - scaleFactor)/2, 0);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: (){
              Get.toNamed(RouteHelper.getFoodDetail(index, model.itemType));
            },
            child: Container(
              height: Dimensions.pageViewContainers,
              margin:  EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image:  NetworkImage(
                          AppConstants.BASE_URL+"/uploads/"+model.img!
                      )
                  )
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainers,
              margin:  EdgeInsets.only(left: Dimensions.width30, right: Dimensions.width30, bottom: Dimensions.height30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                boxShadow: const [
                 BoxShadow(
                   color: Color(0xFFe8e8e8),
                   blurRadius: 5.0,
                   offset: Offset(0,5)
                 ),
                  BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5,0)
                  ),
                  BoxShadow(
                      color: Colors.white,
                      offset: Offset(5,0)
                  )
                ]
              ),
              child: Container(
                padding: EdgeInsets.only(top: Dimensions.height15, left: Dimensions.width15, right: Dimensions.width15),
                child: AppColumn(text: model.name!, fontSize: Dimensions.font20,),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildListViewItem(int index, RecommendedFoodModel model) {
    return Container(
      margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, bottom: Dimensions.height10),
      child:GestureDetector(
        onTap: (){
          Get.toNamed(RouteHelper.getFoodDetail(index, model.itemType));
        },
        child: Row(
          children: [
            Container(
              width: Dimensions.popularListViewImgSize,
              height: Dimensions.popularListViewImgSize,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white38,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          AppConstants.BASE_URL+"/uploads/"+model.img!
                      )
                  )
              ),
            ),
            Expanded(
              child: Container(
                height: Dimensions.popularListViewTxtContSize,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(Dimensions.radius20),
                        bottomRight: Radius.circular(Dimensions.radius20)
                    ),
                    color: Colors.transparent
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: Dimensions.width15, right: Dimensions.width10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BigText(text: model.name!),
                      SizedBox(height: Dimensions.height10,),
                      SmallText(text: model.description!, maxLines: 1,),
                      SizedBox(height: Dimensions.height10,),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconTextWidget(icon: Icons.circle_sharp,
                              text: "Normal",
                              iconColor: AppColors.iconColor1),
                          IconTextWidget(icon: Icons.location_on,
                              text: "1.7km",
                              iconColor: AppColors.mainColor),
                          IconTextWidget(icon: Icons.access_time_rounded,
                              text: "22min",
                              iconColor: AppColors.iconColor2)
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}

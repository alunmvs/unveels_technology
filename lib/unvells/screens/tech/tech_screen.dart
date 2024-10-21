import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_new/unvells/app_widgets/custom_button.dart';
import 'package:test_new/unvells/app_widgets/flux_image.dart';
import 'package:test_new/unvells/configuration/text_theme.dart';
import 'package:test_new/unvells/constants/app_constants.dart';

import '../../app_widgets/Tabbar/badge_icon_update.dart';
import '../../app_widgets/app_bar.dart';
import '../../constants/app_routes.dart';
import '../../constants/app_string_constant.dart';
import '../../helper/utils.dart';

class TechScreen extends StatelessWidget {
  const TechScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: AppSizes.deviceHeight * .08,

        // titleSpacing: 5,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.cart);
              },
              icon: const BadgeIconUpdate(
                iconColor: Colors.white,
              )),
        ],

        titleSpacing: 0,
        // leadingWidth: 20,
        leading: const Padding(
          padding: EdgeInsetsDirectional.only(start: 10),
          child: FluxImage(
            imageUrl: AppImages.placeholder,
            // height: 44,
            // width: 43,
          ),
        ),
        centerTitle: true,

        title: Padding(
          padding: const EdgeInsetsDirectional.only(start: 8),
          child: SizedBox(
            height: 40,
            // width: 43,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.search);
              },
              child: CupertinoSearchTextField(
                  suffixMode: OverlayVisibilityMode.always,
                  // padding: const EdgeInsets.all(8),
                  // backgroundColor: Colors.re,
                  itemSize: 20,
                  suffixIcon: const Icon(
                    Icons.mic,
                    // color: Colors.red,
                  ),
                  enabled: false,
                  itemColor: const Color(0xff5E6672),

                  // readOnly: _isLisstening,
                  // controller: _searchText,
                  // onChanged: (searchKey) {
                  //   print("Search key ---> " + searchKey);
                  //   searchBloc?.add(SearchSuggestionEvent(searchKey));
                  // },
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: const Color(0xFFE2E2E2),
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  style: KTextStyle.of(context).semiBoldSixteen.copyWith(
                      color: const Color(
                        0xFFB1B1B1,
                      ),
                      height: 1)),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        // padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 40, horizontal: 6),
                  color: Colors.black,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "LIMITLESS LUXURY & ADVANCED",
                        style: KTextStyle.of(context)
                            .eighteen
                            .copyWith(color: AppColors.gold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "TECHNOLOGIES",
                        style: KTextStyle.of(context)
                            .bold24
                            .copyWith(color: AppColors.white),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const FluxImage(
                          imageUrl: "assets/images/place_holder_image.png"),
                      const SizedBox(height: 20),
                      Text(
                        "Discover Unveels, Where Exclusive Innovation Meets Luxury",
                        textAlign: TextAlign.center,
                        style: KTextStyle.of(context).twenty.copyWith(
                              color: AppColors.gold,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "At Unveels, we bring you a unique collection of cutting-edge technologies found nowhere else. Our commitment to excellence transforms your shopping experience, offering unmatched sophistication and innovation. Experience the future of luxury with us—where our exclusive technology sets us apart.",
                        style: KTextStyle.of(context)
                            .sixteen
                            .copyWith(color: AppColors.white,),
                          textAlign: TextAlign.center,
                        softWrap: true,

                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
                const PositionedDirectional(
                    bottom: 25,
                    end: 8,
                    child: FluxImage(imageUrl: "assets/images/robot_man.png")),
              ],
            ),
            const CustomTechContainer(
              textColor: Colors.black,
              bgColor: Colors.white,
              title: "AI Makeup Try-On",
              subTitle: "Glamour at Your Fingertips",
              description:
                  "Unveil the elegance of instant beauty transformation with our exclusive Virtual Try-On Makeup experience. From the sanctuary of your own home, explore a world of exquisite cosmetics and beauty essentials, tailored to your unique allure. Engage the cutting-edge live-camera technology to indulge in a real-time metamorphosis, as our sophisticated algorithm seamlessly applies your selected makeup treasures. Witness the art of beauty as it unfolds on your visage, empowering you to make a confident and informed choice, all while reveling in the luxury of personal style exploration.",
              buttonTitle: 'Try On now',
            ),
            const CustomTechContainer(
              textColor: Colors.white,
              bgColor: Colors.black,
              title: "Find The Look",
              subTitle: "Curate Your Signature Style",
              description:"Step into the realm of effortless elegance with our Find The Look feature, a gateway to unveiling the secrets of impeccable style. With a few seamless steps, immerse yourself in a world where inspiration knows no bounds. Upload a photo of any captivating look that catches your eye, and watch as our sophisticated technology uncovers the precise elements that compose its allure. Our innovative system analyzes the image and reveals a curated collection of matching products, eliminating the mystery of style replication. Embrace the ease of discovery and empower your wardrobe with the essence of trendsetters, all while relishing the luxury of informed choices. Say farewell to uncertainty and embrace a world where fashion is an open book, personalized just for you.",
              buttonTitle: 'find a look',
            ),
            const CustomTechContainer(
              textColor: Colors.black,
              bgColor: Colors.white,
              title: "AI Skin Analysis",
              subTitle: "Reveal the Secrets of Radiant Skin",
              description:"Unlock the hidden potential of your complexion with our AI Skin Analysis feature, a revolutionary approach to personalized skincare. Harnessing the power of Unveels' advanced AI Skin Analyzer, effortlessly assess the health of your face and neck by simply using a live camera or uploading a photo or video. This state-of-the-art system meticulously detects a wide range of skin concerns, from spots and wrinkles to texture, dark circles, redness, oiliness, moisture levels, pores, eye bags, radiance, firmness, and more.",
              buttonTitle: 'Analyze my skin',
            ),
            const CustomTechContainer(
              textColor: Colors.white,
              bgColor: Colors.black,
              title: "AI Face Analysis",
              subTitle: "Illuminate Your True Hue",
              description:"Discover the essence of your natural beauty with our AI Skin Tone Finder, a sophisticated tool designed to unveil your perfect palette. Effortlessly identify your skin tone with precision and grace, using our advanced technology to analyze subtle undertones and hues through a live camera or uploaded photo. This personalized service empowers you to select the ideal shades and products that harmonize with your unique complexion.",
              buttonTitle: 'analyze my face',
            ),
            const CustomTechContainer(
              textColor: Colors.black,
              bgColor: Colors.white,
              title: "AI Accessories Try-On",
              subTitle: "Elegance Beyond Imagination",
              description:"Discover the art of accessorizing with unparalleled sophistication through our AI Try-On Accessories experience. Indulge in the allure of exquisite sunglasses, necklaces, hats, watches, and more—all tailored to your personal style with just a click. This groundbreaking technology transforms your shopping experience, allowing you to visualize the perfect accessory ensemble with effortless grace. Say goodbye to uncertainty and embrace the confidence of a well-informed decision, all from the comfort of your home. Revel in the seamless fusion of fashion and innovation, crafted exclusively for the discerning shopper.",
              buttonTitle: 'Try on now',
            ),
            const CustomTechContainer(
              textColor: Colors.white,
              bgColor: Colors.black,
              title: "Shop The Look",
              subTitle: "Elevate Your Wardrobe Instantly",
              description:"Step into a curated world of style with our Shop The Look feature, where elegance and convenience converge. Explore Unveels' exclusive Look-book, a treasure trove of meticulously crafted ensembles designed to inspire and captivate. With a simple click, immerse yourself in the allure of each look, seamlessly trying on the essence of chic sophistication. Our intuitive hotspot feature allows you to effortlessly select and acquire any item within these curated collections. Transform your wardrobe with a single gesture and embrace the art of refined fashion at your fingertips. Experience the thrill of instant style elevation, where each look is a masterpiece waiting to be yours.",
              buttonTitle: 'shop a  look',
            ),
            const CustomTechContainer(
              textColor: Colors.black,
              bgColor: Colors.white,
              title: "Smart Mirror",
              subTitle: "Reflections of Elegance, The Ultimate Smart Mirror Experience",
              description:"Transform your beauty routine with our state-of-the-art smart mirror. Effortlessly apply different shades of makeup using simple voice commands. Experience the perfect blend of luxury and innovation, as the smart mirror responds intuitively to your desires, elevating your beauty regimen to new heights of sophistication.",
              buttonTitle: 'use smart mirror',
            ),
            const CustomTechContainer(
              textColor: Colors.white,
              bgColor: Colors.black,
              title: "AI Skin Simulation",
              subTitle: "Envision Your Future Radiance",
              description:"Step into the realm of possibilities with our AI Skin Simulation feature, where you can glimpse the future of your complexion with unparalleled accuracy. Harness the power of cutting-edge technology to predict and visualize the transformative effects of beauty products on your skin. Simply use a live camera or upload a photo to initiate a seamless analysis that reveals potential improvements tailored to your unique skin profile.",
              buttonTitle: 'Simulate my skin',
            ),
            const CustomTechContainer(
              textColor: Colors.black,
              bgColor: Colors.white,
              title: "AI Personality Finder",
              subTitle: "Discover Your Essence, Define Your Style",
              description:"Step into a world where your individuality is celebrated with our AI Personality Finder & Product Recommendation feature. Through a sophisticated analysis of your facial features—such as the contour of your nose and the shape of your lips—our advanced technology unveils the nuances of your personality in real-time via live camera interactions. This cutting-edge AI experience transcends traditional shopping by offering you a curated selection of products that resonate with your unique essence.",
              buttonTitle: 'find my personality',
            ),
            const CustomTechContainer(
              textColor: Colors.white,
              bgColor: Colors.black,
              title: "AR Home Accessories",
              subTitle: "Transform Your Space with Visionary Precision",
              description:"Experience the future of home décor with our Augmented Reality for Home Accessories feature, where imagination meets reality in the most exquisite way. Elevate your interior design journey by effortlessly visualizing your chosen pieces within your living spaces before making a purchase. Our cutting-edge AR technology offers an immersive and interactive experience, allowing you to place and view home accessories in your real-world environment with stunning accuracy. No longer worry about whether an item will harmonize with your décor; instead, delight in the luxury of informed decisions that ensure every piece fits seamlessly into your home. Embrace the confidence of transformative design at your fingertips and redefine your space with elegance and ease.",
              buttonTitle: 'Try now',
            ),
            SizedBox(height: 100,),
          ],
        ),
      ),
    );
  }
}

class CustomTechContainer extends StatelessWidget {
  const CustomTechContainer(
      {super.key,
      required this.bgColor,
      required this.title,
      required this.subTitle,
      required this.description,
      required this.textColor,
      required this.buttonTitle});

  final Color bgColor;
  final Color textColor;
  final String title;
  final String subTitle;
  final String description;
  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 6),
      color: bgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: KTextStyle.of(context).bold24.copyWith(color: textColor),
          ),
          const SizedBox(
            height: 24,
          ),
          const FluxImage(imageUrl: "assets/images/Video_placeHolder.png"),
          const SizedBox(height: 20),
          Text(
            subTitle,
            textAlign: TextAlign.center,
            style: KTextStyle.of(context).twenty.copyWith(
                  color: AppColors.gold,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: KTextStyle.of(context).sixteen.copyWith(color: textColor),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          CustomButton(
            borderColor: AppColors.gold,
            kFillColor: Colors.transparent,
            textColor: AppColors.gold,
            borderWidth: 1,
            isFlat:true ,


            title: buttonTitle.toUpperCase(),
            onPressed: () {},
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get/utils.dart';
import 'package:tracker/onboarding_models/onboarding_info.dart';
import 'package:tracker/pages/homePage.dart';



class OnboardingController extends GetxController{
   
  var selectedPageIndex = 0.obs;
  bool get isLastPage => selectedPageIndex.value == OnboardingPages.length -1;
  var pageController = PageController();

  void forwardAction(BuildContext context) {
    if (isLastPage) {
      // go to home page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const homePage()),
      );
    } else {
      pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }
  }



  List<OnboardingInfo> OnboardingPages = [
    OnboardingInfo('assets/onboarding1.png', 'T r a c k F i t', ''),
    OnboardingInfo('assets/sport.png', 'Welcome to TrackFit', 'Define your fitness goals and track your progress daily. Begin your fitness journey today with TrackFit!'),
    OnboardingInfo('assets/healthcare.png', 'Get Started', 'Define your fitness targets and start your journey towards a healthier you.')
  ];
}
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tracker/onboarding_controllers/onboarding_controller.dart';


class OnboardingPage extends StatelessWidget {
  
  final _controller = OnboardingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromRGBO(243, 229, 245, 1),
        child: Stack(
          children: [
            PageView.builder(
                controller: _controller.pageController,
                onPageChanged: _controller.selectedPageIndex,
                itemCount: _controller.OnboardingPages.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          _controller.OnboardingPages[index].imageAsset,
                          width: 150,
                          height: 200,
                        ),
                        SizedBox(height: 5),
                        Text(
                          _controller.OnboardingPages[index].Title,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: Color.fromRGBO(109, 0, 82, 1),
                          ),
                        ),
                        SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 72.0),
                          child: Text(
                            _controller.OnboardingPages[index].description,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[600]),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                Positioned(
              bottom: 20,
              left: 20,
              child: Row(
                children: [
                  ...List.generate(
                      _controller.OnboardingPages.length,
                      (index) => Obx(() {
                            return Container(
                              margin: const EdgeInsets.all(4),
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                  color: _controller.selectedPageIndex.value ==
                                          index
                                      ? Color.fromRGBO(109, 0, 82, 1)
                                      : Colors.grey,
                                  shape: BoxShape.circle),
                            );
                          })),
                ],
              ),
            ),
                Positioned(
              right: 20,
              bottom: 20,
              child: FloatingActionButton(
                backgroundColor:  Color.fromRGBO(240, 160, 210, 1)
                ,
                elevation: 0,
                child: const Text('Next', style: TextStyle(color: Colors.white),),
                onPressed: () {
                  _controller.forwardAction(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

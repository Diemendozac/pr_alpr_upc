
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pr_alpr_upc/src/utils/user_guide_constants.dart';

class UserGuide {
  final String title;
  final String description;
  final String image;
  final Color bgColor;
  final Color textColor;

  UserGuide(
      {required this.title,
        required this.description,
        required this.image,
        this.bgColor = Colors.blue,
        this.textColor = Colors.white});
}

class UserGuidePage extends StatefulWidget {

  const UserGuidePage({super.key});

  @override
  UserGuidePageState createState() => UserGuidePageState();
}

class UserGuidePageState extends State<UserGuidePage> {
  // Store the currently visible page
  int _currentPage = 0;
  // Define a controller for the pageview
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {

    final UserGuideConstants userGuideConstants = UserGuideConstants();

    List<UserGuide> pages = userGuideConstants.userManual;

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        color: Theme.of(context).colorScheme.background,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                // Pageview to render each page
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: pages.length,
                  onPageChanged: (idx) {
                    // Change current page when pageview changes
                    setState(() {
                      _currentPage = idx;
                    });
                  },
                  itemBuilder: (context, idx) {
                    final item = pages[idx];
                    return Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: SvgPicture.asset(
                              item.image,
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Column(children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(item.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).colorScheme.onBackground,
                                    )),
                              ),
                              Container(
                                constraints: const BoxConstraints(maxWidth: 280),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0, vertical: 8.0),
                                child: Text(item.description,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                      color: Theme.of(context).colorScheme.onBackground,
                                    )),
                              )
                            ]))
                      ],
                    );
                  },
                ),
              ),

              // Current page indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: pages
                    .map((item) => AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: _currentPage == pages.indexOf(item)
                      ? 20
                      : 4,
                  height: 4,
                  margin: const EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onBackground,
                      borderRadius: BorderRadius.circular(10.0)),
                ))
                    .toList(),
              ),

              // Bottom buttons
              SizedBox(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    TextButton(
                      onPressed: () {
                        if (_currentPage == pages.length - 1) {
                          Navigator.of(context).pop();
                        } else {
                          _pageController.animateToPage(_currentPage + 1,
                              curve: Curves.easeInOutCubic,
                              duration: const Duration(milliseconds: 250));
                        }
                      },
                      child: Text(
                        _currentPage == pages.length - 1
                            ? "Salir"
                            : "Siguiente",
                        style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

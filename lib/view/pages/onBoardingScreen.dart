import 'package:flutter/material.dart';
import 'package:gaagls/view/pages/signIn_Page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<_OnboardData> pages = [
    _OnboardData(
      image: "lib/images/img.jpg",
      title: "Discover Your Journey",
      description:
          "Explore the best destinations in Syria with organized tours and exceptional services from start to finish.",
    ),
    _OnboardData(
      image: "lib/images/img1.jpg",
      title: "Easy & Complete Bookings",
      description:
          "Book your hotel, restaurant, and car rental—all in one place, with just a few taps.",
    ),
    _OnboardData(
      image: "lib/images/img2.jpg",
      title: "Design Your Perfect Trip",
      description:
          "Create your ideal trip… We take care of every detail for an unforgettable travel experience.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: pages.length,
              itemBuilder: (context, index) {
                final page = pages[index];
                return Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.73,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(35),
                        ),
                        child: Image.asset(
                          page.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              page.title,
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              page.description,
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.grey),
                            ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Dots indicator
                                Row(
                                  children: List.generate(
                                    pages.length,
                                    (dotIndex) => Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      width: _currentPage == dotIndex ? 16 : 6,
                                      height: 6,
                                      decoration: BoxDecoration(
                                        color: _currentPage == dotIndex
                                            ? Theme.of(context).primaryColor
                                            : Colors.grey,
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                    ),
                                  ),
                                ),

                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context).primaryColor,
                                    shape: const CircleBorder(),
                                    padding: const EdgeInsets.all(12),
                                  ),
                                  onPressed: () {
                                    if (_currentPage < pages.length - 1) {
                                      _controller.nextPage(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                      );
                                    } else {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => const SignIn()),
                                      );
                                    }
                                  },
                                  child: const Icon(Icons.arrow_forward,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardData {
  final String image;
  final String title;
  final String description;

  _OnboardData({
    required this.image,
    required this.title,
    required this.description,
  });
}


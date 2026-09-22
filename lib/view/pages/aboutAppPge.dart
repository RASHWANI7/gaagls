import 'dart:ui';
import 'package:flutter/material.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      //backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Theme.of(context).scaffoldBackgroundColor
          : Colors.white,

      body: Stack(
        children: [
          // تأثير البلور
          // BackdropFilter(
          //   filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          //   child: Container(
          //     color: Colors.black.withOpacity(0.3),
          //   ),
          // ),

          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.black.withOpacity(0.3) // في الدارك
                  : Colors.grey.withOpacity(0.2), // في اللايت (رمادي خفيف شفاف)
            ),
          ),


          // المحتوى
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // AppBar مخصص
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "About App",
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // أيقونة التطبيق
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.flutter_dash,
                        size: 100,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // اسم التطبيق
                  Text(
                    "GAAGLS",
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  // رقم الإصدار
                  Text(
                    "Version 1.0.0",
                    style: theme.textTheme.bodyMedium?.copyWith(

                    ),
                  ),

                  const SizedBox(height: 25),

                  // وصف التطبيق طويل ومفصل
                  Text(
                    "Welcome to GAAGLS! This application is designed to provide users with an intuitive and seamless experience. "
                        "Our goal is to help users manage their tasks efficiently, discover new features, and enjoy a modern, responsive interface. "
                        "The app includes powerful tools, clean design, and easy navigation for productivity and convenience. "
                        "We continuously improve the app to ensure the best performance and user satisfaction.",
                    style: theme.textTheme.bodyLarge?.copyWith(
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 30),

                  // قسم الفريق
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "About the Team",
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Our team consists of experienced developers, designers, and project managers who are passionate about building high-quality mobile applications. "
                            "We believe in continuous learning and delivering products that truly benefit our users.",
                        style: theme.textTheme.bodyLarge?.copyWith(
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  // قسم اتصل بنا
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Contact & Support",
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "For questions, suggestions, or support, please reach out via email or visit our website. "
                            "We are committed to providing timely assistance to all our users.",
                        style: theme.textTheme.bodyLarge?.copyWith(
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // أزرار سياسة الخصوصية والدعم
                  ElevatedButton.icon(
                    onPressed: () {
                      // ضع رابط سياسة الخصوصية هنا
                    },
                    icon: const Icon(Icons.privacy_tip),
                    label: const Text("Privacy Policy"),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: theme.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  ElevatedButton.icon(
                    onPressed: () {
                      // ضع رابط الدعم أو البريد الإلكتروني هنا
                    },
                    icon: const Icon(Icons.support_agent),
                    label: const Text("Contact Support"),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: theme.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart'; // Import go_router

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Set status bar icons to light color (e.g., white) as the background is dark
    // This handles the "Iphone" status bar elements (Time, Wifi, Battery) implicitly.
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return Scaffold(
      backgroundColor: Colors.black, // Dark background for the bottom content area
      body: Stack(
        children: [
          // 1. Background Image (Image Onboarding)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            // The image's absoluteRenderBounds height is 536px for a 812px screen in Figma.
            // We scale this proportionally for responsiveness.
            height: screenHeight * (536 / 812),
            child: Image.asset(
              'assets/images/I156_95_417_719.png', // Image path constructed from its ID
              fit: BoxFit.cover, // Ensure the image covers the area
              width: screenWidth, // Ensure image takes full width
            ),
          ),

          // 2. Gradient Overlay and Main Content (Text & Button)
          // This positioned widget starts at y=452px and extends to the bottom of the screen.
          Positioned(
            top: screenHeight * (452 / 812), // Start position of the "Container" in Figma
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.0), // Start transparent
                    Colors.black.withOpacity(0.7), // Figma's gradient stop at 0.2367. Adjusting opacity for better visual blend.
                    Colors.black, // Fully opaque black at the bottom
                  ],
                  stops: const [0.0, 0.2367, 1.0], // Figma gradient stops extended to full opacity
                ),
              ),
              child: SafeArea(
                // Apply safe area for the bottom to accommodate the system's home indicator
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0), // Horizontal padding from Figma
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end, // Align content to the bottom
                    crossAxisAlignment: CrossAxisAlignment.center, // Center text horizontally
                    children: [
                      // Title Text "Fall in Love with Coffee in Blissful Delight!"
                      Text(
                        'Fall in Love with Coffee in Blissful Delight!',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.sora(
                          fontSize: 32,
                          fontWeight: FontWeight.w600, // SemiBold
                          letterSpacing: 0.16,
                          height: 1.5, // Figma's lineHeightPx: 48, fontSize: 32 -> 48/32 = 1.5
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8), // Spacing between title and subtitle derived from Figma
                      // Subtitle Text "Welcome to our cozy coffee corner..."
                      Text(
                        'Welcome to our cozy coffee corner, where every cup is a delightful for you.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.sora(
                          fontSize: 14,
                          fontWeight: FontWeight.w400, // Regular
                          letterSpacing: 0.14,
                          height: 1.5, // Figma's lineHeightPx: 21, fontSize: 14 -> 21/14 = 1.5
                          color: const Color(0xFFA2A2A2), // Figma's RGB(0.6352941393852234)
                        ),
                      ),
                      const SizedBox(height: 32), // Spacing before button derived from Figma (702-670=32)
                      // "Get Started" Button
                      SizedBox(
                        width: double.infinity, // Button takes full available width (minus padding)
                        height: 56, // Fixed height from Figma
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigate to the home screen using go_router.
                            context.go('/home');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFC67C4E), // Button background color from Figma
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16), // cornerRadius: 16 from Figma
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16), // Button text padding from Figma
                            elevation: 0, // No shadow for the button
                          ),
                          child: Text(
                            'Get Started',
                            style: GoogleFonts.sora(
                              fontSize: 16,
                              fontWeight: FontWeight.w600, // SemiBold
                              height: 1.5, // Figma's lineHeightPx: 24, fontSize: 16 -> 24/16 = 1.5
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        // Add some responsive bottom padding to ensure content isn't too close to the edge
                        // while respecting the safe area. Figma's button ends at y=758, screen at 812.
                        // 812 - 758 = 54px. Proportionally, this is 54/812 ~ 6.6% of screen height.
                        height: screenHeight * (54 / 812),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Note: The Figma "Iphone" components for the status bar (time, wifi, battery) and home indicator
          // are typically system UI elements.
          // By setting SystemUiOverlayStyle.light and using SafeArea, we ensure content doesn't
          // overlap with them and that they are appropriately themed (light icons on a dark background).
          // Explicitly drawing them as widgets would duplicate system functionality and is generally
          // not recommended for standard system UI elements.
        ],
      ),
    );
  }
}
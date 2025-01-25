String? getFirstName(String? fullName) {
  return fullName?.split(" ").first;
}

// List<OnboardingData> kOnboardingData = [
//   OnboardingData(
//     illustration: GreenCartAssets.images.onboarding1.svg(),
//     title: "Welcome to the OCDS Community".hardcoded,
//     text:
//         "Empowering students to discover career paths, connect with mentors, and develop essential skills for the future.\n"
//             .hardcoded,
//   ),
//   OnboardingData(
//     illustration: GreenCartAssets.images.onboarding2.svg(),
//     title: "Find Opportunities &\n Events".hardcoded,
//     text:
//         "Participate in interactive workshops, webinars, and events designed to boost your knowledge and prepare you for the labor market."
//             .hardcoded,
//   )
// ];

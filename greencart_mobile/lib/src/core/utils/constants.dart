import 'package:greencart_app/src/features/authentication/domain/models/onboarding_data.dart';

String? getFirstName(String? fullName) {
  return fullName?.split(" ").first;
}

List<OnboardingData> kOnboardingData = [
  OnboardingData(
    title: "Effortless Shopping, sustainable living!",
    description:
        "Organize your lists, cut down on waste, and make mindful purchases with GreenCart",
  ),
  OnboardingData(
    title: "Shop smarter, waste less!",
    description:
        "Avoid unnecessary trips, track your essentials, and make eco-friendly choices with GreenCart",
  ),
  OnboardingData(
    title: "Stay organized, and shop sustainably!",
    description:
        "Plan your grocery trips efficiently, reduce food waste, and make sustainable shopping a habit with GreenCart",
  ),
];

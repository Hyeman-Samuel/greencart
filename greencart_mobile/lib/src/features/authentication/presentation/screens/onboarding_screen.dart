import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greencart_app/src/config/navigation/app_router.gr.dart';
import 'package:greencart_app/src/core/core.dart';
import 'package:greencart_app/src/shared/shared.dart';

@RoutePage()
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  int currentPage = 0;
  final PageController _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      scrollable: false,
      useBackgroundImage: true,
      backgroundImage: GreenCartAssets.images.onboardingBg.provider(),
      padding: EdgeInsets.zero,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Sizes.p32.vGap,
          Text(
            "Welcome to GreenCart",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: AppColors.white,
            ),
          ),
          Text(
            "The Right Way to Make Your Shopping Easier",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: AppColors.white.withValues(alpha: 0.7),
            ),
          ),
          Spacer(flex: 2),
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: kOnboardingData.length,
              onPageChanged: (value) {
                setState(() => currentPage = value);
              },
              itemBuilder:
                  (context, index) => _OnboardingPage(
                    currentPage: currentPage + 1,
                    title: kOnboardingData[index].title,
                    description: kOnboardingData[index].description,
                  ),
            ),
          ),
          Sizes.p24.vGap,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:
                kOnboardingData.map((data) {
                  return AnimatedContainer(
                    duration: Durations.medium1,
                    height: 8,
                    width: 8,
                    margin: EdgeInsets.only(right: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color:
                          kOnboardingData[currentPage] == data
                              ? AppColors.white
                              : AppColors.white.withValues(alpha: 0.4),
                    ),
                  );
                }).toList(),
          ),
          Sizes.p32.vGap,
          Padding(
            padding: Sizes.p24.hPadding,
            child: Row(
              key: ValueKey(currentPage),
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppButton.medium(
                  onPressed: () => context.router.push(SignInScreenRoute()),
                  buttonColor: AppColors.white.withValues(alpha: 0.175),
                  label: "Sign in",
                  labelColor: AppColors.white,
                ),
                AppButton.medium(
                  onPressed: () => context.router.push(SignUpScreenRoute()),
                  buttonColor: AppColors.white.withValues(alpha: 0.175),
                  label: "Sign up",
                  labelColor: AppColors.white,
                ),
              ],
            ),
          ),
          Sizes.p16.vGap,
        ],
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({
    required this.currentPage,
    required this.title,
    required this.description,
  });

  final int currentPage;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Benefits $currentPage/3",
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppColors.white.withValues(alpha: 0.6),
          ),
        ),
        Sizes.p8.vGap,
        Text(
          title,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.white,
          ),
        ),
        Sizes.p8.vGap,
        Text(
          description,
          textAlign: TextAlign.center,
          maxLines: 3,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w400,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }
}

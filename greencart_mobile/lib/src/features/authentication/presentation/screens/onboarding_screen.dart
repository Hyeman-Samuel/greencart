import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      padding: EdgeInsets.zero,
      body: Center(
        child: Text("Onboarding Screen"),
      ),
      /* Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: kOnboardingData.length,
              onPageChanged: (value) {
                setState(() => currentPage = value);
              },
              itemBuilder: (context, index) => _OnboardingPage(
                currentPage: currentPage,
                illustration: kOnboardingData[index].illustration,
                title: kOnboardingData[index].title,
                text: kOnboardingData[index].text,
              ),
            ),
          ),
          Sizes.p24.vGap,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: kOnboardingData.map(
              (data) {
                return AnimatedContainer(
                  duration: Durations.medium1,
                  height: 10,
                  width: kOnboardingData[currentPage] == data ? 20 : 10,
                  margin: EdgeInsets.only(right: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: kOnboardingData[currentPage] == data
                        ? AppColors.primary
                        : AppColors.primary.withValues(alpha: 0.4),
                  ),
                );
              },
            ).toList(),
          ),
          Sizes.p32.vGap,
          Padding(
            padding: Sizes.p24.hPadding,
            child: Row(
              key: ValueKey(currentPage),
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (currentPage == 0) ...[
                  ElevatedButton(
                    onPressed: () => context.router.push(LoginScreenRoute()),
                    child: Text("Skip"),
                  ),
                  ElevatedButton(
                    onPressed: () => _controller.nextPage(
                      duration: Duration(milliseconds: 800),
                      curve: Curves.fastOutSlowIn,
                    ),
                    child: Text("Next"),
                  ),
                ] else
                  Expanded(
                    child: TextButton(
                      onPressed: () => context.router.push(LoginScreenRoute()),
                      child: Text("Get Started"),
                    ),
                  ),
              ],
            ),
          ),
          Sizes.p4.vGap,
        ],
      ),
     */
    );
  }
}

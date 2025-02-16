import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greencart_app/src/core/core.dart';
import 'package:greencart_app/src/features/authentication/presentation/controllers/auth_controller.dart';
import 'package:greencart_app/src/features/profile/presentation/controllers/profile_screen_controller.dart';
import 'package:greencart_app/src/shared/shared.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(fetchUserProfileProvider);
    return AppScaffold(
      padding: EdgeInsets.zero,
      scrollable: false,
      showAppBar: true,
      appBarActions: [
        TextButton(
          onPressed: () {
            AppDialogs.showAlertDialog(
              context: context,
              title: "Log Out",
              content: "Are you sure you want to log out?",
              cancelActionText: "Cancel",
              defaultActionText: "Yes",
              onDefaultAction: () =>
                  ref.read(authControllerProvider.notifier).logout(),
            );
          },
          child: const Text(
            "Log Out",
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Sizes.p16.hGap,
      ],
      body: state.when(
        skipLoadingOnRefresh: false,
        data: (data) {
          final user = data.user;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Sizes.p24.vGap,
                CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: user?.profilePicture != null
                      ? NetworkImage(user?.profilePicture ?? '')
                      : null,
                  child: user?.profilePicture == null
                      ? Text(
                          getInitials(user?.fullName ?? ''),
                          style: const TextStyle(
                            fontSize: 40,
                            color: AppColors.primary,
                          ),
                        )
                      : null,
                ),
                Sizes.p8.vGap,
                Text(
                  user?.fullName ?? '',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  user?.email ?? '',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Sizes.p24.vGap,
                Divider(
                  color: Colors.grey[300],
                ),
              ],
            ),
          );
        },
        loading: () {
          return Center(
            child: Shimmer.zone(
              child: Column(
                children: [
                  Bone(
                    shape: BoxShape.circle,
                  ),
                  Sizes.p16.vGap,
                  Bone(height: 24, width: 200),
                  Sizes.p16.vGap,
                  Bone(height: 16, width: 150),
                ],
              ),
            ),
          );
        },
        error: (error, stackTrace) => ErrorDisplay(
          errorDescription: 'Error loading profile. Please try again.',
          onRetry: () {
            return ref.refresh(fetchUserProfileProvider.future);
          },
        ),
      ),
    );
  }
}

String getInitials(String name) {
  List<String> names = name.split(' ');
  if (names.length > 1) {
    return names[0][0].toUpperCase() + names[1][0].toUpperCase();
  } else {
    return names[0][0].toUpperCase();
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:greencart_app/src/core/core.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    required this.scrollable,
    required this.body,
    this.title,
    super.key,
    this.drawer,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.showAppBar = false,
    this.appBarActions,
    this.bg,
    this.scaffoldKey,
    this.controller,
    this.scrollPhysics,
    this.safeAreaTop,
    this.safeAreaBottom,
    this.extendBody,
    this.statusBarColor,
    this.navBarColor,
    this.isLight = false,
    this.padding,
    this.appBarTitleWidget,
    this.appBarLeadingWidget,
    this.appBarLeadingCallback,
    this.resizeToAvoidInsets,
    this.floatingActionButtonLocation,
    this.backgroundColor,
    this.useBackgroundImage,
    this.backgroundImage,
  });
  final Widget? drawer;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final Widget? appBarLeadingWidget;
  final Widget? appBarTitleWidget;
  final List<Widget>? appBarActions;
  final Widget body;
  final EdgeInsets? padding;
  final bool showAppBar;
  final bool scrollable;
  final bool? resizeToAvoidInsets;
  final Color? bg;
  final String? title;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final ScrollController? controller;
  final ScrollPhysics? scrollPhysics;
  final bool? safeAreaTop;
  final bool? safeAreaBottom;
  final bool? extendBody;
  final Color? statusBarColor;
  final Color? navBarColor;
  final bool? isLight;
  final VoidCallback? appBarLeadingCallback;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Color? backgroundColor;
  final bool? useBackgroundImage;
  final ImageProvider<Object>? backgroundImage;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          useBackgroundImage == true
              ? BoxDecoration(
                image: DecorationImage(
                  image: backgroundImage!,
                  fit: BoxFit.cover,
                ),
              )
              : null,
      child: Scaffold(
        backgroundColor:
            useBackgroundImage == true ? Colors.transparent : backgroundColor,
        drawerEnableOpenDragGesture: true,
        key: scaffoldKey,
        appBar:
            showAppBar
                ? AppBar(
                  leading:
                      appBarLeadingWidget ??
                      InkWell(
                        onTap:
                            appBarLeadingCallback ??
                            () => context.router.popForced(),
                        child: Icon(IconsaxPlusLinear.arrow_left_1),
                      ),
                  centerTitle: appBarTitleWidget == null,
                  title:
                      title != null
                          ? Text(
                            title!,
                            style: context.appTextTheme.mediumTextRegular
                                .copyWith(
                                  color: AppColors.gray1,
                                  fontWeight: FontWeight.w600,
                                ),
                          )
                          : appBarTitleWidget,
                  actions: appBarActions,
                )
                : null,
        resizeToAvoidBottomInset: resizeToAvoidInsets,
        body: SafeArea(
          top: safeAreaTop ?? true,
          bottom: safeAreaBottom ?? true,
          child:
              scrollable
                  ? SingleChildScrollView(
                    controller: controller,
                    physics: scrollPhysics,
                    child: Padding(
                      padding:
                          padding ??
                          Sizes.p16.hPadding +
                              (showAppBar
                                  ? Sizes.p0.tPadding
                                  : Sizes.p16.tPadding),
                      child: body,
                    ),
                  )
                  : Padding(
                    padding: padding ?? Sizes.p16.hPadding,
                    child: body,
                  ),
        ),
        drawer: drawer,
        bottomNavigationBar: bottomNavigationBar,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
      ),
    );
  }
}

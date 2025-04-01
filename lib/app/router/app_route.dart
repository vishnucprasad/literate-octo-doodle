import 'package:aaraadhya_temple_dashboard/presentation/common/animations/reveal_animation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRoute {
  final String name;
  final String path;
  final Widget _screen;

  Widget _builder(BuildContext context, GoRouterState state) => _screen;

  CustomTransitionPage _revealTransitionBuilder(
    BuildContext context,
    GoRouterState state,
  ) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: RevealAnimation(child: _screen),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    );
  }

  CustomTransitionPage _slideTransitionBuilder(
    BuildContext context,
    GoRouterState state,
  ) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: _screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
  }

  GoRouterWidgetBuilder get builder => _builder;
  GoRouterPageBuilder get slideTransitionBuilder => _slideTransitionBuilder;
  GoRouterPageBuilder get revealTransitionBuilder => _revealTransitionBuilder;

  AppRoute(this._screen, {required this.name, required this.path});
}

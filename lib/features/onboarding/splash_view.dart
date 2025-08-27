import 'dart:async';
import 'package:flutter/material.dart';
import 'package:reada/services/navigation%20service/app_routes.dart';
import 'package:reada/services/services.dart';
import 'package:reada/shared/app%20images/images.dart';
import 'package:reada/shared/extensions/build_context_extension.dart';

class SplashView extends StatefulWidget {
  final Size screenSize;

  const SplashView({
    super.key,
    required this.screenSize,
  });

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late AnimationController _fallingBallController;
  late AnimationController _fadeOutController;
  late AnimationController _finalLogoFadeController;

  late Animation<double> _fallingBallAnimation;
  late Animation<double> _ballFadeAnimation;
  late Animation<double> _finalLogoFadeAnimation;

  bool _showFinalLogo = false;

  @override
  void initState() {
    super.initState();

    // Smooth falling ball animation
    _fallingBallController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fallingBallAnimation = Tween<double>(
      begin: -200,
      end: (widget.screenSize.height / 2) - 100,
    ).animate(
      CurvedAnimation(
        parent: _fallingBallController,
        curve: Curves.easeIn, // smooth fall
      ),
    );

    // Fade out ball & logo
    _fadeOutController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _ballFadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _fadeOutController, curve: Curves.easeOut),
    );

    // Fade in final logo
    _finalLogoFadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _finalLogoFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _finalLogoFadeController, curve: Curves.easeIn),
    );

    // Animation sequence
    _fallingBallController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Timer(const Duration(milliseconds: 300), () {
          _fadeOutController.forward();
        });
      }
    });

    _fadeOutController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _showFinalLogo = true;
        });
        _finalLogoFadeController.forward();
      }
    });

    _finalLogoFadeController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Timer(
          const Duration(milliseconds: 1000),
          () {
            Services.navigationService.navigateToReplace(AppRoutes.intro);
          },
        );
      }
    });

    // Start falling ball after slight delay
    Timer(const Duration(milliseconds: 300), () {
      _fallingBallController.forward();
    });
  }

  @override
  void dispose() {
    _fallingBallController.dispose();
    _fadeOutController.dispose();
    _finalLogoFadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Final logo fade in
          if (_showFinalLogo)
            AnimatedBuilder(
              animation: _finalLogoFadeAnimation,
              builder: (_, child) {
                return Opacity(
                  opacity: _finalLogoFadeAnimation.value,
                  child: child,
                );
              },
              child: Image.asset(
                AppImages.logoLongOrange,
                width: 150,
                height: 150,
              ),
            ),

          // Falling ball + logo inside it
          AnimatedBuilder(
            animation: _fallingBallController,
            builder: (_, child) {
              return Positioned(
                top: _fallingBallAnimation.value,
                left: (widget.screenSize.width / 2) - 100,
                child: FadeTransition(
                  opacity: _ballFadeAnimation,
                  child: child,
                ),
              );
            },
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: context.colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(
                  AppImages.logoLongWhite,
                  width: 100,
                  height: 100,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

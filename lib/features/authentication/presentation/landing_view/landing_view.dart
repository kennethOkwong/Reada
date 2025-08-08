import 'package:flutter/material.dart';
import 'package:reada/app/base/base_ui.dart';
import 'package:reada/features/authentication/presentation/landing_view/landing_view_viewmodel.dart';
import 'package:reada/features/authentication/presentation/landing_view/landing_events.dart';
import 'package:reada/services/navigation%20service/app_routes.dart';
import 'package:reada/shared/buttons/cutsom_button.dart';
import 'package:reada/shared/constants.dart';
import 'package:reada/shared/extensions/build_context_extension.dart';
import 'package:reada/shared/app%20images/images.dart';

class LandingView extends StatelessWidget {
  const LandingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<LandingScreenViewmodel, LandingEvents>(
      viewModel: LandingScreenViewmodel(),
      builder: (context, model, child) {
        return SafeArea(
          child: Scaffold(
              body: Padding(
            padding: Constants.pagePadding,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: context.spacing32),
                    height: context.width * 0.8,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: AssetImage(AppImages.landingImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  context.vSpacing8,
                  Text(
                    'DISCOVER YOUR BEST \nBOOKS HERE',
                    textAlign: TextAlign.center,
                    style: context.textTheme.titleSmall,
                  ),
                  context.vSpacing20,
                  Text(
                    'Explore the exciting books based on interest and studies',
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyMedium,
                  ),
                  context.vSpacing24,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PrimaryButton(
                        title: 'Sign up',
                        onPressed: () {
                          Constants.navigationService
                              .navigateTo(AppRoutes.signUp);
                        },
                      ),
                      context.hSpacing24,
                      PrimaryButton.outlined(
                        title: 'Login',
                        onPressed: () {
                          Constants.navigationService
                              .navigateTo(AppRoutes.login);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
        );
      },
    );
  }
}

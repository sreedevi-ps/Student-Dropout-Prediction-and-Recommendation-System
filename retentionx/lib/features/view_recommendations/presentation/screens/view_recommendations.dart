import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:retentionx/core/colors/app_colors.dart';
import 'package:retentionx/core/snack_bar/show_snack_bar.dart';
import 'package:retentionx/core/widgets/buttons/common_button.dart';
import 'package:retentionx/core/widgets/loader/loader_widget.dart';
import 'package:retentionx/features/view_recommendations/presentation/bloc/view_recommendations_bloc.dart';
import 'package:retentionx/features/view_recommendations/presentation/widgets/recommendation_tile.dart';

class ScreenViewRecommendations extends StatefulWidget {
  const ScreenViewRecommendations({super.key});

  @override
  State<ScreenViewRecommendations> createState() =>
      _ScreenViewRecommendationsState();
}

class _ScreenViewRecommendationsState extends State<ScreenViewRecommendations> {
  final TextEditingController _querycontroller = TextEditingController();
  //dispose the controller
  @override
  void dispose() {
    _querycontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ViewRecommendationsBloc, ViewRecommendationsState>(
      listener: (context, state) {
        if (state is ViewRecommendationsError) {
          HapticFeedback.vibrate();
          showCustomSnackBar(context, state.message, isError: true);
        }
      },
      builder: (context, state) {
        return Scaffold(
            body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(spacing: 16, children: [
              // Text("Enter a course to get recommendations"),
              Container(
                color: Colors.black,
                child: Column(
                  spacing: 16,
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      //width: 250.0,
                      height: 40,
                      child: DefaultTextStyle(
                        style: GoogleFonts.nunito(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        child: AnimatedTextKit(
                          animatedTexts: [
                            TypewriterAnimatedText(
                                'Enter a course to get recommendations'),
                            // TypewriterAnimatedText('Design first, then code'),
                            // TypewriterAnimatedText('Do not patch bugs out, rewrite them'),
                            // TypewriterAnimatedText('Do not test bugs out, design them out'),
                          ],
                          onTap: () {
                            print("Tap Event");
                          },
                        ),
                      ),
                    ),
                    TextFormField(
                      cursorColor: Colors.white,
                      controller: _querycontroller,
                    ),
                    CommonButton(
                      onPressed: () {
                        context
                            .read<ViewRecommendationsBloc>()
                            .add(GetRecommendations(_querycontroller.text));
                      },
                      label: "Get recommendations",
                      btnColor: AppColors.orange,
                    ),
                  ],
                ),
              ),
              //TEXT FORM FIELD

              state is ViewRecommendationsLoading
                  ? LoaderWidget()
                  : state is ViewRecommendationsLoaded
                      ? Expanded(
                          child: ListView.separated(
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 10),
                            itemCount: state.recommendations.length,
                            itemBuilder: (context, index) {
                              return RecommendationTile(
                                  recommendation: state.recommendations[index]);
                            },
                          ),
                        )
                      : SizedBox.shrink(),
            ]),
          ),
        ));
      },
    );
  }
}

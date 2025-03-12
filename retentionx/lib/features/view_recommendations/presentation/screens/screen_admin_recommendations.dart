import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:retentionx/core/widgets/loader/loader_widget.dart';
import 'package:retentionx/features/profile/presentation/blocs/student_profile_bloc/student_profile_bloc.dart';
import 'package:retentionx/features/view_recommendations/presentation/widgets/recommendation_tile.dart';

class ScreenAdminRecommendations extends StatelessWidget {
  const ScreenAdminRecommendations({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentProfileBloc, StudentProfileState>(
        builder: (context, state) {
      return state is StudentProfileLoaded
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                spacing: 20,
                children: [
                  SizedBox(height: 20),
                  if (state.studentProfile.recommendation.isEmpty)
                    Center(
                      child: SizedBox(
                        //width: 250.0,
                        height: 200,
                        child: DefaultTextStyle(
                          style: GoogleFonts.nunito(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                          child: AnimatedTextKit(
                            animatedTexts: [
                              TypewriterAnimatedText('hey!'),
                              TypewriterAnimatedText(
                                  'No course recommendations by Mentor'),
                              TypewriterAnimatedText('Design first, then code'),
                              TypewriterAnimatedText(
                                  'Do not patch bugs out, rewrite them'),
                              TypewriterAnimatedText(
                                  'Do not test bugs out, design them out'),
                            ],
                            onTap: () {
                              print("Tap Event");
                            },
                          ),
                        ),
                      ),
                    ),
                  if (state.studentProfile.recommendation.isNotEmpty)
                    SizedBox(
                      //width: 250.0,
                      height: 50,
                      child: DefaultTextStyle(
                        style: GoogleFonts.nunito(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        child: AnimatedTextKit(
                          animatedTexts: [
                            TypewriterAnimatedText('hey!'),
                            TypewriterAnimatedText(
                                'Here is the  course recommendations by Mentor'),
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
                  if (state.studentProfile.recommendation.isNotEmpty)
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 10),
                        itemCount: state.studentProfile.recommendation.length,
                        itemBuilder: (context, index) {
                          return RecommendationTile(
                              recommendation:
                                  state.studentProfile.recommendation[index]);
                        },
                      ),
                    )
                ],
              ),
            )
          : LoaderWidget();
    });
  }
}

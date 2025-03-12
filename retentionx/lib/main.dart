import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:retentionx/core/colors/app_colors.dart';
import 'package:retentionx/core/themes/text_field_theme.dart';
import 'package:retentionx/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:retentionx/features/auth/presentation/screens/selection_screen.dart';
import 'package:retentionx/features/data_entry/presentation/bloc/bulk_upload_bloc/bulk_upload_bloc.dart';
import 'package:retentionx/features/data_entry/presentation/bloc/student_data_entry/student_data_entry_bloc.dart';
import 'package:retentionx/features/home/presentation/menu_changer_bloc/menu_changer_bloc.dart';
import 'package:retentionx/features/profile/presentation/blocs/admin_recommend/admin_recommend_bloc.dart';
import 'package:retentionx/features/profile/presentation/blocs/predict_bloc/predict_bloc.dart';
import 'package:retentionx/features/profile/presentation/blocs/student_profile_bloc/student_profile_bloc.dart';
import 'package:retentionx/features/splash_screen/splash_screen.dart';
import 'package:retentionx/features/student_list/presentation/bloc/student_list_bloc.dart';
import 'package:retentionx/features/view_recommendations/presentation/bloc/view_recommendations_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
        //StudentDataEntryBloc
        BlocProvider<StudentDataEntryBloc>(
            create: (context) => StudentDataEntryBloc()),

        //StudentListBloc
        BlocProvider<StudentListBloc>(create: (context) => StudentListBloc()),

        //StudentProfileBloc
        BlocProvider<StudentProfileBloc>(
            create: (context) => StudentProfileBloc()),

        //MenuChangerBloc

        BlocProvider<MenuChangerBloc>(create: (context) => MenuChangerBloc()),

        //ViewRecommendationsBloc

        BlocProvider<ViewRecommendationsBloc>(
            create: (context) => ViewRecommendationsBloc()),

        //PredictBloc
        BlocProvider<PredictBloc>(create: (context) => PredictBloc()),

        //AdminRecommendBloc
        BlocProvider<AdminRecommendBloc>(
          create: (context) => AdminRecommendBloc()),

          //BulkUploadBloc
        BlocProvider<BulkUploadBloc>(
          create: (context) => BulkUploadBloc()),
      ],
      child: Flexify(
        designWidth: 375,
        designHeight: 812,
        app: MaterialApp(
            theme: ThemeData(
                scaffoldBackgroundColor: AppColors.bgColor,
                textTheme: GoogleFonts.nunitoTextTheme(
                    Theme.of(context).textTheme.apply(bodyColor: Colors.white)),
                inputDecorationTheme: TextFieldTheme.themeTextForm()),
            debugShowCheckedModeBanner: false,
            home: SplashScreen()),
      ),
    );
  }
}

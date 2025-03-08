import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:retentionx/core/colors/app_colors.dart';
import 'package:retentionx/core/snack_bar/show_snack_bar.dart';
import 'package:retentionx/core/widgets/buttons/common_button.dart';
import 'package:retentionx/features/student_list/data/repo/students_list_repo.dart';
import 'package:retentionx/features/student_list/presentation/bloc/student_list_bloc.dart';
import 'package:retentionx/features/student_list/presentation/widgets/student_list_widget.dart';

class ScreenStudentsList extends StatefulWidget {
  const ScreenStudentsList({super.key});

  @override
  State<ScreenStudentsList> createState() => _ScreenStudentsListState();
}

class _ScreenStudentsListState extends State<ScreenStudentsList> {
  @override
  void initState() {
    //read
    context.read<StudentListBloc>().add(FetchStudentsList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentListBloc, StudentListState>(
      listener: (context, state) {
        if (state is StudentListError) {
          showCustomSnackBar(context, state.message, isError: true);
        }
      },
      builder: (context, state) {
        return state is StudentListSuccess ? StudentListWidget(
          students: state.students, 
        ) : SpinKitCircle(
          color: Colors.white,
          size: 40,
        );
      },
    );
  }
}

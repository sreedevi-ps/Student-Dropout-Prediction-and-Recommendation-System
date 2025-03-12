import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:retentionx/core/animation/app_animation_builder.dart';
import 'package:retentionx/core/colors/app_colors.dart';
import 'package:retentionx/core/snack_bar/show_snack_bar.dart';
import 'package:retentionx/core/widgets/loader/loader_widget.dart';
import 'package:retentionx/features/data_entry/presentation/bloc/bulk_upload_bloc/bulk_upload_bloc.dart';

class ExcelUploadButton extends StatelessWidget {
  const ExcelUploadButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BulkUploadBloc, BulkUploadState>(
      listener: (context, state) {
        print("the state is $state");
        if (state is BulkUploadSuccess) {
          print(state.message);
          QuickAlert.show(
              context: context,
              backgroundColor: AppColors.navBarColor,
              confirmBtnColor: AppColors.themeColor,
              type: QuickAlertType.success,
              text: 'Student data uploaded Successfully!',
              titleColor: Colors.white,
              textColor: Colors.white);
        } else if (state is BulkUploadError) {
          print(state.message);
          showCustomSnackBar(context, state.message, isError: true);
        }
      },
      builder: (context, state) {
        return AppAnimationBuilder(
          child: Padding(
            padding:
                const EdgeInsets.only(bottom: kBottomNavigationBarHeight + 25),
            child: Container(
              //boder radius
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.navBarColor,
              ),
              child: FloatingActionButton.extended(
                backgroundColor:
                    Colors.transparent, // Set to transparent to show gradient
                onPressed: () {
                  // Upload file
                  context.read<BulkUploadBloc>().add(UploadButtonPressed());
                },
                label: Text(
                  state is! BulkUploadLoading ? 'Upload' : "",
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                  ),
                ),
                icon: state is BulkUploadLoading
                    ? LoaderWidget()
                    : Image.asset(
                        'assets/excel.png',
                        height: 24, // Adjust the size of the icon as needed
                        width: 24,
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}

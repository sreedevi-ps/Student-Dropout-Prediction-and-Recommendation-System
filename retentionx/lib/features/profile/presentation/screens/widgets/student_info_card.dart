import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:retentionx/core/colors/app_colors.dart';

class StudentInfoCard extends StatelessWidget {
  const StudentInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 350,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.navBarColor,
          borderRadius: BorderRadius.circular(20),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black.withOpacity(0.2),
          //     blurRadius: 8,
          //     spreadRadius: 2,
          //     offset: const Offset(2, 4),
          //   ),
          // ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // College Name
            const Text(
              "Amal Jyothi College of Engineering",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            // KTU Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.secondPrimary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(LucideIcons.building, color: Colors.white, size: 18),
                  SizedBox(width: 6),
                  Text(
                    "KTU",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Registration Info
            const Text(
              "Joined 28th Sept’ 2021",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "Reg no: 3856PM",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                // color: Color(0xFF0F5D56),
              ),
            ),
            const SizedBox(height: 16),

            // Last Exam Info
            const Text(
              "Last Appeared Exam",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "Semester 6th",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                // color: Color(0xFF0F5D56),
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "(Tuesday 29th Sept’ 2023)",
              style: TextStyle(
                fontSize: 14,
                // color: Color(0xFF0F5D56),
              ),
            ),
            const SizedBox(height: 20),

            // Total Attendance
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Total\nAttendance",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  "720 DAYS",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    // color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

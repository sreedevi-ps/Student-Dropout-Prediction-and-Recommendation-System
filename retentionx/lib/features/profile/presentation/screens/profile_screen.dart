import 'package:flutter/material.dart';

// Color constants
class ProfileColors {
  static const Color primary = Color(0xFF006D77);
  static const Color cardBackground = Colors.white;
  static const Color textPrimary = Colors.black;
  static const Color textSecondary = Color(0xFF8C8C8C);
  static const Color presentTile = Color(0xFFE8F5E9);
  static const Color absentTile = Color(0xFFE3F2FD);
  static const Color leavesTile = Color(0xFFFFEBEE);
  static const Color presentText = Color(0xFF2E7D32);
  static const Color absentText = Color(0xFF1565C0);
  static const Color leavesText = Color(0xFFD32F2F);
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            _buildCollegeInfo(),
            _buildAttendanceStats(),
            _buildMonthlyAttendance(),
            _buildRecommendationsButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: ProfileColors.primary,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/profile_image.jpg'),
          ),
          const SizedBox(height: 10),
          Text(
            'JOHN DOE',
            style: TextStyle(
              color: ProfileColors.cardBackground,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '3rd Year (CSE)',
            style: TextStyle(
              color: ProfileColors.cardBackground,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCollegeInfo() {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Amal Jyothi College of Engineering',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: ProfileColors.textPrimary,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: ProfileColors.primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.account_balance, color: ProfileColors.cardBackground),
                  const SizedBox(width: 8),
                  Text(
                    'KTU',
                    style: TextStyle(color: ProfileColors.cardBackground),
                  ),
                ],
              ),
            ),
            _buildInfoRow('Joined', '28th Sept\' 2021'),
            _buildInfoRow('Reg no', '3856PM'),
            _buildInfoRow('Last Appeared Exam', 'Semester 6th\n(Tuesday 29th Sept\' 2023)'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              color: ProfileColors.textSecondary,
              fontSize: 16,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: ProfileColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceStats() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('Total\nAttendance', '720 DAYS'),
          _buildStatItem('Check-Out', '04:30 PM'),
          _buildStatItem('Work Hrs.', '07:30:10'),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: ProfileColors.textSecondary,
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          value,
          style: TextStyle(
            color: ProfileColors.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildMonthlyAttendance() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'This month\'s attendance',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: ProfileColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildAttendanceCard('Present', '22', ProfileColors.presentTile, ProfileColors.presentText),
              _buildAttendanceCard('Absent', '03', ProfileColors.absentTile, ProfileColors.absentText),
              _buildAttendanceCard('Leaves', '02', ProfileColors.leavesTile, ProfileColors.leavesText),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceCard(String label, String count, Color bgColor, Color textColor) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              color: textColor,
              fontSize: 16,
            ),
          ),
          Text(
            count,
            style: TextStyle(
              color: textColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationsButton() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ProfileColors.primary,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {},
        child: Text(
          'VIEW-RECOMMENDATIONS',
          style: TextStyle(
            color: ProfileColors.cardBackground,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}


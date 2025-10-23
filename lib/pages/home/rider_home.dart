import 'package:fasttrack/pages/job/job_page.dart';
import 'package:fasttrack/pages/profile/rider_profile.dart';
import 'package:flutter/material.dart';

class RiderHome extends StatelessWidget {
  const RiderHome({super.key});

  void _onItemTapped(BuildContext context, int index) {
    if (index == 0) {
      // อยู่หน้าแรกแล้ว
    } else if (index == 1) {

      //เอาไว้ทดสอบ
      final jobs = [
        {
          'id': 'JOB001',
          'image': 'https://picsum.photos/200',
          'destination': 'ส่งเอกสารด่วน',
          'date': '23 ต.ค. 2025',
          'sender': '123 ถนนสุขุมวิท, กรุงเทพฯ',
          'receiver': '99 ถนนพหลโยธิน, กรุงเทพฯ',
          'senderLat': '13.7563',
          'senderLng': '100.5018',
          'receiverLat': '13.7367',
          'receiverLng': '100.5231',
        },
      ];

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => JobPage(jobs: jobs)),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RiderProfile()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24),
            // ทักทายผู้ใช้
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage('assets/images/avatar.png'),
                ),
                SizedBox(width: 12),
                Text(
                  'สวัสดี, BaleKeetak',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(height: 24),

            // ช่องค้นหาสถานะพัสดุ
            TextField(
              decoration: InputDecoration(
                hintText: 'ตรวจสอบสถานะพัสดุ',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),

      // แถบเมนูด้านล่าง
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // ✅ ให้แสดง label ทุกอัน
        currentIndex: 0, // อยู่หน้าแรก
        selectedItemColor: const Color(0xFF4A25E1), // สีม่วงเข้ม
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        onTap: (index) => _onItemTapped(context, index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'หน้าแรก'),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: 'รับงาน'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'โปรไฟล์'),
        ],
      ),
    );
  }
}

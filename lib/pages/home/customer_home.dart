import 'package:fasttrack/pages/profile/customer_profile.dart';
import 'package:flutter/material.dart';

class CustomerHome extends StatelessWidget {
  const CustomerHome({super.key});

  void _onItemTapped(BuildContext context, int index) {
    if (index == 0) {
      // อยู่หน้าแรกแล้ว
    } else if (index == 1) {
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => ParcelDashboardScreen()),
      // );
    } else if (index == 2) {
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => SendParcelScreen()),
      // );
    } else if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CustomerProfile()),
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
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        onTap: (index) => _onItemTapped(context, index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'หน้าแรก'),
          BottomNavigationBarItem(
            icon: Icon(Icons.inbox),
            label: 'พัสดุของฉัน',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.send), label: 'ส่งพัสดุ'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'โปรไฟล์'),
        ],
      ),
    );
  }
}

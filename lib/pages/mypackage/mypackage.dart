import 'package:fasttrack/pages/profile/customer_profile.dart';
import 'package:flutter/material.dart';
import 'package:fasttrack/pages/home/customer_home.dart';
import 'package:fasttrack/pages/send/Packageinfo.dart';
import 'package:fasttrack/pages/send/emptyscreen.dart';


// 1. เปลี่ยนเป็น StatefulWidget
class Mypackage extends StatefulWidget {
  const Mypackage({super.key});

  @override
  State<Mypackage> createState() => _MypackageState();
}

class _MypackageState extends State<Mypackage> {
  // 2. เพิ่มตัวแปร State สำหรับเก็บค่าแท็บ
  int selectedTab = 0; // 0 = จัดส่ง, 1 = ได้รับ

  void _onItemTapped(BuildContext context, int index) {
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CustomerHome()),
      );
    } else if (index == 1) {
      
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => EmptyDashboardScreen()),
      );
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

            // 3. แท็บที่คัดลอกมา
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => selectedTab = 0),
                    child: Container(
                      padding: EdgeInsets.all(12),
                      color: selectedTab == 0
                          ? Colors.blue[100]
                          : Colors.grey[200],
                      child: Center(child: Text('รายการพัสดุที่จัดส่ง')),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => selectedTab = 1),
                    child: Container(
                      padding: EdgeInsets.all(12),
                      color: selectedTab == 1
                          ? Colors.blue[100]
                          : Colors.grey[200],
                      child: Center(child: Text('รายการพัสดุที่ได้รับ')),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16), // เพิ่มระยะห่าง
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
            SizedBox(height: 16), // เพิ่มระยะห่าง
            // 4. ส่วนแสดงผลตามแท็บที่เลือก
            Expanded(
              child: selectedTab == 0
                  ? _buildSentParcelList()
                  : _buildReceivedParcelList(),
            ),
          ],
        ),
      ),

      // แถบเมนูด้านล่าง
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // ✅ ให้แสดง label ทุกอัน
        currentIndex: 1, 
        selectedItemColor: const Color(0xFF4A25E1), // สีม่วงเข้ม
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        onTap: (index) => _onItemTapped(context, index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'หน้าแรก'),
          BottomNavigationBarItem(icon: Icon(Icons.inbox), label: 'พัสดุของฉัน'),
          BottomNavigationBarItem(icon: Icon(Icons.send), label: 'ส่งพัสดุ'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'โปรไฟล์'),
        ],
      ),
    );
  }

  // สร้าง Widget สำหรับแสดงเนื้อหาของแท็บ "จัดส่ง"
  Widget _buildSentParcelList() {
    // คุณสามารถคัดลอก ListView และ Card จาก ParcelDashboardScreen มาใส่ตรงนี้ได้
    return Center(child: Text('เนื้อหาของ: รายการพัสดุที่จัดส่ง'));
  }

  // สร้าง Widget สำหรับแสดงเนื้อหาของแท็บ "ได้รับ"
  Widget _buildReceivedParcelList() {
    return Center(child: Text('เนื้อหาของ: รายการพัสดุที่ได้รับ'));
  }
}

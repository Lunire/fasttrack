import 'package:fasttrack/pages/home/customer_home.dart';
import 'package:fasttrack/pages/profile/customer_profile.dart';
import 'package:fasttrack/pages/send/upload.dart';
import 'package:flutter/material.dart';
import 'package:fasttrack/pages/send/confirm.dart';
import 'package:fasttrack/pages/mypackage/mypackage.dart';

// หน้าจอ Dashboard 19 (Empty State)
class EmptyDashboardScreen extends StatefulWidget {
  const EmptyDashboardScreen({super.key});

  @override
  State<EmptyDashboardScreen> createState() => _EmptyDashboardScreenState();
}

class _EmptyDashboardScreenState extends State<EmptyDashboardScreen> {
  int _selectedIndex = 2; // ตั้งค่าเริ่มต้นให้ "ส่งพัสดุ" active

  // ในแอปพลิเคชันจริง ฟังก์ชันนี้จะนำทางไปยังหน้าต่างๆ
  // แต่ในตัวอย่างนี้จะแค่เปลี่ยนสถานะของ UI
  void _onItemTapped(BuildContext context, int index) {
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CustomerHome()),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Mypackage()),
      );
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
      // ไม่ต้องใช้ AppBar ในหน้านี้เพื่อให้ดูโล่ง
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. ปุ่ม "สร้างรายการส่งพัสดุ"
              ElevatedButton(
                onPressed: () {
                  // นำทางไปยังหน้าอัปโหลดรูป (Dashboard 21)
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UploadPackageScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A25E1), // สีม่วงเข้ม
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'สร้างรายการส่งพัสดุ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 64),

              // 2. ไอคอนกล่องพัสดุ
              Icon(
                Icons.inventory_2_outlined, // ไอคอนกล่อง
                size: 120,
                color: Colors.grey[300],
              ),
              const SizedBox(height: 32),

              // 3. ข้อความอธิบาย
              Text(
                'You have not ordered any delivery yet. Would you like to change that today?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  height: 1.5, // ระยะห่างระหว่างบรรทัด
                ),
              ),
            ],
          ),
        ),
      ),

      // 4. Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'หน้าแรก',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2_outlined),
            label: 'พัสดุของฉัน',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.send_outlined),
            activeIcon: Icon(Icons.send), // ไอคอนเมื่อถูกเลือก
            label: 'ส่งพัสดุ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'โปรไฟล์',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF4A25E1), // สีม่วงเข้ม
        unselectedItemColor: Colors.grey[600],
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
        type: BottomNavigationBarType.fixed, // ให้แสดง label ตลอด
        backgroundColor: Colors.white,
        elevation: 2.0, // เพิ่มเงาเล็กน้อย
        onTap: (index) => _onItemTapped(context, index),
      ),
    );
  }
}

import 'package:fasttrack/pages/auth/main_screen.dart';
import 'package:fasttrack/pages/home/rider_home.dart';
import 'package:flutter/material.dart';

class RiderProfile extends StatefulWidget {
  const RiderProfile({super.key});

  @override
  State<RiderProfile> createState() => _RiderProfileState();
}

class _RiderProfileState extends State<RiderProfile> {
  final nameController = TextEditingController(text: 'balekeetak');
  final phoneController = TextEditingController(text: '+66 812345678');
  final caridController = TextEditingController(text: 'กน 54873');

  void _onItemTapped(BuildContext context, int index) {
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RiderHome()),
      );
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
    }
  }

  Widget buildDisplayField({
    required IconData icon,
    required String label,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label อยู่ข้างนอก
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),

          // TextField
          TextField(
            controller: controller,
            enabled: false,
            decoration: InputDecoration(
              prefixIcon: Icon(icon),
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3532D7), // สีพื้นหลัง
                  foregroundColor: Colors.white, // สีตัวอักษร
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MainScreen()),
                  );
                },
                child: const Text(
                  'Log Out',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 30),

            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/avatar.png'),
            ),
            SizedBox(height: 24),

            buildDisplayField(
              icon: Icons.person,
              label: 'Person',
              controller: nameController,
            ),
            buildDisplayField(
              icon: Icons.phone,
              label: 'Mobile Number',
              controller: phoneController,
            ),
            buildDisplayField(
              icon: Icons.motorcycle,
              label: 'License plate',
              controller: caridController,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // ✅ ให้แสดง label ทุกอัน
        currentIndex: 2, // อยู่หน้าแรก
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
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

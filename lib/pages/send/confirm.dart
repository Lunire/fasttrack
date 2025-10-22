import 'package:fasttrack/pages/mypackage/mypackage.dart';
import 'package:flutter/material.dart';

import 'package:fasttrack/pages/home/customer_home.dart';
import 'package:fasttrack/pages/profile/customer_profile.dart';
import 'package:fasttrack/pages/send/Packageinfo.dart';
// import 'package:fasttrack/pages/parcel/parcel_dashboard_screen.dart'; // <== ถ้าจะใช้ 'พัสดุของฉัน'

// หน้าจอ Dashboard 26 & 27 (Order Confirmation)
class ConfirmationScreen extends StatefulWidget {
  const ConfirmationScreen({super.key});

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  // URL รูปจำลอง
  final String _simulatedPackageImageUrl =
      'https://placehold.co/100x80/e8e0ff/4A25E1?text=Package';
  final String _simulatedLargeImageUrl =
      'https://placehold.co/350x200/e8e0ff/4A25E1?text=Package+Image';

  // รายการพัสดุ (เริ่มต้นด้วย 1 รายการ)
  final List<Map<String, String>> _packages = [
    {'title': 'Package 1', 'destination': 'Destination'}
  ];

  // ฟังก์ชันสำหรับเพิ่มพัสดุ
  void _addPackage() {
    if (_packages.length < 5) {
      setState(() {
        _packages.add({
          'title': 'Package ${_packages.length + 1}',
          'destination': 'Destination'
        });
      });
      print('Package added! Total packages: ${_packages.length}');
    } else {
      print('Cannot add more than 5 packages.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You can only add up to 5 packages.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // --- ฟังก์ชันสำหรับ Bottom Navigation Bar ---
  void _onItemTapped(BuildContext context, int index) {
    // if (index == 0) {
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(builder: (context) => CustomerHome()),
    //   );
    // } else if (index == 1) {
    //   // นี่คือหน้า 'พัสดุของฉัน' - (ต้อง import)
    //   // Navigator.pushReplacement(
    //   //   context,
    //   //   MaterialPageRoute(builder: (context) => ParcelDashboardScreen()), 
    //   // );
    // } else if (index == 2) {
    //   // กลับไปหน้าส่งพัสดุ (หน้าก่อนหน้า)
    //   // ใช้ pushReplacement เพื่อไปหน้าหลักของ "Send" (หน้าฟอร์ม)
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(builder: (context) => SendParcelScreen()),
    //   );
    // } else if (index == 3) {
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(builder: (context) => CustomerProfile()),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50], // พื้นหลังสีเทาอ่อน
      appBar: AppBar(
        backgroundColor: Colors.white, // พื้นหลัง AppBar สีขาว
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(), // กดกลับไปหน้าฟอร์ม
        ),
        title: const Text(
          'Delivery',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: _packages.length == 1
                  ? _buildSinglePackageView(
                      context) // <== แสดงผลแบบ Dashboard 26
                  : _buildMultiPackageView(
                      context), // <== แสดงผลแบบ Dashboard 27
            ),
          ),
          _buildBottomBar(context)
        ],
      ),
      
      // --- นี่คือ Nav Bar ที่คุณต้องการในไฟล์ใหม่นี้ ---
      // bottomNavigationBar: BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   currentIndex: 2, // ตั้งค่าให้แท็บ "ส่งพัสดุ" ถูกเลือก
      //   selectedItemColor: Colors.blueAccent, 
      //   unselectedItemColor: Colors.grey,
      //   onTap: (index) => _onItemTapped(context, index),
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'หน้าแรก'),
      //     BottomNavigationBarItem(icon: Icon(Icons.inbox), label: 'พัสดุของฉัน'),
      //     BottomNavigationBarItem(icon: Icon(Icons.send), label: 'ส่งพัสดุ'),
      //     BottomNavigationBarItem(icon: Icon(Icons.person), label: 'โปรไฟล์'),
      //   ],
      // ),
    );
  }

  // --- Widget สำหรับแสดงผลแบบ Dashboard 26 (พัสดุชิ้นเดียว) ---
  Widget _buildSinglePackageView(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[200]!, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(11),
              child: Image.network(
                _simulatedLargeImageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Center(child: Icon(Icons.image_not_supported)),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Delivery Details (MAY23230024)',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildInfoRow(
              Icons.gps_fixed, 'Pick up location', const Color(0xFF4A25E1)),
          const SizedBox(height: 12),
          _buildInfoRow(
              Icons.location_on_outlined, 'Destination', Colors.blue),
          const SizedBox(height: 12),
          _buildInfoRow(
              Icons.calendar_today_outlined, 'Today', Colors.grey[700]!),
          const SizedBox(height: 12),
          _buildInfoRow(
              Icons.access_time_outlined, 'Anytime', Colors.grey[700]!),
          const Divider(height: 40),
          _buildSectionTitle('Sender'),
          _buildInfoRow(Icons.person_outline, 'Oluwatobi', Colors.grey[700]!),
          const SizedBox(height: 12),
          _buildInfoRow(Icons.phone_outlined, '0825666788', Colors.grey[700]!),
          const Divider(height: 40),
          _buildSectionTitle('Receiver'),
          _buildInfoRow(Icons.person_outline, 'Oluwatobi', Colors.grey[700]!),
          const SizedBox(height: 12),
          _buildInfoRow(Icons.phone_outlined, '0825666788, 09067776777',
              Colors.grey[700]!),
          const Divider(height: 40),
          _buildAddPackageRow(context),
        ],
      ),
    );
  }

  // --- Widget สำหรับแสดงผลแบบ Dashboard 27 (พัสดุหลายชิ้น) ---
  Widget _buildMultiPackageView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Delivery Details (MAY23230024)',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),
        _buildInfoRow(
            Icons.gps_fixed, 'Pick up location', const Color(0xFF4A25E1)),
        const SizedBox(height: 16),
        Column(
          children: _packages.map((package) {
            int index = _packages.indexOf(package);
            return _buildPackageCard(
              imageUrl: _simulatedPackageImageUrl,
              title: 'Package ${index + 1}',
              subtitle: package['destination']!,
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
        if (_packages.length < 5)
          _buildAddPackageRow(context)
        else
          const SizedBox(height: 24),
      ],
    );
  }

  // --- Widget ส่วนล่างสุดของจอ (ใช้ร่วมกัน) ---
  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
      color: _packages.length > 1 ? Colors.white : Colors.grey[50],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'You can add up to 5 packages with same pick up location',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              print('Order Confirmed with ${_packages.length} packages!');
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const Mypackage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4A25E1),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Confirm Order',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Helper Widgets (ใช้ร่วมกัน) ---
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildPackageCard(
      {required String imageUrl,
      required String title,
      required String subtitle}) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[200]!),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Center(child: Icon(Icons.image_not_supported)),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, Color iconColor) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: 24),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 16, color: Colors.grey[800]),
          ),
        ),
      ],
    );
  }

  Widget _buildAddPackageRow(BuildContext context) {
    return InkWell(
      onTap: _addPackage,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: const [
            Icon(Icons.add_circle_outline,
                color: Color(0xFF4A25E1), size: 24),
            SizedBox(width: 16),
            Text(
              'Add Another Package',
              style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF4A25E1),
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
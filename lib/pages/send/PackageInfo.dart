import 'package:flutter/material.dart';
import 'package:fasttrack/pages/home/customer_home.dart';
import 'package:fasttrack/pages/profile/customer_profile.dart';
import 'package:fasttrack/pages/send/confirm.dart';
 // <--- เพิ่ม import สำหรับหน้าที่ปุ่ม "ต่อไป" จะไป

// เปลี่ยนเป็น StatefulWidget
class SendParcelScreen extends StatefulWidget {
  const SendParcelScreen({super.key});

  @override
  State<SendParcelScreen> createState() => _SendParcelScreenState();
}

class _SendParcelScreenState extends State<SendParcelScreen> {
  // --- สถานะจาก DeliveryFormScreen ---
  bool _isToday = false;
  bool _isAnytime = false;

  // --- Logic การนำทางจาก SendParcelScreen เดิม ---
  void _onItemTapped(BuildContext context, int index) {
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CustomerHome()),
      );
    } else if (index == 1) {
      // นี่คือหน้า 'พัสดุของฉัน' - (ยังไม่ได้ระบุ)
    } else if (index == 2) {
      // นี่คือหน้าปัจจุบัน ('ส่งพัสดุ') ไม่ต้องทำอะไร
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
      // --- ใช้ AppBar และ Body จาก DeliveryFormScreen ---
      backgroundColor: const Color(0xFFFDFDFD),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // เอาปุ่ม back ออก เพราะนี่คือหน้าหลักในแท็บ
        automaticallyImplyLeading: false, 
        title: const Text(
          'Delivery',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section: Location
              _buildSectionTitle('Location'),
              const SizedBox(height: 16),
              _buildLocationTextField('From', 'Enter Pick up location'),
              const SizedBox(height: 16),
              _buildLocationTextField('To', 'Enter Destination'),
              const SizedBox(height: 24),

              // Section: Receiver
              _buildSectionTitle('Receiver'),
              const SizedBox(height: 16),
              _buildTextField(label: 'Receiver\'s Name', hint: 'Enter name'),
              const SizedBox(height: 16),
              _buildTextField(
                label: 'Receiver\'s Phone Number',
                hint: 'Phone Number',
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 24),

              // Section: Alternative Number
              _buildSectionTitle('Alternative Number (Optional)'),
              const SizedBox(height: 16),
              _buildTextField(
                label: 'Phone Number',
                hint: 'Phone Number',
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 24),

              // Section: Date & Time
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(label: 'Date', hint: '10-05-2025'),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField(label: 'Time', hint: '12:00'),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Section: Checkboxes
              Row(
                children: [
                  _buildCheckboxRow(
                    title: 'Today?',
                    value: _isToday,
                    onChanged: (val) {
                      setState(() {
                        _isToday = val ?? false;
                      });
                    },
                  ),
                  const SizedBox(width: 24),
                  _buildCheckboxRow(
                    title: 'Anytime?',
                    value: _isAnytime,
                    onChanged: (val) {
                      setState(() {
                        _isAnytime = val ?? false;
                      });
                    },
                  ),
                ],
              ), 

              // --- ปุ่ม "ต่อไป" ---
              const SizedBox(height: 32), 
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // นำทางไปยังหน้า Confirmation (Dashboard 26)
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ConfirmationScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF4A25E1), // ใช้สีม่วงหลัก
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'ต่อไป', // 'Next' in Thai
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // --- ใช้ BottomNavigationBar จาก SendParcelScreen เดิม ---
      // bottomNavigationBar: BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed, // ✅ ให้แสดง label ทุกอัน
      //   currentIndex: 1, // <--- แก้ไขเป็น 2 (ส่งพัสดุ)
      //   selectedItemColor: Colors.blueAccent, // สีของ Nav Bar เดิม
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

  // --- Helper Widgets จาก DeliveryFormScreen ---

  // Helper Widget สำหรับสร้างหัวข้อ Section
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  // Helper Widget สำหรับสร้าง Text Field ทั่วไป
  Widget _buildTextField({
    required String label,
    required String hint,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
              fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        TextField(
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey),
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ],
    );
  }

  // Helper Widget สำหรับสร้าง Text Field ที่มี Icon (Location)
  Widget _buildLocationTextField(String label, String hint) {
    // ใช้สีม่วงหลัก
    const Color primaryColor = Color(0xFF4A25E1);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
              fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey),
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            suffixIcon: Container(
              margin: const EdgeInsets.all(6),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.1), // สีม่วงอ่อน
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.location_on,
                color: primaryColor, // สีม่วงเข้ม
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Helper Widget สำหรับสร้าง Checkbox พร้อมข้อความ
  Widget _buildCheckboxRow({
    required String title,
    required bool value,
    required ValueChanged<bool?> onChanged,
  }) {
    // ใช้สีม่วงหลัก
    const Color primaryColor = Color(0xFF4A25E1);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: primaryColor, // สีม่วง
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            side: const BorderSide(color: Colors.grey, width: 2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 14, color: Colors.black87),
        ),
      ],
    );
  }
}
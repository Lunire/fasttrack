import 'package:flutter/material.dart';
import 'package:fasttrack/pages/send/Packageinfo.dart'; // <--- เพิ่ม import สำหรับหน้าที่ปุ่ม "ต่อไป" จะไป


// หน้าจอ Dashboard 21 (Upload Picture)
// เปลี่ยนเป็น StatefulWidget เพื่อจัดการสถานะการเลือกรูป
class UploadPackageScreen extends StatefulWidget {
  const UploadPackageScreen({super.key});

  @override
  State<UploadPackageScreen> createState() => _UploadPackageScreenState();
}

class _UploadPackageScreenState extends State<UploadPackageScreen> {
  bool _imageSelected = false;
  // URL รูปจำลอง (เหมือนใน Dashboard 22)
  final String _simulatedImageUrl =
      'https://placehold.co/350x200/e8e0ff/4A25E1?text=Package+Image';

  // ฟังก์ชันจำลองการเลือกรูป
  void _simulateImagePick() {
    setState(() {
      _imageSelected = true;
    });
    // ในแอปจริง, ตรงนี้จะเรียกใช้ image_picker เพื่อเปิดกล้อง/คลังภาพ
    print('Simulating image pick... Image selected!');
  }

  // ฟังก์ชันสำหรับปุ่ม
  void _handleButtonPress() {
    if (_imageSelected) {
      // ถ้ารูปถูกเลือกแล้ว, ไปหน้าถัดไป
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SendParcelScreen()),
      );
    } else {
      // ถ้ารูปยังไม่ถูกเลือก, ทำการ "เลือกรูป"
      _simulateImagePick();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Delivery',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          // จัดให้อยู่กลางๆ แต่ไม่จำเป็นต้อง center เป๊ะๆ
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 64), // ดันลงมาจาก AppBar

            // --- ส่วนแสดงผล (เปลี่ยนตามสถานะ) ---
            if (_imageSelected)
              _buildImagePlaceholder() // แสดงรูปที่ "เลือกแล้ว"
            else
              _buildUploadPrompt(), // แสดง UI เริ่มต้นสำหรับอัปโหลด

            const Spacer(), // ดันปุ่มไปด้านล่าง

            // --- ปุ่ม (เปลี่ยนตามสถานะ) ---
            ElevatedButton(
              onPressed: _handleButtonPress,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4A25E1),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                _imageSelected ? 'ต่อไป' : 'กล้อง', // เปลี่ยนข้อความปุ่ม
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
                height: 40), // เพิ่มช่องว่างด้านล่างปุ่ม
          ],
        ),
      ),
    );
  }

  // Widget สำหรับแสดง UI เริ่มต้น (ไอคอน + ข้อความ)
  Widget _buildUploadPrompt() {
    return Column(
      children: [
        // 1. ไอคอนกล่องพัสดุ
        Icon(
          Icons.inventory_2_outlined, // ไอคอนกล่อง
          size: 150,
          color: Colors.grey[300],
        ),
        const SizedBox(height: 32),

        // 2. ข้อความ Title
        const Text(
          'A picture of the package',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),

        // 3. ข้อความอธิบาย
        Text(
          'Please upload a picture of your package. Ensure you capture all the sides of the package.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
            height: 1.5,
          ),
        ),
      ],
    );
  }

  // Widget สำหรับแสดงรูปที่ "เลือกแล้ว" (จำลอง)
  Widget _buildImagePlaceholder() {
    // อ้างอิงดีไซน์จาก Dashboard 22
    return Column(
      children: [
        Container(
          height: 200, // กำหนดความสูง
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF4A25E1), width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              _simulatedImageUrl,
              fit: BoxFit.cover,
              // Error handling
              errorBuilder: (context, error, stackTrace) => const Center(
                child: Icon(
                  Icons.image_not_supported_outlined,
                  color: Colors.grey,
                  size: 50,
                ),
              ),
              // Loading indicator
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFF4A25E1),
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 32),
        const Text(
          'Package Image Ready',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Press "Next" to continue.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

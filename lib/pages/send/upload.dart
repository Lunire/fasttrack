import 'package:flutter/material.dart';
import 'package:fasttrack/pages/send/Packageinfo.dart'; // หน้าถัดไป

class UploadPackageScreen extends StatefulWidget {
  const UploadPackageScreen({super.key});

  @override
  State<UploadPackageScreen> createState() => _UploadPackageScreenState();
}

class _UploadPackageScreenState extends State<UploadPackageScreen> {
  bool _imageSelected = false;

  final String _simulatedImageUrl =
      'https://placehold.co/350x200/e8e0ff/4A25E1?text=Package+Image';

  // ฟังก์ชันจำลองการเลือกรูป
  void _simulateImagePick(String source) {
    setState(() {
      _imageSelected = true;
    });
    print('Picked image from $source');
  }

  // ✅ Popup ให้เลือกว่าจะใช้กล้องหรือคลัง
  void _showImageSourceOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Wrap(
              children: [
                const Center(
                  child: Text(
                    'เลือกรูปภาพจาก',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.camera_alt_outlined,
                      color: Color(0xFF4A25E1)),
                  title: const Text('กล้อง'),
                  onTap: () {
                    Navigator.pop(context);
                    _simulateImagePick('camera');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_outlined,
                      color: Color(0xFF4A25E1)),
                  title: const Text('คลังรูปภาพ'),
                  onTap: () {
                    Navigator.pop(context);
                    _simulateImagePick('gallery');
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ฟังก์ชันของปุ่มหลัก
  void _handleButtonPress() {
    if (_imageSelected) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SendParcelScreen()),
      );
    } else {
      _showImageSourceOptions();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 64),
            if (_imageSelected)
              _buildImagePlaceholder()
            else
              _buildUploadPrompt(),
            const Spacer(),
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
                _imageSelected ? 'ต่อไป' : 'รูปภาพ',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // --- UI เริ่มต้น ---
  Widget _buildUploadPrompt() {
    return Column(
      children: [
        Icon(Icons.inventory_2_outlined, size: 150, color: Colors.grey[300]),
        const SizedBox(height: 32),
        const Text(
          'A picture of the package',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 16),
        Text(
          'Please upload a picture of your package. Ensure you capture all the sides of the package.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.grey[600], height: 1.5),
        ),
      ],
    );
  }

  // --- แสดงรูปที่เลือกแล้ว ---
  Widget _buildImagePlaceholder() {
    return Column(
      children: [
        Container(
          height: 200,
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
              errorBuilder: (context, error, stackTrace) => const Center(
                child: Icon(Icons.image_not_supported_outlined,
                    color: Colors.grey, size: 50),
              ),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(
                  child: CircularProgressIndicator(color: Color(0xFF4A25E1)),
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
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 16),
        Text(
          'Press "Next" to continue.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.grey[600], height: 1.5),
        ),
      ],
    );
  }
}

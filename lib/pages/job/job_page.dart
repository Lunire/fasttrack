import 'package:fasttrack/pages/home/rider_home.dart';
import 'package:fasttrack/pages/profile/rider_profile.dart';
import 'package:flutter/material.dart';

class JobPage extends StatelessWidget {
  final List<Map<String, String>> jobs;

  const JobPage({super.key, this.jobs = const []});

  void _onItemTapped(BuildContext context, int index) {
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RiderHome()),
      );
    } else if (index == 1) {
      // อยู่หน้า JobPage เอง ไม่ต้องทำอะไร
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
      body: jobs.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: jobs.length,
              itemBuilder: (context, index) {
                final job = jobs[index];
                return _buildJobCard(context, job);
              },
            ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // ✅ ให้แสดง label ทุกอัน
        currentIndex: 1, // อยู่หน้าแรก
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

  Widget _buildJobCard(BuildContext context, Map<String, String> job) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                job['image'] ?? 'https://via.placeholder.com/60',
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    job['id'] ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    job['destination'] ?? '',
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'รับงาน',
                    style: TextStyle(color: Colors.blue, fontSize: 12),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  job['date'] ?? '',
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inventory_2_outlined,
            size: 100,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          const Text(
            'ยังไม่มีงานในขณะนี้',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

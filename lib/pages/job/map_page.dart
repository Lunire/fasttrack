import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget {
  final String senderAddress;
  final String receiverAddress;
  final LatLng senderLocation;
  final LatLng receiverLocation;

  const MapPage({
    super.key,
    required this.senderAddress,
    required this.receiverAddress,
    required this.senderLocation,
    required this.receiverLocation,
  });

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final MapController _mapController = MapController();
  LatLng? _riderPosition;

  @override
  void initState() {
    super.initState();
    _initRiderLocation();
  }

  Future<void> _initRiderLocation() async {
    try {
      // ดึงตำแหน่งปัจจุบันครั้งแรก
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _riderPosition = LatLng(position.latitude, position.longitude);
      });
      _mapController.move(_riderPosition!, 15);

      // ฟังตำแหน่งแบบ realtime
      Geolocator.getPositionStream(
        locationSettings:
            const LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: 5),
      ).listen((pos) {
        setState(() {
          _riderPosition = LatLng(pos.latitude, pos.longitude);
        });
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('ไม่สามารถระบุตำแหน่ง Rider ได้: $e')),
      );
    }
  }

  void _moveToRider() {
    if (_riderPosition != null) _mapController.move(_riderPosition!, 15);
  }

  @override
  Widget build(BuildContext context) {
    // วาง Polyline จาก Rider → Sender → Receiver
    List<LatLng> polylinePoints = [
      if (_riderPosition != null) _riderPosition!,
      widget.senderLocation,
      widget.receiverLocation,
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('เส้นทางการจัดส่ง')),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: widget.senderLocation,
              initialZoom: 13,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://api.maptiler.com/maps/streets-v2/{z}/{x}/{y}.png?key={apiKey}',
                additionalOptions: {'apiKey': 'hKjBu51NtvFgjybUWSEP'},
                userAgentPackageName: 'com.mycompany.deliveryapp',
              ),
              MarkerLayer(
                markers: [
                  if (_riderPosition != null)
                    Marker(
                      point: _riderPosition!,
                      width: 60,
                      height: 60,
                      child: const Icon(Icons.person_pin_circle, color: Colors.blue, size: 40),
                    ),
                  Marker(
                    point: widget.senderLocation,
                    width: 60,
                    height: 60,
                    child: const Icon(Icons.location_pin, color: Colors.green, size: 40),
                  ),
                  Marker(
                    point: widget.receiverLocation,
                    width: 60,
                    height: 60,
                    child: const Icon(Icons.flag, color: Colors.red, size: 40),
                  ),
                ],
              ),
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: polylinePoints,
                    color: Colors.purple,
                    strokeWidth: 4,
                  ),
                ],
              ),
            ],
          ),

          // ปุ่มเลื่อนกลับ Rider
          Positioned(
            top: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: _moveToRider,
              backgroundColor: Colors.white,
              child: const Icon(Icons.my_location, color: Colors.blue),
            ),
          ),

          // แสดงที่อยู่ผู้ส่ง/ผู้รับ
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, -2)),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildAddressTile(Icons.send, 'ที่อยู่ผู้ส่ง', widget.senderAddress),
                  const SizedBox(height: 8),
                  _buildAddressTile(Icons.home, 'ที่อยู่ผู้รับ', widget.receiverAddress),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressTile(IconData icon, String label, String address) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                Text(address, style: const TextStyle(fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

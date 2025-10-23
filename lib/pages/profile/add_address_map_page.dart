import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

const String API_ENDPOINT = "http://10.0.2.2:3000"; // ✅ ใช้กับ Emulator

class AddAddressMapPage extends StatefulWidget {
  const AddAddressMapPage({super.key});

  @override
  State<AddAddressMapPage> createState() => _AddAddressMapPageState();
}

class _AddAddressMapPageState extends State<AddAddressMapPage> {
  final MapController _mapController = MapController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _coordinatesController = TextEditingController();
  final TextEditingController _shortNameController = TextEditingController();

  LatLng? _currentPosition;
  LatLng? _selectedPosition;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('กรุณาเปิด GPS')));
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('ไม่ได้รับอนุญาตให้เข้าถึงตำแหน่ง')),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ไม่สามารถขออนุญาตเข้าถึงตำแหน่งได้')),
      );
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        _selectedPosition = _currentPosition;
        _isLoading = false;
      });

      _mapController.move(_currentPosition!, 15.0);
      _reverseGeocode(_currentPosition!);
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  // 🔹 Reverse Geocode
  Future<void> _reverseGeocode(LatLng position) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        String address =
            '${place.name ?? ''}, ${place.street ?? ''}, ${place.locality ?? ''}, ${place.administrativeArea ?? ''}, ${place.postalCode ?? ''}';

        String shortName = place.name ?? place.locality ?? 'ตำแหน่งที่เลือก';

        setState(() {
          _addressController.text = address;
          _coordinatesController.text =
              '${position.latitude.toStringAsFixed(6)}, ${position.longitude.toStringAsFixed(6)}';
          _shortNameController.text = shortName;
        });
      }
    } catch (e) {
      _addressController.text = 'ไม่สามารถค้นหาที่อยู่ได้';
      _coordinatesController.text = 'N/A';
      _shortNameController.text = 'ไม่ทราบชื่อสถานที่';
    }
  }

  // 🔹 เมื่อแตะบนแผนที่
  void _handleTap(TapPosition tapPosition, LatLng position) {
    setState(() {
      _selectedPosition = position;
    });
    _reverseGeocode(position);
  }

  // 🔹 ปุ่มรีเซ็ตตำแหน่งปัจจุบัน
  void _resetToCurrentLocation() {
    if (_currentPosition != null) {
      _mapController.move(_currentPosition!, 15.0);
      _reverseGeocode(_currentPosition!);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ยังไม่สามารถระบุตำแหน่งปัจจุบันได้')),
      );
    }
  }

  // 🔹 ฟังก์ชันยืนยันที่อยู่
  void _confirmAddress() async {
    if (_addressController.text.isEmpty ||
        _selectedPosition == null ||
        _addressController.text == 'ไม่สามารถค้นหาที่อยู่ได้') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('กรุณารอ... กำลังค้นหาพิกัด')),
      );
      return;
    }

    final String apiUrl = "$API_ENDPOINT/users/address";
    final String locationName = _addressController.text;
    final String gpsCoordinates =
        '${_selectedPosition!.latitude},${_selectedPosition!.longitude}';

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({
          'locationName': locationName,
          'gpsCoordinates': gpsCoordinates,
        }),
      );

      Navigator.of(context).pop();

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('บันทึกที่อยู่สำเร็จ!')));
        Navigator.pop(context);
      } else {
        final errorData = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('เกิดข้อผิดพลาด: ${errorData['error']}')),
        );
      }
    } catch (e) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('การเชื่อมต่อล้มเหลว: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // ✅ ป้องกัน Overflow เมื่อคีย์บอร์ดขึ้น
      appBar: AppBar(
        title: const Text('เลือกที่อยู่'),
        backgroundColor: const Color(0xFF3532D7),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter:
                        _currentPosition ?? const LatLng(13.7563, 100.5018),
                    initialZoom: 15.0,
                    onTap: _handleTap,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://api.maptiler.com/maps/streets-v2/{z}/{x}/{y}.png?key={apiKey}',
                      additionalOptions: {
                        'apiKey': 'hKjBu51NtvFgjybUWSEP',
                      },
                      userAgentPackageName: 'com.mycompany.deliveryapp',
                    ),
                    if (_selectedPosition != null)
                      MarkerLayer(
                        markers: [
                          Marker(
                            width: 80.0,
                            height: 80.0,
                            point: _selectedPosition!,
                            child: const Icon(
                              Icons.location_pin,
                              color: Colors.red,
                              size: 40.0,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),

                // 🧭 ปุ่มรีเซ็ตตำแหน่งปัจจุบัน
                Positioned(
                  top: 16,
                  right: 16,
                  child: FloatingActionButton(
                    backgroundColor: Colors.white,
                    elevation: 4,
                    onPressed: _resetToCurrentLocation,
                    child:
                        const Icon(Icons.my_location, color: Colors.blueAccent),
                  ),
                ),

                // 🔹 กล่องข้อมูลด้านล่าง
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: SingleChildScrollView(
                    child: Card(
                      margin: const EdgeInsets.all(0),
                      elevation: 10,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 10),
                            TextField(
                              controller: _addressController,
                              enabled: false,
                              maxLines: 2,
                              decoration: InputDecoration(
                                labelText: 'ที่อยู่ที่เลือก',
                                prefixIcon:
                                    const Icon(Icons.location_on_outlined),
                                filled: true,
                                fillColor: Colors.grey[100],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              controller: _coordinatesController,
                              enabled: false,
                              decoration: InputDecoration(
                                labelText: 'พิกัด (ละติจูด, ลองจิจูด)',
                                prefixIcon: const Icon(Icons.map_outlined),
                                filled: true,
                                fillColor: Colors.grey[100],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF3532D7),
                                foregroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: _confirmAddress,
                              child: const Text(
                                'ยืนยันที่อยู่',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

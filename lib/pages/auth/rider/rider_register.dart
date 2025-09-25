import 'package:fasttrack/pages/home/rider_home.dart';
import 'package:flutter/material.dart';

class RiderRegister extends StatefulWidget {
  const RiderRegister({super.key});

  @override
  State<RiderRegister> createState() => _RiderRegisterState();
}

class _RiderRegisterState extends State<RiderRegister> {
  bool _obscureText = true;
  bool _obscureTextConfirm = true;

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Choose Image Source'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: Popup,
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: Popup,
              ),
            ],
          ),
        );
      },
    );
  }

  void Popup() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // แถวด้านบน (ปุ่มกลับและเวลา)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // ปุ่ม Back
                    Container(
                      width: 40,
                      height: 40,
                      child: IconButton(
                        onPressed: Popup,
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Color(0xFF414141),
                          size: 20,
                        ),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // ช่องอัพโหลดรูปภาพ (วงกลม)
                Center(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: _showImageSourceDialog,
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: const Color(0xFFD0D0D0).withOpacity(0.3),
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                              color: Color(0xFFD0D0D0),
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            color: Color(0xFFD0D0D0),
                            size: 40,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // ช่อง User Name
                const Text(
                  'User Name',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 12,
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 8),
                Material(
                  color: Colors.white,
                  elevation: 4,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'User Name',
                      labelStyle: const TextStyle(color: Color(0xFF98A1B3)),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFFE6E7EE),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFFE6E7EE),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Color(0xFF98A1B3),
                      ),
                    ),
                    style: const TextStyle(color: Color(0xFF98A1B3)),
                    cursorColor: Color(0xFF98A1B3),
                  ),
                ),

                const SizedBox(height: 20),

                // ช่อง Phone
                const Text(
                  'Phone',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 12,
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 8),
                Material(
                  color: Colors.white,
                  elevation: 4,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Phone',
                      labelStyle: const TextStyle(color: Color(0xFF98A1B3)),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFFE6E7EE),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFFE6E7EE),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      prefixIcon: const Icon(
                        Icons.phone,
                        color: Color(0xFF98A1B3),
                      ),
                    ),
                    style: const TextStyle(color: Color(0xFF98A1B3)),
                    cursorColor: Color(0xFF98A1B3),
                  ),
                ),

                const SizedBox(height: 20),

                // ช่อง Password
                const Text(
                  'Password',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 12,
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 8),
                Material(
                  color: Colors.white,
                  elevation: 4,
                  child: TextField(
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: const TextStyle(color: Color(0xFF98A1B3)),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFFE6E7EE),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFFE6E7EE),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Color(0xFF98A1B3),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: const Color(0xFF98A1B3),
                        ),
                        onPressed: ToggelPassword,
                      ),
                    ),
                    style: const TextStyle(color: Color(0xFF98A1B3)),
                    cursorColor: Color(0xFF98A1B3),
                  ),
                ),

                const SizedBox(height: 20),

                // ช่อง Confirm Password
                const Text(
                  'Confirm Password',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 12,
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 8),
                Material(
                  color: Colors.white,
                  elevation: 4,
                  child: TextField(
                    obscureText: _obscureTextConfirm,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      labelStyle: const TextStyle(color: Color(0xFF98A1B3)),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFFE6E7EE),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFFE6E7EE),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Color(0xFF98A1B3),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureTextConfirm
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: const Color(0xFF98A1B3),
                        ),
                        onPressed: ToggelConfirmPassword,
                      ),
                    ),
                    style: const TextStyle(color: Color(0xFF98A1B3)),
                    cursorColor: Color(0xFF98A1B3),
                  ),
                ),

                const SizedBox(height: 28),

                // ช่องอัพโหลดรูปภาพ
                Center(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: _showImageSourceDialog,
                        child: Container(
                          width: 300,
                          height: 200,
                          decoration: BoxDecoration(
                            color: const Color(0xFFD0D0D0).withOpacity(0.3),
                            borderRadius: BorderRadius.circular(0),
                            border: Border.all(
                              color: Color(0xFFD0D0D0),
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            color: Color(0xFFD0D0D0),
                            size: 40,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  'Number Plate',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 12,
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 8),
                Material(
                  color: Colors.white,
                  elevation: 4,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Number Plate',
                      labelStyle: const TextStyle(color: Color(0xFF98A1B3)),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFFE6E7EE),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFFE6E7EE),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      prefixIcon: const Icon(
                        Icons.motorcycle,
                        color: Color(0xFF98A1B3),
                      ),
                    ),
                    style: const TextStyle(color: Color(0xFF98A1B3)),
                    cursorColor: Color(0xFF98A1B3),
                  ),
                ),

                const SizedBox(height: 40),

                // ปุ่ม Submit
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: Submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF3532D7),
                      foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      textStyle: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    child: const Text('Submit'),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void Submit() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RiderHome()),
    );
  }

  void ToggelConfirmPassword() {
    setState(() {
      _obscureTextConfirm = !_obscureTextConfirm; // toggle ซ่อน/แสดง
    });
  }

  void ToggelPassword() {
    setState(() {
      _obscureText = !_obscureText; // toggle ซ่อน/แสดง
    });
  }
}

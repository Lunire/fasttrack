import 'package:fasttrack/pages/auth/main_screen.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscureText = true; // เริ่มต้นเป็นซ่อนรหัสผ่าน

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3532D7),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),

              // ชื่อแอป
              const Text(
                'FastTrack',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
              ),

              const SizedBox(height: 53),

              // ช่อง User Name
              Material(
                color: Colors.white,
                elevation: 4,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'User Name',
                    labelStyle: const TextStyle(color: Color(0xFF98A1B3)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xFF98A1B3),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(0),
                    ),
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Color(0xFF98A1B3),
                    ),
                  ),
                  style: const TextStyle(
                    color: Color(0xFF98A1B3),
                  ), // สีตัวอักษร
                  cursorColor: Color(0xFF98A1B3), // สีเคอร์เซอร์
                ),
              ),

              const SizedBox(height: 32),

              // ช่อง Password
              Material(
                color: Colors.white,
                elevation: 4,
                child: TextField(
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: const TextStyle(
                      color: Color(0xFF98A1B3),
                    ), // label สี #98A1B3
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xFF98A1B3),
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
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: const Color(0xFF98A1B3),
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText; // toggle ซ่อน/แสดง
                        });
                      },
                    ), // icon สีเดียวกัน
                  ),
                  style: const TextStyle(
                    color: Color(0xFF98A1B3),
                  ), // font สี #98A1B3
                  cursorColor: Color(0xFF98A1B3), // สีเคอร์เซอร์
                ),
              ),

              const SizedBox(height: 56),

              // ปุ่ม Log In
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: Login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF3532D7),
                    foregroundColor: Colors.white,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.white, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    textStyle: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text('Log In'),
                ),
              ),

              const SizedBox(height: 19),

              // ปุ่ม Back
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: Back,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF3532D7),
                    foregroundColor: Colors.white,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.white, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    textStyle: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text('Back'),
                ),
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  void Login() {}

  void Back() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MainScreen()),
    );
  }
}

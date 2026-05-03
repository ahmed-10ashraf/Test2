import 'package:flutter/material.dart';
import 'login_page.dart';

class UserRegisterPage extends StatefulWidget {
  const UserRegisterPage({super.key});

  @override
  State<UserRegisterPage> createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends State<UserRegisterPage> {
  bool _agreeToTerms = false;
  String? _selectedCity;
  final List<String> _cities = ['Cairo', 'Giza', 'Alexandria', 'Mansoura', 'Tanta', 'Suez'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black, size: 20),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Create Account',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A237E),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Join thousands of car buyers & sellers in Egypt',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: _buildSocialButton(
                    icon: 'assets/images/google_icon.png', // Assuming asset exists or use icon
                    label: 'Google',
                    isGoogle: true,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildSocialButton(
                    icon: 'assets/images/facebook_icon.png',
                    label: 'Facebook',
                    isGoogle: false,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(child: Divider(color: Colors.grey.shade300)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'or fill in details',
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                  ),
                ),
                Expanded(child: Divider(color: Colors.grey.shade300)),
              ],
            ),
            const SizedBox(height: 24),
            _buildInputField(label: 'Full Name', hint: 'Ahmed Mohamed', icon: Icons.person_outline),
            _buildInputField(label: 'Phone Number', hint: '+20 1X XXX XXXX', icon: Icons.phone_android_outlined),
            _buildInputField(label: 'Email', hint: 'email@example.com', icon: Icons.email_outlined),
            _buildInputField(label: 'Password', hint: 'Min. 8 characters', icon: Icons.lock_outline, isPassword: true),
            
            const Text(
              'City',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF1A237E)),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: const Text('Select your city'),
                  value: _selectedCity,
                  items: _cities.map((city) {
                    return DropdownMenuItem(value: city, child: Text(city));
                  }).toList(),
                  onChanged: (val) => setState(() => _selectedCity = val),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: _agreeToTerms,
                  onChanged: (val) => setState(() => _agreeToTerms = val ?? false),
                  activeColor: const Color(0xFF2979FF),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                ),
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      text: 'I agree to the ',
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                      children: const [
                        TextSpan(
                          text: 'Terms of Service',
                          style: TextStyle(color: Color(0xFF2979FF), fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: ' and '),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: TextStyle(color: Color(0xFF2979FF), fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2979FF),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                  elevation: 0,
                ),
                child: const Text(
                  'Create Account',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an account? ', style: TextStyle(color: Colors.grey.shade600)),
                GestureDetector(
                  onTap: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false,
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Color(0xFF2979FF), fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton({required String icon, required String label, required bool isGoogle}) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(isGoogle ? Icons.g_mobiledata : Icons.facebook, color: isGoogle ? Colors.red : Colors.blue),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({required String label, required String hint, required IconData icon, bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF1A237E)),
        ),
        const SizedBox(height: 8),
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: TextField(
            obscureText: isPassword,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
              prefixIcon: Icon(icon, color: const Color(0xFF1A237E).withOpacity(0.7)),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 15),
            ),
          ),
        ),
      ],
    );
  }
}

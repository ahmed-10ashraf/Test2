import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _agreeToTerms = false;
  String? _selectedCity;

  @override
  Widget build(BuildContext context) {
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isDark ? Colors.white : Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isAr ? 'إنشاء حساب' : 'Create Account',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isAr ? 'انضم لآلاف البائعين والمشترين في مصر' : 'Join thousands of car buyers & sellers in Egypt',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),

            // Social Login Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.g_mobiledata, color: isDark ? Colors.white : Colors.black, size: 30),
                    label: Text(
                      isAr ? 'جوجل' : 'Google',
                      style: TextStyle(color: isDark ? Colors.white : Colors.black),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: BorderSide(color: isDark ? Colors.grey.shade800 : Colors.grey.shade200),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.facebook, color: Colors.blue),
                    label: Text(
                      isAr ? 'فيسبوك' : 'Facebook',
                      style: TextStyle(color: isDark ? Colors.white : Colors.black),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: BorderSide(color: isDark ? Colors.grey.shade800 : Colors.grey.shade200),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(child: Divider(color: isDark ? Colors.grey.shade800 : Colors.grey.shade200)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    isAr ? 'أو أدخل التفاصيل' : 'or fill in details',
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),
                Expanded(child: Divider(color: isDark ? Colors.grey.shade800 : Colors.grey.shade200)),
              ],
            ),
            const SizedBox(height: 24),

            // Full Name
            _buildLabel(isAr ? 'الاسم بالكامل' : 'Full Name', isDark),
            _buildTextField(
                hint: isAr ? 'أحمد محمد' : 'Ahmed Mohamed',
                icon: Icons.person_outline,
                isDark: isDark),
            
            const SizedBox(height: 16),
            
            // Phone Number
            _buildLabel(isAr ? 'رقم الهاتف' : 'Phone Number', isDark),
            _buildTextField(
                hint: '+20 1X XXX XXXX',
                icon: Icons.phone_android_outlined,
                isDark: isDark),

            const SizedBox(height: 16),

            // Email
            _buildLabel(isAr ? 'البريد الإلكتروني' : 'Email', isDark),
            _buildTextField(
                hint: 'email@example.com',
                icon: Icons.email_outlined,
                isDark: isDark),

            const SizedBox(height: 16),

            // Password
            _buildLabel(isAr ? 'كلمة المرور' : 'Password', isDark),
            _buildTextField(
                hint: isAr ? '8 أحرف على الأقل' : 'Min. 8 characters',
                icon: Icons.lock_outline,
                isPassword: true,
                isDark: isDark),

            const SizedBox(height: 16),

            // City
            _buildLabel(isAr ? 'المدينة' : 'City', isDark),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E1E1E) : Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedCity,
                  dropdownColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                  hint: Text(
                    isAr ? 'اختر مدينتك' : 'Select your city',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  isExpanded: true,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: (isAr 
                      ? ['القاهرة', 'الإسكندرية', 'الجيزة', 'شبرا الخيمة']
                      : ['Cairo', 'Alexandria', 'Giza', 'Shubra el-Kheima'])
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(color: isDark ? Colors.white : Colors.black),
                      ),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedCity = newValue;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Terms Checkbox
            Row(
              children: [
                Checkbox(
                  value: _agreeToTerms,
                  onChanged: (value) {
                    setState(() {
                      _agreeToTerms = value ?? false;
                    });
                  },
                  activeColor: Colors.blue,
                  side: BorderSide(color: isDark ? Colors.grey.shade700 : Colors.grey.shade400),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: isAr ? 'أوافق على ' : 'I agree to the ',
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                      children: [
                        TextSpan(
                          text: isAr ? 'شروط الخدمة' : 'Terms of Service',
                          style: TextStyle(color: Colors.blue.shade700, fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: isAr ? ' و ' : ' and '),
                        TextSpan(
                          text: isAr ? 'سياسة الخصوصية' : 'Privacy Policy',
                          style: TextStyle(color: Colors.blue.shade700, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Create Account Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate back to login page on "Create Account"
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A73E8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
                child: Text(
                  isAr ? 'إنشاء حساب' : 'Create Account',
                  style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Bottom Login Link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isAr ? 'لديك حساب بالفعل؟ ' : 'Already have an account? ',
                  style: const TextStyle(color: Colors.grey),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context); // Goes back to Login
                  },
                  child: Text(
                    isAr ? 'تسجيل دخول' : 'Login',
                    style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String label, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: isDark ? Colors.white70 : Colors.black87,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String hint,
    required IconData icon,
    bool isPassword = false,
    required bool isDark,
  }) {
    return TextField(
      obscureText: isPassword,
      style: TextStyle(color: isDark ? Colors.white : Colors.black),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        prefixIcon: Icon(icon, color: const Color(0xFF1A73E8).withValues(alpha: 0.4), size: 20),
        filled: true,
        fillColor: isDark ? const Color(0xFF1E1E1E) : Colors.grey.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

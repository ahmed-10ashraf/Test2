import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'login_page.dart';

class TowingRegisterPage extends StatefulWidget {
  const TowingRegisterPage({super.key});

  @override
  State<TowingRegisterPage> createState() => _TowingRegisterPageState();
}

class _TowingRegisterPageState extends State<TowingRegisterPage> {
  final Color primaryBlue = const Color(0xFF1E88E5);
  final Color darkBlue = const Color(0xFF0D47A1);
  final Color background = const Color(0xFFF8FAFF);
  
  int _currentStep = 1;
  File? _logoImage;

  // Controllers Step 1
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _businessNameController = TextEditingController();
  final _commercialRegController = TextEditingController();
  final _websiteController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();

  // Step 2 Data
  final Map<String, bool> _towingTypes = {
    'Flatbed Towing': false,
    'Wheel Lift Towing': false,
    'Heavy Duty Towing': false,
    'Roadside Assistance': false,
    'Fuel Delivery': false,
    'Battery Jumpstart': false,
  };

  final Map<String, bool> _coverageAreas = {
    'Cairo': false,
    'Giza': false,
    'Alexandria': false,
    'North Coast': false,
    'Suez Road': false,
    'Sokhna': false,
  };

  String? _workingHours;

  Future<void> _pickImage(bool isLogo) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        if (isLogo) {
          _logoImage = File(image.path);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Register Towing Service',
          style: TextStyle(color: darkBlue, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: darkBlue, size: 24),
          onPressed: () {
            if (_currentStep > 1) {
              setState(() => _currentStep--);
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: Column(
        children: [
          _buildProgressBar(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              child: _currentStep == 1 ? _buildStep1() : _buildStep2(),
            ),
          ),
          _buildBottomButton(),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Step $_currentStep of 2', style: TextStyle(color: Colors.grey.shade800, fontSize: 16, fontWeight: FontWeight.bold)),
              Text(_currentStep == 1 ? '50%' : '100%', style: TextStyle(color: primaryBlue, fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: _currentStep / 2,
              backgroundColor: Colors.grey.shade100,
              valueColor: AlwaysStoppedAnimation<Color>(primaryBlue),
              minHeight: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Stack(
            children: [
              Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: primaryBlue.withValues(alpha: 0.2), width: 5),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 12, offset: const Offset(0, 6)),
                  ],
                ),
                child: ClipOval(
                  child: _logoImage != null 
                    ? Image.file(_logoImage!, fit: BoxFit.cover)
                    : Icon(Icons.local_shipping_outlined, size: 70, color: primaryBlue.withValues(alpha: 0.5)),
                ),
              ),
              Positioned(
                bottom: 5,
                right: 5,
                child: GestureDetector(
                  onTap: () => _pickImage(true),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: primaryBlue, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 3)),
                    child: const Icon(Icons.camera_alt, color: Colors.white, size: 24),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 45),
        _buildSectionHeader('1', 'Personal Information', Icons.person_outline),
        _buildInputField('Full Name', 'Enter your full name', _nameController, Icons.person_outline),
        _buildInputField('Email Address', 'Enter email address', _emailController, Icons.email_outlined),
        _buildInputField('Phone Number', '01xxxxxxxxx', _phoneController, Icons.phone_android_outlined),
        _buildInputField('Password', 'Enter password', _passwordController, Icons.lock_outline, isPassword: true),
        _buildInputField('Confirm Password', 'Re-enter password', _confirmPasswordController, Icons.lock_reset_outlined, isPassword: true),
        const SizedBox(height: 40),
        _buildSectionHeader('2', 'Business Details', Icons.business_outlined),
        _buildInputField('Business Name', 'e.g. Fast Towing Egypt', _businessNameController, Icons.business_center_outlined),
        _buildInputField('CR Number', 'Commercial Register Number', _commercialRegController, Icons.assignment_outlined),
        _buildInputField('Website', 'www.example.com (Optional)', _websiteController, Icons.language_outlined),
        const SizedBox(height: 10),
        _buildInputField('About Services', 'Brief description of your towing services...', _descriptionController, Icons.description_outlined, maxLines: 3),
      ],
    );
  }

  Widget _buildStep2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('3', 'Service Details', Icons.settings_suggest_outlined),
        const SizedBox(height: 25),
        _buildLabel('Towing & Assistance Types'),
        const SizedBox(height: 20),
        _buildCheckboxGrid(_towingTypes),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 25),
          child: Divider(thickness: 1.5),
        ),
        _buildLabel('Coverage Areas'),
        const SizedBox(height: 20),
        _buildCheckboxGrid(_coverageAreas),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 25),
          child: Divider(thickness: 1.5),
        ),
        _buildLabel('Base Location / Office'),
        const SizedBox(height: 15),
        InkWell(
          onTap: () {
            // Logic to open map picker
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey.shade300, width: 2),
            ),
            child: Row(
              children: [
                Icon(Icons.location_on, color: primaryBlue, size: 28),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Select Office Location', style: TextStyle(fontSize: 18, color: Colors.grey.shade800, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text('Tap to pin your base on the map', style: TextStyle(fontSize: 14, color: Colors.grey.shade500)),
                    ],
                  ),
                ),
                Icon(Icons.map_outlined, color: primaryBlue, size: 24),
              ],
            ),
          ),
        ),
        const SizedBox(height: 15),
        _buildInputField('Address Details', 'Building, Street, Area...', _locationController, Icons.map_outlined),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 25),
          child: Divider(thickness: 1.5),
        ),
        _buildLabel('Operation Hours'),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey.shade300, width: 2),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              hint: const Text('Choose working hours', style: TextStyle(fontSize: 18)),
              value: _workingHours,
              icon: Icon(Icons.keyboard_arrow_down, color: primaryBlue, size: 30),
              items: ['24 Hours', '08:00 AM - 12:00 AM', '09:00 AM - 05:00 PM'].map((String value) {
                return DropdownMenuItem<String>(value: value, child: Text(value, style: const TextStyle(fontSize: 18)));
              }).toList(),
              onChanged: (val) => setState(() => _workingHours = val),
            ),
          ),
        ),
        const SizedBox(height: 50),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Text(text, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: darkBlue));
  }

  Widget _buildSectionHeader(String step, String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: primaryBlue.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: primaryBlue, size: 32),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: darkBlue),
            ),
          ),
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: primaryBlue, shape: BoxShape.circle),
            child: Text(step, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(String label, String hint, TextEditingController controller, IconData icon, {bool isPassword = false, int maxLines = 1}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade300, width: 2),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        maxLines: maxLines,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: primaryBlue, fontSize: 16, fontWeight: FontWeight.bold),
          hintText: hint,
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Icon(icon, color: primaryBlue, size: 28),
          ),
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 16),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          border: InputBorder.none,
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      ),
    );
  }

  Widget _buildCheckboxGrid(Map<String, bool> data) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: data.keys.map((key) {
        final isSelected = data[key]!;
        return InkWell(
          onTap: () => setState(() => data[key] = !isSelected),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            decoration: BoxDecoration(
              color: isSelected ? primaryBlue : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: isSelected ? primaryBlue : Colors.grey.shade300, width: 2),
              boxShadow: isSelected ? [BoxShadow(color: primaryBlue.withValues(alpha: 0.3), blurRadius: 10, offset: const Offset(0, 5))] : [],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(isSelected ? Icons.check_circle : Icons.add_circle_outline, size: 22, color: isSelected ? Colors.white : Colors.grey),
                const SizedBox(width: 12),
                Text(
                  key, 
                  style: TextStyle(
                    fontSize: 17, 
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500, 
                    color: isSelected ? Colors.white : Colors.grey.shade800
                  )
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildBottomButton() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, -5))],
      ),
      child: SizedBox(
        width: double.infinity,
        height: 65,
        child: ElevatedButton(
          onPressed: () {
            if (_currentStep == 1) {
              setState(() => _currentStep = 2);
            } else {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginPage()), (route) => false);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryBlue,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 0,
          ),
          child: Text(
            _currentStep == 1 ? 'Next Step' : 'Create Account',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'login_page.dart';
import '../home_page/home_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // --- Modern Blue & White Theme Constants ---
  final Color primaryBlue = const Color(0xFF1E88E5);
  final Color darkBlue = const Color(0xFF0D47A1);
  final Color lightBlue = const Color(0xFF42A5F5);
  final Color background = const Color(0xFFF8FAFF);
  final Color cardWhite = Colors.white;
  final Color textMain = const Color(0xFF263238);
  final Color textSecondary = const Color(0xFF78909C);

  // Form State
  final _formKey = GlobalKey<FormState>();
  
  // Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _commercialRegisterController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _otherBrandController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();

  // Showroom Specialized Data
  final List<String> _brandsList = ['Toyota', 'Hyundai', 'Kia', 'Nissan', 'Mercedes', 'BMW', 'Audi', 'Other'];
  final List<String> _daysList = ['Saturday', 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];
  final List<String> _selectedBrands = [];
  final List<String> _selectedDays = [];
  String _carType = 'both'; // 'new', 'used', 'both'
  File? _logoImage;

  Future<void> _pickLogo() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _logoImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 70,
        title: Text(
          'Register Car Showroom',
          style: TextStyle(
            color: darkBlue,
            fontWeight: FontWeight.w900,
            fontSize: 22,
            letterSpacing: -0.5,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: darkBlue, size: 22),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 10),
              _buildLogoPicker(),
              const SizedBox(height: 30),
              _buildSectionHeader('Basic Information', 1, Icons.person_rounded),
              _buildCustomField('Full Name', 'Enter your full name', null, _nameController),
              _buildCustomField('Email', 'example@mail.com', null, _emailController, keyboardType: TextInputType.emailAddress),
              _buildCustomField('Phone Number', '05xxxxxxxx', Icons.phone_android_rounded, _phoneController, keyboardType: TextInputType.phone),
              _buildCustomField('Password', '********', Icons.visibility_off_rounded, _passwordController, isPassword: true),
              _buildCustomField('Confirm Password', '********', Icons.lock_rounded, _confirmPasswordController, isPassword: true),

              const SizedBox(height: 20),
              _buildSectionHeader('Business Info', 2, Icons.business_center_rounded),
              _buildCustomField('Showroom Name', 'Legal entity name', null, _businessNameController),
              _buildCustomField('Commercial Reg', 'Commercial register number', null, _commercialRegisterController),
              _buildCustomField('Description', 'Brief about services', null, _descriptionController, maxLines: 3),
              _buildCustomField('Website', 'www.showroom.com', null, _websiteController, keyboardType: TextInputType.url),

              const SizedBox(height: 20),
              _buildSectionHeader('Showroom Details', 3, Icons.stars_rounded),
              _buildBrandSelection(),
              _buildCarTypeSelection(),
              _buildDaysSelection(),
              _buildWorkingHoursSection(),
              _buildCustomField('Address', 'City, District, Street', Icons.location_on_rounded, _addressController),

              const SizedBox(height: 45),
              _buildSubmitButton(),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, int step, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: primaryBlue,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: primaryBlue.withValues(alpha: 0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Text(
              '$step',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Icon(icon, color: lightBlue.withValues(alpha: 0.6), size: 26),
          const SizedBox(width: 15),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: primaryBlue,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomField(
    String label, 
    String hint, 
    IconData? leftIcon, 
    TextEditingController controller, 
    {bool isPassword = false, TextInputType keyboardType = TextInputType.text, int maxLines = 1}
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: cardWhite,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: primaryBlue.withValues(alpha: 0.1), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 15,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 120,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              alignment: Alignment.centerLeft,
              child: Text(
                label,
                style: TextStyle(
                  color: darkBlue.withValues(alpha: 0.9),
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            VerticalDivider(
              color: primaryBlue.withValues(alpha: 0.08),
              thickness: 1.5,
              width: 1,
              indent: 12,
              endIndent: 12,
            ),
            Expanded(
              child: TextFormField(
                controller: controller,
                obscureText: isPassword,
                keyboardType: keyboardType,
                textAlign: TextAlign.left,
                maxLines: maxLines,
                style: TextStyle(
                  fontSize: 16,
                  color: textMain,
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14, fontWeight: FontWeight.normal),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                  border: InputBorder.none,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Required field';
                  if (isPassword && label == 'Confirm Password' && value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  if (keyboardType == TextInputType.emailAddress && !value.contains('@')) {
                    return 'Invalid email';
                  }
                  return null;
                },
              ),
            ),
            if (leftIcon != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Icon(leftIcon, color: primaryBlue.withValues(alpha: 0.5), size: 22),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBrandSelection() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardWhite,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: primaryBlue.withValues(alpha: 0.1), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 20,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Available Brands',
            style: TextStyle(color: darkBlue, fontSize: 16, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 18),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: _brandsList.map((brand) {
                final isSelected = _selectedBrands.contains(brand);
                return InkWell(
                  onTap: () => setState(() => isSelected ? _selectedBrands.remove(brand) : _selectedBrands.add(brand)),
                  borderRadius: BorderRadius.circular(12),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryBlue : background,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? primaryBlue : primaryBlue.withValues(alpha: 0.1),
                        width: 1.2,
                      ),
                    ),
                    child: Text(
                      brand,
                      style: TextStyle(
                        color: isSelected ? Colors.white : darkBlue.withValues(alpha: 0.8),
                        fontSize: 14,
                        fontWeight: isSelected ? FontWeight.w900 : FontWeight.w600,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          if (_selectedBrands.contains('Other')) ...[
            const SizedBox(height: 20),
            _buildCustomFieldSmall('Other Brand', 'Enter brand name', _otherBrandController),
          ],
        ],
      ),
    );
  }

  Widget _buildCustomFieldSmall(String label, String hint, TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: primaryBlue.withValues(alpha: 0.1)),
      ),
      child: TextFormField(
        controller: controller,
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 15, color: textMain, fontWeight: FontWeight.w600),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
          border: InputBorder.none,
          prefixIcon: Icon(Icons.edit_note_rounded, color: primaryBlue.withValues(alpha: 0.5)),
        ),
      ),
    );
  }

  Widget _buildCarTypeSelection() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: cardWhite,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: primaryBlue.withValues(alpha: 0.1), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 20,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 120,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              alignment: Alignment.centerLeft,
              child: Text(
                'Car Condition',
                style: TextStyle(color: darkBlue, fontSize: 14, fontWeight: FontWeight.w800),
              ),
            ),
            VerticalDivider(color: primaryBlue.withValues(alpha: 0.08), thickness: 1.5, width: 1, indent: 12, endIndent: 12),
            Expanded(
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildRadioOption('New', 'new'),
                    _buildRadioOption('Used', 'used'),
                    _buildRadioOption('Both', 'both'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioOption(String label, String value) {
    bool isSelected = _carType == value;
    return InkWell(
      onTap: () => setState(() => _carType = value),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Radio<String>(
              value: value,
              groupValue: _carType,
              activeColor: primaryBlue,
              onChanged: (val) => setState(() => _carType = val!),
              visualDensity: VisualDensity.compact,
            ),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? primaryBlue : textSecondary,
                fontSize: 15,
                fontWeight: isSelected ? FontWeight.w900 : FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDaysSelection() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardWhite,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: primaryBlue.withValues(alpha: 0.1), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 20,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Working Days',
                style: TextStyle(color: darkBlue, fontSize: 16, fontWeight: FontWeight.w900),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    if (_selectedDays.length == _daysList.length) {
                      _selectedDays.clear();
                    } else {
                      _selectedDays.clear();
                      _selectedDays.addAll(_daysList);
                    }
                  });
                },
                child: Text(
                  _selectedDays.length == _daysList.length ? 'Clear All' : 'Select All',
                  style: TextStyle(color: primaryBlue, fontSize: 13, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Wrap(
              spacing: 8,
              runSpacing: 4,
              children: _daysList.map((day) {
                final isSelected = _selectedDays.contains(day);
                return FilterChip(
                  label: Text(day),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedDays.add(day);
                      } else {
                        _selectedDays.remove(day);
                      }
                    });
                  },
                  selectedColor: primaryBlue,
                  checkmarkColor: Colors.white,
                  backgroundColor: background,
                  showCheckmark: false,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : darkBlue.withValues(alpha: 0.7),
                    fontSize: 13,
                    fontWeight: isSelected ? FontWeight.w900 : FontWeight.w600,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: isSelected ? primaryBlue : primaryBlue.withValues(alpha: 0.1),
                      width: 1.2,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkingHoursSection() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardWhite,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: primaryBlue.withValues(alpha: 0.1), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 20,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Working Hours',
            style: TextStyle(color: darkBlue, fontSize: 16, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(child: _buildTimeInput('From', '09:00 AM', _startTimeController)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Icon(Icons.arrow_forward_rounded, color: primaryBlue.withValues(alpha: 0.3), size: 20),
              ),
              Expanded(child: _buildTimeInput('To', '09:00 PM', _endTimeController)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeInput(String label, String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5, bottom: 8),
          child: Text(label, style: TextStyle(color: darkBlue.withValues(alpha: 0.7), fontSize: 14, fontWeight: FontWeight.bold)),
        ),
        Container(
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: primaryBlue.withValues(alpha: 0.1)),
          ),
          child: TextFormField(
            controller: controller,
            textAlign: TextAlign.center,
            readOnly: true,
            style: TextStyle(fontSize: 16, color: textMain, fontWeight: FontWeight.w900),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 15),
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14, fontWeight: FontWeight.normal),
              border: InputBorder.none,
              prefixIcon: Icon(Icons.access_time_rounded, color: primaryBlue.withValues(alpha: 0.4), size: 20),
            ),
            onTap: () async {
              final TimeOfDay? picked = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (picked != null) {
                setState(() {
                  controller.text = picked.format(context);
                });
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLogoPicker() {
    return Center(
      child: Stack(
        children: [
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: primaryBlue.withValues(alpha: 0.2), width: 4),
              boxShadow: [
                BoxShadow(
                  color: primaryBlue.withValues(alpha: 0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                )
              ],
              image: _logoImage != null 
                ? DecorationImage(image: FileImage(_logoImage!), fit: BoxFit.cover)
                : null,
            ),
            child: _logoImage == null 
              ? Icon(Icons.add_business_rounded, size: 45, color: primaryBlue.withValues(alpha: 0.3))
              : null,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: _pickLogo,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: primaryBlue,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                ),
                child: const Icon(Icons.camera_alt_rounded, color: Colors.white, size: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Container(
      width: double.infinity,
      height: 65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [primaryBlue, darkBlue], 
          begin: Alignment.centerLeft, 
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: primaryBlue.withValues(alpha: 0.4),
            blurRadius: 25,
            offset: const Offset(0, 12),
          )
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            if (_logoImage == null) {
              _showError('Please upload showroom logo');
              return;
            }
            if (_selectedBrands.isEmpty) {
              _showError('Please select at least one brand');
              return;
            }
            if (_selectedDays.isEmpty) {
              _showError('Please select working days');
              return;
            }
            if (_startTimeController.text.isEmpty || _endTimeController.text.isEmpty) {
              _showError('Please set working hours (From & To)');
              return;
            }

            Navigator.pushAndRemoveUntil(
              context, 
              MaterialPageRoute(builder: (context) => const LoginPage()),
              (route) => false,
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent, 
          shadowColor: Colors.transparent, 
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        child: const Text(
          'Create Account Now',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, textAlign: TextAlign.left, style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}

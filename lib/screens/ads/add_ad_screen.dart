import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddAdScreen extends StatefulWidget {
  const AddAdScreen({super.key});

  @override
  State<AddAdScreen> createState() => _AddAdScreenState();
}

class _AddAdScreenState extends State<AddAdScreen> {
  final List<File> _images = [];
  final _formKey = GlobalKey<FormState>();
  
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  String? _selectedBrand;
  String? _selectedModel;
  String? _selectedYear;

  Future<void> _pickImages() async {
    final picker = ImagePicker();
    final List<XFile> pickedFiles = await picker.pickMultiImage();
    
    if (pickedFiles.isNotEmpty) {
      setState(() {
        _images.addAll(pickedFiles.map((file) => File(file.path)));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0B0F14) : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Add Car',
          style: TextStyle(
            color: isDark ? Colors.white : const Color(0xFF0D47A1),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: isDark ? Colors.white : const Color(0xFF0D47A1)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Car Details',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : const Color(0xFF0D47A1),
                ),
              ),
              const SizedBox(height: 20),
              _buildImagePicker(isDark),
              const SizedBox(height: 25),
              
              _buildModernDropdown(
                label: 'Brand',
                value: _selectedBrand,
                items: ['Toyota', 'Hyundai', 'BMW', 'Mercedes', 'Audi'],
                onChanged: (val) => setState(() => _selectedBrand = val),
                isDark: isDark,
              ),
              const SizedBox(height: 15),
              
              _buildModernDropdown(
                label: 'Model',
                value: _selectedModel,
                items: ['Camry', 'Elantra', 'X5', 'C-Class', 'A4'],
                onChanged: (val) => setState(() => _selectedModel = val),
                isDark: isDark,
              ),
              const SizedBox(height: 15),
              
              _buildModernDropdown(
                label: 'Year',
                value: _selectedYear,
                items: List.generate(30, (index) => (2025 - index).toString()),
                onChanged: (val) => setState(() => _selectedYear = val),
                isDark: isDark,
              ),
              const SizedBox(height: 15),
              
              _buildModernTextField(
                controller: _priceController,
                label: 'Price',
                hint: 'Enter price',
                keyboardType: TextInputType.number,
                isDark: isDark,
              ),
              const SizedBox(height: 15),
              
              _buildModernTextField(
                controller: _descriptionController,
                label: 'Description',
                hint: 'Enter car details',
                maxLines: 3,
                isDark: isDark,
              ),
              const SizedBox(height: 40),
              
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E88E5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePicker(bool isDark) {
    return GestureDetector(
      onTap: _pickImages,
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF121821) : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.blue.withValues(alpha: 0.2)),
        ),
        child: _images.isEmpty 
          ? const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.camera_alt_outlined, color: Color(0xFF1E88E5), size: 40),
                SizedBox(height: 8),
                Text(
                  'Add Photos',
                  style: TextStyle(color: Color(0xFF0D47A1), fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ],
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.file(_images.first, fit: BoxFit.cover),
            ),
      ),
    );
  }

  Widget _buildModernDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
    required bool isDark,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF121821) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 100,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            alignment: Alignment.centerLeft,
            child: Text(
              label,
              style: TextStyle(
                color: isDark ? Colors.white70 : const Color(0xFF0D47A1),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(height: 30, width: 1, color: Colors.blue.withValues(alpha: 0.1)),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                isExpanded: true,
                hint: Text('', style: TextStyle(color: Colors.grey.shade400)),
                dropdownColor: isDark ? const Color(0xFF1A1A1A) : Colors.white,
                items: items.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item, style: TextStyle(color: isDark ? Colors.white : Colors.black87, fontSize: 14)),
                  );
                }).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Icon(Icons.keyboard_arrow_down, color: Colors.blueGrey, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildModernTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required bool isDark,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF121821) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 100,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            alignment: Alignment.centerLeft,
            child: Text(
              label,
              style: TextStyle(
                color: isDark ? Colors.white70 : const Color(0xFF0D47A1),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(height: 30, width: 1, color: Colors.blue.withValues(alpha: 0.1)),
          Expanded(
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              maxLines: maxLines,
              textAlign: TextAlign.left,
              style: TextStyle(color: isDark ? Colors.white : Colors.black87, fontSize: 14),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 12),
                contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

}

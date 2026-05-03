import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:test2/main.dart';

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
    
    return ValueListenableBuilder<Locale>(
      valueListenable: localeNotifier,
      builder: (context, locale, _) {
        final isAr = locale.languageCode == 'ar';
        
        return Scaffold(
          backgroundColor: isDark ? const Color(0xFF0B0F14) : Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              isAr ? 'أضف سيارة' : 'Add Car',
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
                    isAr ? 'بيانات السيارة' : 'Car Details',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : const Color(0xFF0D47A1),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildImagePicker(isAr, isDark),
                  const SizedBox(height: 25),
                  
                  _buildModernDropdown(
                    label: isAr ? 'الماركة' : 'Brand',
                    value: _selectedBrand,
                    items: ['Toyota', 'Hyundai', 'BMW', 'Mercedes', 'Audi'],
                    onChanged: (val) => setState(() => _selectedBrand = val),
                    isDark: isDark,
                    isAr: isAr,
                  ),
                  const SizedBox(height: 15),
                  
                  _buildModernDropdown(
                    label: isAr ? 'الموديل' : 'Model',
                    value: _selectedModel,
                    items: ['Camry', 'Elantra', 'X5', 'C-Class', 'A4'],
                    onChanged: (val) => setState(() => _selectedModel = val),
                    isDark: isDark,
                    isAr: isAr,
                  ),
                  const SizedBox(height: 15),
                  
                  _buildModernDropdown(
                    label: isAr ? 'السنة' : 'Year',
                    value: _selectedYear,
                    items: List.generate(30, (index) => (2025 - index).toString()),
                    onChanged: (val) => setState(() => _selectedYear = val),
                    isDark: isDark,
                    isAr: isAr,
                  ),
                  const SizedBox(height: 15),
                  
                  _buildModernTextField(
                    controller: _priceController,
                    label: isAr ? 'السعر' : 'Price',
                    hint: isAr ? 'أدخل السعر' : 'Enter price',
                    keyboardType: TextInputType.number,
                    isDark: isDark,
                    isAr: isAr,
                  ),
                  const SizedBox(height: 15),
                  
                  _buildModernTextField(
                    controller: _descriptionController,
                    label: isAr ? 'الوصف' : 'Description',
                    hint: isAr ? 'أدخل تفاصيل السيارة' : 'Enter car details',
                    maxLines: 3,
                    isDark: isDark,
                    isAr: isAr,
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
                      child: Text(
                        isAr ? 'حفظ' : 'Save',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildImagePicker(bool isAr, bool isDark) {
    return GestureDetector(
      onTap: _pickImages,
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF121821) : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.blue.withOpacity(0.2)),
        ),
        child: _images.isEmpty 
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.camera_alt_outlined, color: const Color(0xFF1E88E5), size: 40),
                const SizedBox(height: 8),
                Text(
                  isAr ? 'إضافة صور' : 'Add Photos',
                  style: const TextStyle(color: Color(0xFF0D47A1), fontSize: 12, fontWeight: FontWeight.w500),
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
    required bool isAr,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF121821) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Icon(Icons.keyboard_arrow_down, color: Colors.blueGrey, size: 20),
          ),
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
          Container(height: 30, width: 1, color: Colors.blue.withOpacity(0.1)),
          Container(
            width: 100,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            alignment: isAr ? Alignment.centerRight : Alignment.centerLeft,
            child: Text(
              label,
              style: TextStyle(
                color: isDark ? Colors.white70 : const Color(0xFF0D47A1),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
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
    required bool isAr,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF121821) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              maxLines: maxLines,
              textAlign: isAr ? TextAlign.right : TextAlign.left,
              style: TextStyle(color: isDark ? Colors.white : Colors.black87, fontSize: 14),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 12),
                contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                border: InputBorder.none,
              ),
            ),
          ),
          Container(height: 30, width: 1, color: Colors.blue.withOpacity(0.1)),
          Container(
            width: 100,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            alignment: isAr ? Alignment.centerRight : Alignment.centerLeft,
            child: Text(
              label,
              style: TextStyle(
                color: isDark ? Colors.white70 : const Color(0xFF0D47A1),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

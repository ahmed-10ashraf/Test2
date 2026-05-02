import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  RangeValues _priceRange = const RangeValues(200000, 1200000);
  RangeValues _mileageRange = const RangeValues(0, 50000);
  
  String selectedCondition = 'All';
  String selectedTransmission = 'Any';
  String selectedBodyType = 'All';
  String selectedFuelType = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 5,
                )
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black, size: 20),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: const Text(
          'Search Cars',
          style: TextStyle(
            color: Color(0xFF1D2733),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _priceRange = const RangeValues(200000, 1200000);
                _mileageRange = const RangeValues(0, 50000);
                selectedCondition = 'All';
                selectedTransmission = 'Any';
                selectedBodyType = 'All';
                selectedFuelType = 'All';
              });
            },
            child: const Text(
              'Reset',
              style: TextStyle(
                color: Color(0xFF1A73E8),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search Bar
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: 55,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F4F9),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: Color(0xFF1A73E8)),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Brand, model, keyword...',
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.black, size: 20),
                        onPressed: () {},
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),

                _buildSectionTitle('Condition'),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildChoiceChip('All', 'condition'),
                    const SizedBox(width: 10),
                    _buildChoiceChip('New', 'condition'),
                    const SizedBox(width: 10),
                    _buildChoiceChip('Used', 'condition'),
                  ],
                ),
                const SizedBox(height: 25),

                Row(
                  children: [
                    Expanded(child: _buildDropdown('Brand', 'Any Brand')),
                    const SizedBox(width: 15),
                    Expanded(child: _buildDropdown('Model', 'Any Model')),
                  ],
                ),
                const SizedBox(height: 25),

                _buildSectionTitle('Price Range (EGP)'),
                const SizedBox(height: 10),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: const Color(0xFF1A73E8),
                    inactiveTrackColor: Colors.grey.shade200,
                    thumbColor: Colors.white,
                    trackHeight: 4.0,
                    rangeThumbShape: const RoundRangeSliderThumbShape(enabledThumbRadius: 10, elevation: 5),
                  ),
                  child: RangeSlider(
                    values: _priceRange,
                    min: 100000,
                    max: 2000000,
                    onChanged: (values) {
                      setState(() => _priceRange = values);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('100K', style: TextStyle(color: Colors.grey, fontSize: 12)),
                      Text('500K', style: TextStyle(color: Colors.grey, fontSize: 12)),
                      Text('2M+', style: TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildValueBubble('EGP ${_priceRange.start.toInt() ~/ 1000}K'),
                    _buildValueBubble('EGP ${(_priceRange.end / 1000000).toStringAsFixed(1)}M'),
                  ],
                ),
                const SizedBox(height: 25),

                Row(
                  children: [
                    Expanded(child: _buildDropdown('City', 'Any City')),
                    const SizedBox(width: 15),
                    Expanded(child: _buildDropdown('Area', 'Any Area')),
                  ],
                ),
                const SizedBox(height: 25),

                Row(
                  children: [
                    Expanded(child: _buildDropdown('Year From', '2015')),
                    const SizedBox(width: 15),
                    Expanded(child: _buildDropdown('Year To', '2025')),
                  ],
                ),
                const SizedBox(height: 25),

                _buildSectionTitle('Mileage Range (KM)'),
                const SizedBox(height: 10),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: const Color(0xFF1A73E8),
                    inactiveTrackColor: Colors.grey.shade200,
                    thumbColor: Colors.white,
                    trackHeight: 4.0,
                  ),
                  child: RangeSlider(
                    values: _mileageRange,
                    min: 0,
                    max: 200000,
                    onChanged: (values) {
                      setState(() => _mileageRange = values);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('0', style: TextStyle(color: Colors.grey, fontSize: 12)),
                      Text('50K', style: TextStyle(color: Colors.grey, fontSize: 12)),
                      Text('200K+', style: TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                ),
                const SizedBox(height: 25),

                _buildSectionTitle('Transmission'),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildChoiceChip('Any', 'transmission'),
                    const SizedBox(width: 10),
                    _buildChoiceChip('Automatic', 'transmission'),
                    const SizedBox(width: 10),
                    _buildChoiceChip('Manual', 'transmission'),
                  ],
                ),
                const SizedBox(height: 25),

                _buildSectionTitle('Body Type'),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _buildChoiceChip('All', 'body'),
                    _buildChoiceChip('Sedan', 'body'),
                    _buildChoiceChip('SUV', 'body'),
                    _buildChoiceChip('Hatchback', 'body'),
                    _buildChoiceChip('Coupe', 'body'),
                    _buildChoiceChip('Truck', 'body'),
                  ],
                ),
                const SizedBox(height: 25),

                _buildSectionTitle('Fuel Type'),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _buildChoiceChip('All', 'fuel'),
                    _buildChoiceChip('Petrol', 'fuel'),
                    _buildChoiceChip('Diesel', 'fuel'),
                    _buildChoiceChip('Electric', 'fuel'),
                    _buildChoiceChip('Hybrid', 'fuel'),
                  ],
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFFF8FAFF).withValues(alpha: 0),
                    const Color(0xFFF8FAFF),
                    const Color(0xFFF8FAFF),
                  ],
                ),
              ),
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A73E8),
                  minimumSize: const Size(double.infinity, 65),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                  elevation: 8,
                  shadowColor: const Color(0xFF1A73E8).withValues(alpha: 0.5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.search, color: Colors.white, size: 24),
                    SizedBox(width: 12),
                    Text(
                      'Show 248 Results',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Color(0xFF455A64),
      ),
    );
  }

  Widget _buildChoiceChip(String label, String group) {
    bool isSelected = false;
    if (group == 'condition') isSelected = selectedCondition == label;
    if (group == 'transmission') isSelected = selectedTransmission == label;
    if (group == 'body') isSelected = selectedBodyType == label;
    if (group == 'fuel') isSelected = selectedFuelType == label;

    return GestureDetector(
      onTap: () {
        setState(() {
          if (group == 'condition') selectedCondition = label;
          if (group == 'transmission') selectedTransmission = label;
          if (group == 'body') selectedBodyType = label;
          if (group == 'fuel') selectedFuelType = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1A73E8) : Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected ? const Color(0xFF1A73E8) : Colors.grey.shade200,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF1A73E8).withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey.shade700,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(label),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: 55,
          decoration: BoxDecoration(
            color: const Color(0xFFF1F4F9),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
              ),
              const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildValueBubble(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF1A73E8),
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
      ),
    );
  }
}

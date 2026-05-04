import 'package:flutter/material.dart';
import 'maintenance_register_page.dart';
import 'register_page.dart';
import 'towing_register_page.dart';
import 'parts_register_page.dart';

class BusinessSelectionPage extends StatefulWidget {
  const BusinessSelectionPage({super.key});

  @override
  State<BusinessSelectionPage> createState() => _BusinessSelectionPageState();
}

class _BusinessSelectionPageState extends State<BusinessSelectionPage> {
  String? _selectedActivity;

  final List<Map<String, dynamic>> _activities = [
    {
      'id': 'showroom',
      'title': 'Car Showroom',
      'icon': Icons.garage_outlined,
      'color': const Color(0xFF1E88E5),
    },
    {
      'id': 'towing',
      'title': 'Towing',
      'icon': Icons.upload_file_outlined, // Placeholder for towing icon
      'color': const Color(0xFF1E88E5),
    },
    {
      'id': 'parts',
      'title': 'Spare Parts',
      'icon': Icons.settings_outlined,
      'color': Colors.orange,
    },
    {
      'id': 'maintenance',
      'title': 'Maintenance',
      'icon': Icons.build_outlined,
      'color': Colors.orange,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E88E5),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Select Business Type',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 0.9,
                ),
                itemCount: _activities.length,
                itemBuilder: (context, index) {
                  final activity = _activities[index];
                  final isSelected = _selectedActivity == activity['id'];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedActivity = activity['id'];
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: isSelected ? activity['color'] : Colors.grey.withOpacity(0.1),
                          width: isSelected ? 2 : 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            activity['icon'],
                            size: 60,
                            color: activity['color'],
                          ),
                          const SizedBox(height: 15),
                          Text(
                            activity['title'],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? activity['color'] : Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: _selectedActivity == null
                    ? null
                    : () {
                        if (_selectedActivity == 'showroom') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const RegisterPage()),
                          );
                        } else if (_selectedActivity == 'maintenance') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const MaintenanceRegisterPage()),
                          );
                        } else if (_selectedActivity == 'towing') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const TowingRegisterPage()),
                          );
                        } else if (_selectedActivity == 'parts') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const PartsRegisterPage()),
                          );
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF64B5F6),
                  disabledBackgroundColor: Colors.grey.shade300,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

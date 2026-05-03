import 'package:flutter/material.dart';
import 'account_selection_page.dart';
import '../home_page/home_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Section with Gradient and Logo
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 60),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    'CAR LINK',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                  const Text(
                    'Your Smart Connection to Every Car Need',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Placeholder for Car Image
                  Container(
                    height: 100,
                    width: 150,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage('https://cdn-icons-png.flaticon.com/512/744/744465.png'), // Placeholder car icon
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const Text(
                    'Sign in to continue',
                    style: TextStyle(
                      fontSize: 16,
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
                          icon: Icon(Icons.g_mobiledata, color: isDark ? Colors.white : Colors.black),
                          label: Text(
                            'Google',
                            style: TextStyle(color: isDark ? Colors.white : Colors.black),
                          ),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            side: BorderSide(color: isDark ? Colors.grey.shade800 : Colors.grey.shade300),
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
                            'Facebook',
                            style: TextStyle(color: isDark ? Colors.white : Colors.black),
                          ),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            side: BorderSide(color: isDark ? Colors.grey.shade800 : Colors.grey.shade300),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(child: Divider(color: isDark ? Colors.grey.shade800 : Colors.grey.shade300)),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'or continue with email',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ),
                      Expanded(child: Divider(color: isDark ? Colors.grey.shade800 : Colors.grey.shade300)),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Email Field
                  Text(
                    'Email or Phone',
                    style: TextStyle(fontWeight: FontWeight.w500, color: isDark ? Colors.white : Colors.black87),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    style: TextStyle(color: isDark ? Colors.white : Colors.black),
                    decoration: InputDecoration(
                      hintText: 'you@example.com',
                      hintStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: const Icon(Icons.email_outlined),
                      filled: true,
                      fillColor: isDark ? const Color(0xFF1E1E1E) : Colors.grey.shade50,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Password Field
                  Text(
                    'Password',
                    style: TextStyle(fontWeight: FontWeight.w500, color: isDark ? Colors.white : Colors.black87),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    obscureText: true,
                    style: TextStyle(color: isDark ? Colors.white : Colors.black),
                    decoration: InputDecoration(
                      hintText: '********',
                      hintStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: const Icon(Icons.lock_outline),
                      filled: true,
                      fillColor: isDark ? const Color(0xFF1E1E1E) : Colors.grey.shade50,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  Align(
                    alignment: isAr ? Alignment.centerLeft : Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Sign In Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const HomePage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                      ),
                      child: const Text(
                        'Sign In',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Bottom Links
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'No account? ',
                        style: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const AccountSelectionPage()),
                          );
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const HomePage()),
                        );
                      },
                      child: const Text(
                        'Browse as Guest →',
                        style: TextStyle(color: Color(0xFF1E88E5)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import '/views/home.dart';
// import 'package:email_validator/email_validator.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   String? _errorMessage;

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   void _login() {
//     String email = _emailController.text.trim();
//     String password = _passwordController.text.trim();

//     // Basic validation
//     if (email.isEmpty || password.isEmpty) {
//       setState(() {
//         _errorMessage = "Please fill in all fields.";
//       });
//       return;
//     }

//     if (!EmailValidator.validate(email)) {
//       setState(() {
//         _errorMessage = "Please enter a valid email address.";
//       });
//       return;
//     }

//     if (password.length < 6) {
//       setState(() {
//         _errorMessage = "Password must be at least 6 characters long.";
//       });
//       return;
//     }

//     // If validation passes, proceed with login logic (mocked here)
//     setState(() {
//       _errorMessage = null; // Clear any previous error messages
//     });

//     // Mock login logic (replace with actual authentication logic)
//     Navigator.push(
//         context, MaterialPageRoute(builder: (context) => const HomeScreen()));

//     // Navigate to the next page or perform further actions
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text(
//                 'Login',
//                 style: TextStyle(
//                     fontSize: 32,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                     fontFamily: 'IntegralCF'),
//               ),
//               const SizedBox(height: 40),
//               TextField(
//                 controller: _emailController,
//                 decoration: InputDecoration(
//                   labelText: 'Email',
//                   labelStyle: const TextStyle(color: Colors.grey),
//                   filled: true,
//                   fillColor: Colors.white24,
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8)),
//                 ),
//                 style: const TextStyle(color: Colors.white),
//               ),
//               const SizedBox(height: 20),
//               TextField(
//                 controller: _passwordController,
//                 obscureText: true,
//                 decoration: InputDecoration(
//                   labelText: 'Password',
//                   labelStyle: const TextStyle(color: Colors.grey),
//                   filled: true,
//                   fillColor: Colors.white24,
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8)),
//                 ),
//                 style: const TextStyle(color: Colors.white),
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _login,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.green, // Spotify-like button color
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30)),
//                 ),
//                 child: const Text('Log In',
//                     style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.white,
//                         fontFamily: 'IntegralCF')),
//               ),
//               const SizedBox(height: 20),
//               if (_errorMessage != null)
//                 Text(
//                   _errorMessage!,
//                   style: const TextStyle(color: Colors.red),
//                 ),
//               const SizedBox(height: 20),
//               GestureDetector(
//                 onTap: () {
//                   // Navigate to signup page
//                 },
//                 child: const Text(
//                   'Don\'t have an account? Sign up',
//                   style: TextStyle(color: Colors.grey),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

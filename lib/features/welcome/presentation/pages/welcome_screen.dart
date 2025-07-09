import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clean_architecture_poktani/core/services/token_service.dart';
import 'package:logger/logger.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _isLoading = true;
  final TokenService _tokenService = TokenService();
  final Logger _logger = Logger();

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    _logger.i('Checking authentication status...');

    try {
      final isLoggedIn = await _tokenService.isLoggedIn();

      if (isLoggedIn) {
        _logger.i('Token found, navigating to main screen');
        if (mounted) {
          Navigator.of(context).pushReplacementNamed('/main');
        }
      } else {
        _logger.i('No token found, staying on welcome screen');
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      _logger.e('Error checking auth: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFF2D6A4F)),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/background.png', fit: BoxFit.cover),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Poktani App',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Mulailah dengan mengelola lahan pertanian dan memantau perkembangannya untuk hasil optimal.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 50),
                  // Tombol Daftar
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2D6A4F),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text(
                        'Daftar',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Tombol Masuk
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text(
                        'Masuk',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

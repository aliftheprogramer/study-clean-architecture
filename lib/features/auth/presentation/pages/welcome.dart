import 'package:clean_architecture_poktani/features/auth/presentation/pages/login.dart';
import 'package:clean_architecture_poktani/features/auth/presentation/pages/register.dart';
import 'package:flutter/material.dart';
import 'package:logger/web.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        _buildBackgroundImage(),
        _buildGradientOverlay(),
        _buildContent(context),
      ],
    );
  }

  Widget _buildBackgroundImage() {
    return Image.asset(
      'assets/farm_illustration_new.png', // Ganti dengan path gambar Anda
      fit: BoxFit.cover,
    );
  }

  Widget _buildGradientOverlay() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            Colors.green.shade800.withOpacity(0.8),
            Colors.green.shade900,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.2, 0.6, 1.0],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Poktani App',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Mulailah dengan mengelola lahan pertanian dan memantau perkembangannya untuk hasil optimal.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 48),

            _buildRegisterButton(context),

            const SizedBox(height: 16),

            _buildLoginButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildRegisterButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Logger().d('Register button pressed');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RegisterPage()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green.shade600,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: const Text(
        'Daftar',
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        Logger().d('Login button pressed');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPages()),
        );
      },
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.white, width: 2),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: const Text(
        'Masuk',
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}

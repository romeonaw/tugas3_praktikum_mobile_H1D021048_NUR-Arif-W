import 'package:flutter/material.dart';
import 'package:tugas3_praktikum_mobile/sidemenu.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Page'),
      ),
      body: const Center(
        child: Text('Ini adalah halaman Settings'),
      ),
      drawer: const Sidemenu(),
    ); 

  }
  
}


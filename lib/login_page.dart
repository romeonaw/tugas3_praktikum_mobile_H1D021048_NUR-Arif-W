import 'package:flutter/material.dart';
import 'package:tugas3_praktikum_mobile/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Tambahkan variabel ini untuk menyimpan status password
  bool _isVisible = false;

  // Tambahkan fungsi ini untuk mengubah status password
  void _toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  var nameuser;

  void _SaveUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Simpan Username ke local storage
    prefs.setString('username', _usernameController.text);
  }

  _showInput(namacontroller, placeholder, isPassword) {
    return TextField(
      controller: namacontroller,
      obscureText: isPassword && !_isVisible,
      decoration: InputDecoration(
        hintText: placeholder,
        prefixIcon: isPassword
            ? Icon(
                Icons.lock,
                color: Colors.white,
              )
            : Icon(
                Icons.email,
                color: Colors.white,
              ),
              suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  _isVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Colors.white,
                ),
                onPressed: _toggleVisibility,
              )
            : null, //null berarti tidak ada icon mata di form username
        
      ),
      style: TextStyle(color: Colors.white),
    );
  }

  void _showForgotPasswordDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Forgot Password'),
            content: TextField(
              decoration: InputDecoration(
                hintText: 'Enter your email address',
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  //TODO : https://www.google.com/intl/id/gmail/about/
                  Navigator.pop(context);
                },
                child: Text('Send Reset Link'),
              ),
            ],
          );
        });
  }

  _showDialog(pesan, alamat) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(pesan),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => alamat,
                    ),
                  );
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Login'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.yellow,
              Colors.blue,
            ],
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           
             // Tambahkan widget Text untuk menampilkan teks "Login App"
            Text(
              'Login App',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 40,),
            // Tambahkan widget Container untuk membuat box untuk form username
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child:
                    _showInput(_usernameController, 'Masukkan Username', false),
              ),
            ),
            SizedBox(height: 20),
            // Tambahkan widget Container untuk membuat box untuk form password
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child:
                    _showInput(_passwordController, 'Masukkan Password', true),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Login'),
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.white)),
              onPressed: () {
                if (_usernameController.text == 'romeo' &&
                    _passwordController.text == 'romeo') {
                  //Save Username
                  _SaveUsername();
                  //show alert
                  _showDialog('Anda Berhasil Login', const HomePage());
                } else {
                  //Show alert
                  _showDialog('Username dan Password Salah', const LoginPage());
                }
              },
            ),
            TextButton(
              onPressed: () {
                // TODO: https://www.google.com/intl/id/gmail/about/
              },
              child: Text(
                'Forgot Password?',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

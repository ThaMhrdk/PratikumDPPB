import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    // Selalu dispose controller saat widget tidak digunakan
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Halaman Login"),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          // Memberi jarak dari tepi layar
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Menambah spasi dari atas
              const SizedBox(height: 40),

              // Ikon agar terlihat menarik
              Icon(Icons.lock_outline, size: 80, color: Colors.blue),

              const SizedBox(height: 40),

              // Field Username
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: "Username",
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(), // Memberi border
                ),
              ),

              const SizedBox(height: 20),

              // Field Password
              TextField(
                controller: _passwordController,
                obscureText: true, // Untuk menyembunyikan teks password
                decoration: const InputDecoration(
                  labelText: "Password",
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 40),

              // Tombol Login
              ElevatedButton(
                onPressed: () {
                  // Aksi saat tombol login ditekan
                  String username = _usernameController.text;
                  String password = _passwordController.text;
                  print('Username: $username');
                  print('Password: $password');

                  // Anda bisa tambahkan logika validasi di sini
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Warna tombol
                  foregroundColor: Colors.white, // Warna teks tombol
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

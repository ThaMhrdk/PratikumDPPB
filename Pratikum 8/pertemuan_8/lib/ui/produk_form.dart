import 'package:flutter/material.dart';

class ProdukForm extends StatefulWidget {
  const ProdukForm({Key? key}) : super(key: key);
  @override
  _ProdukFormState createState() => _ProdukFormState();
}

class _ProdukFormState extends State<ProdukForm> {
  final _kodeProdukController = TextEditingController();
  final _namaProdukController = TextEditingController();
  final _hargaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Produk'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              TextField(
                controller: _kodeProdukController,
                decoration: const InputDecoration(
                  labelText: "Kode Produk",
                  border: UnderlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _namaProdukController,
                decoration: const InputDecoration(
                  labelText: "Nama Produk",
                  border: UnderlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _hargaController,
                decoration: const InputDecoration(
                  labelText: "Harga",
                  border: UnderlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  // Aksi simpan
                  print('Kode Produk: ${_kodeProdukController.text}');
                  print('Nama Produk: ${_namaProdukController.text}');
                  print('Harga: ${_hargaController.text}');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[400],
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: const Text('Simpan', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _kodeProdukController.dispose();
    _namaProdukController.dispose();
    _hargaController.dispose();
    super.dispose();
  }
}

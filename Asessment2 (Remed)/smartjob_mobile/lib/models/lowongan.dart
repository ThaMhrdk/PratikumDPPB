class Lowongan {
  final int? id;
  final String posisi;
  final String perusahaan;
  final String lokasi;
  final String tipe;
  final String deskripsi;

  Lowongan({
    this.id,
    required this.posisi,
    required this.perusahaan,
    required this.lokasi,
    required this.tipe,
    required this.deskripsi,
  });

  // Factory method untuk parsing dari JSON
  factory Lowongan.fromJson(Map<String, dynamic> json) {
    return Lowongan(
      id: json['id'],
      posisi: json['posisi'] ?? '',
      perusahaan: json['perusahaan'] ?? '',
      lokasi: json['lokasi'] ?? '',
      tipe: json['tipe'] ?? '',
      deskripsi: json['deskripsi'] ?? '',
    );
  }

  // Method untuk convert ke JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'posisi': posisi,
      'perusahaan': perusahaan,
      'lokasi': lokasi,
      'tipe': tipe,
      'deskripsi': deskripsi,
    };
  }
}

// Data Dummy Lowongan sesuai ketentuan dosen
final List<Lowongan> lowonganList = [
  Lowongan(
    posisi: "Staff IT",
    perusahaan: "PT Maju Jaya",
    lokasi: "Soreang",
    tipe: "Full-time",
    deskripsi:
        "Bertanggung jawab atas maintenance sistem IT perusahaan dan troubleshooting.",
  ),
  Lowongan(
    posisi: "Admin Gudang",
    perusahaan: "CV Sumber Rejeki",
    lokasi: "Cileunyi",
    tipe: "Kontrak",
    deskripsi: "Mengelola administrasi gudang dan pencatatan inventory.",
  ),
  Lowongan(
    posisi: "Marketing Staff",
    perusahaan: "PT Berkah Sejahtera",
    lokasi: "Banjaran",
    tipe: "Full-time",
    deskripsi: "Melakukan promosi produk dan pengembangan jaringan pemasaran.",
  ),
  Lowongan(
    posisi: "Customer Service",
    perusahaan: "CV Jaya Abadi",
    lokasi: "Margahayu",
    tipe: "Part-time",
    deskripsi: "Melayani pelanggan melalui telepon dan media sosial.",
  ),
  Lowongan(
    posisi: "Accounting Staff",
    perusahaan: "PT Sukses Mandiri",
    lokasi: "Dayeuhkolot",
    tipe: "Full-time",
    deskripsi: "Mengelola pembukuan dan laporan keuangan perusahaan.",
  ),
];

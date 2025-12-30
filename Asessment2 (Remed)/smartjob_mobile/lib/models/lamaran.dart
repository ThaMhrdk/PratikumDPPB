class Lamaran {
  final int? id;
  final String posisi;
  final String perusahaan;
  final String status;
  final String tanggal;
  final String deskripsi;
  final int? lowonganId;
  final String? cvPath;
  final String? dokumenPath;

  Lamaran({
    this.id,
    required this.posisi,
    required this.perusahaan,
    required this.status,
    required this.tanggal,
    required this.deskripsi,
    this.lowonganId,
    this.cvPath,
    this.dokumenPath,
  });

  // Factory method untuk parsing dari JSON
  factory Lamaran.fromJson(Map<String, dynamic> json) {
    return Lamaran(
      id: json['id'],
      posisi: json['lowongan']?['posisi'] ?? json['posisi'] ?? '',
      perusahaan: json['lowongan']?['perusahaan'] ?? json['perusahaan'] ?? '',
      status: json['status'] ?? 'Diproses',
      tanggal: json['created_at'] ?? json['tanggal'] ?? '',
      deskripsi: json['lowongan']?['deskripsi'] ?? json['deskripsi'] ?? '',
      lowonganId: json['lowongan_id'],
      cvPath: json['cv_path'],
      dokumenPath: json['dokumen_path'],
    );
  }

  // Method untuk convert ke JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'posisi': posisi,
      'perusahaan': perusahaan,
      'status': status,
      'tanggal': tanggal,
      'deskripsi': deskripsi,
      'lowongan_id': lowonganId,
      'cv_path': cvPath,
      'dokumen_path': dokumenPath,
    };
  }
}

// Data Dummy Lamaran sesuai ketentuan
final List<Lamaran> lamaranList = [
  Lamaran(
    posisi: "Staff IT",
    perusahaan: "PT Maju Jaya",
    status: "Diproses",
    tanggal: "12-11-2025 08:30",
    deskripsi: "Troubleshooting Database dan maintenance sistem IT perusahaan.",
  ),
  Lamaran(
    posisi: "Admin Gudang",
    perusahaan: "CV Sumber Rejeki",
    status: "Diterima",
    tanggal: "15-11-2025 09:00",
    deskripsi: "Menyusun dan mengelola data inventory gudang.",
  ),
  Lamaran(
    posisi: "Marketing Staff",
    perusahaan: "PT Berkah Sejahtera",
    status: "Ditolak",
    tanggal: "18-11-2025 10:15",
    deskripsi: "Promosi produk dan pengembangan jaringan pemasaran.",
  ),
  Lamaran(
    posisi: "Customer Service",
    perusahaan: "CV Jaya Abadi",
    status: "Diproses",
    tanggal: "20-11-2025 14:00",
    deskripsi: "Melayani pelanggan dan menangani keluhan.",
  ),
];

import 'dart:convert'; // Import package 'dart:convert' untuk mengkonversi data.

void main() {
  // String JSON yang berisi data mahasiswa.
  String jsonString =
      '{"mahasiswa": {"nama": "Hanim Rachma", "npm": "220820100010", "mata_kuliah": [{"nama": "Pemrograman Mobile", "sks": 3, "nilai": "A"}, {"nama": "Pemrograman Website", "sks": 3, "nilai": "A-"}, {"nama": "Statistik Komputasi", "sks": 3, "nilai": "A"}, {"nama": "E-Business", "sks": 3, "nilai": "A"}, {"nama": "PKTI", "sks": 3, "nilai": "A-"}, {"nama": "Kecakapan Pribadi", "sks": 3, "nilai": "A"}, {"nama": "Kepemimpinan", "sks": 3, "nilai": "A-"}, {"nama": "MPSI", "sks": 3, "nilai": "A"}]}}';

  // Mengonversi string JSON menjadi Map menggunakan jsonDecode.
  Map<String, dynamic> dataMahasiswa = jsonDecode(jsonString);

  // Mendapatkan data mahasiswa dari Map.
  Map<String, dynamic> mahasiswa = dataMahasiswa['mahasiswa'];
  print("Nama: ${mahasiswa['nama']}"); // Mencetak nama mahasiswa.
  print("NPM: ${mahasiswa['npm']}"); // Mencetak NPM mahasiswa.

  // Mendapatkan data mata kuliah dari Map mahasiswa.
  List<dynamic> mataKuliah = mahasiswa['mata_kuliah'];

  double totalSKS = 0; // Total SKS awal.
  double totalNilai = 0; // Total nilai awal.

  // Melakukan iterasi untuk setiap mata kuliah.
  for (var matkul in mataKuliah) {
    print("\nMata Kuliah: ${matkul['nama']}"); // Mencetak nama mata kuliah.
    print("SKS: ${matkul['sks']}"); // Mencetak SKS mata kuliah.
    print("Nilai: ${matkul['nilai']}"); // Mencetak nilai mata kuliah.

    // Menambahkan SKS ke total SKS.
    totalSKS += matkul['sks'];
    totalNilai += convertNilai(matkul['nilai']) * matkul['sks'];  // Mengkonversi nilai menjadi bobot nilai dan menambahkannya ke total nilai.
  }
  // Menghitung IPK.
  double ipk = totalNilai / totalSKS;
  print("\nTotal SKS: $totalSKS"); // Mencetak total SKS.
  print("Total Nilai: $totalNilai"); // Mencetak total nilai.
  print("IPK: ${ipk.toStringAsFixed(2)}"); // Mencetak IPK dengan dua angka di belakang koma.
}
double convertNilai(String nilai) { // Fungsi untuk mengkonversi nilai huruf menjadi bobot nilai.
  switch (nilai) {
    case 'A':
      return 4.0; // Bobot nilai A.
    case 'A-':
      return 3.7; // Bobot nilai A-.
    case 'B+':
      return 3.3; // Bobot nilai B+.
    case 'B':
      return 3.0; // Bobot nilai B.
    case 'B-':
      return 2.7; // Bobot nilai B-.
    case 'C+':
      return 2.3; // Bobot nilai C+.
    case 'C':
      return 2.0; // Bobot nilai C.
    case 'D':
      return 1.0; // Bobot nilai D.
    default:
      return 0.0; // Nilai default jika tidak sesuai.
  }
}

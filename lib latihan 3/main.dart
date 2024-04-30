import 'package:flutter/material.dart'; // Import package 'flutter/material.dart' untuk menggunakan framework Flutter.
import 'package:http/http.dart' as http; // Import package 'http' dengan alias 'http' untuk melakukan HTTP requests.
import 'dart:convert'; // Import package 'dart:convert' untuk mengkonversi data.

class University { // Mendefinisikan kelas 'University' yang memiliki atribut nama dan website.
  String name; // Nama universitas.
  String website; // Situs web universitas.

  University({required this.name, required this.website}); // Konstruktor kelas 'University' dengan parameter wajib 'name' dan 'website'.
}

class UniversitiesList { // Mendefinisikan kelas 'UniversitiesList' yang berisi daftar universitas.
  List<University> universities = []; // List untuk menyimpan objek universitas.

  UniversitiesList.fromJson(List<dynamic> json) { // Konstruktor kelas 'UniversitiesList' untuk membuat objek dari data JSON.
    universities = json.map((e) => University( // Mengonversi data JSON menjadi list objek 'University'.
      name: e['name'], // Nama universitas.
      website: e['web_pages'][0], // Situs web universitas.
    )).toList();
  }
}

void main() { // Fungsi main() yang mengeksekusi aplikasi.
  runApp(MyApp()); // Menjalankan aplikasi Flutter.
}

class MyApp extends StatefulWidget { // Kelas MyApp, merupakan StatefulWidget.
  @override
  State<StatefulWidget> createState() { // Membuat dan mengembalikan instance dari MyAppState.
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> { // Kelas MyAppState, merupakan state dari MyApp.
  late Future<UniversitiesList> futureUniversitiesList; // Deklarasi variabel futureUniversitiesList yang menyimpan future dari UniversitiesList.
  String url = "http://universities.hipolabs.com/search?country=Indonesia"; // URL endpoint untuk mengambil data universitas.

  Future<UniversitiesList> fetchData() async { // Fungsi untuk mengambil data universitas dari URL.
    final response = await http.get(Uri.parse(url)); // Mengirimkan permintaan HTTP GET ke URL dan menunggu responsenya.

    if (response.statusCode == 200) { // Jika responsenya 200 OK, parse JSON ke objek UniversitiesList.
      return UniversitiesList.fromJson(jsonDecode(response.body));
    } else { // Jika responsenya bukan 200 OK, lempar exception.
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() { // Fungsi initState() dipanggil setelah widget MyAppState diinisialisasi.
    super.initState();
    futureUniversitiesList = fetchData(); // Memuat data universitas saat initState() dipanggil.
  }

  @override
  Widget build(BuildContext context) { // Fungsi untuk membangun tampilan aplikasi.
    return MaterialApp( // Membuat dan mengembalikan MaterialApp sebagai root widget.
      title: 'University List', // Judul aplikasi.
      home: Scaffold( // Scaffold sebagai struktur dasar halaman.
        appBar: AppBar(
          title: const Text('University List'), // Judul AppBar.
        ),
        body: Center( // Menampilkan FutureBuilder untuk menampilkan data dari future.
          child: FutureBuilder<UniversitiesList>(
            future: futureUniversitiesList, // Future yang akan dibangun.
            builder: (context, snapshot) {
              if (snapshot.hasData) { // Jika data sudah tersedia.
                return ListView.builder( // Membangun ListView untuk menampilkan daftar universitas.
                  itemCount: snapshot.data!.universities.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          title: Center(child: Text(snapshot.data!.universities[index].name, textAlign: TextAlign.center)),
                          subtitle: Center(child: Text(snapshot.data!.universities[index].website, textAlign: TextAlign.center)),
                        ),
                        Divider(), // Garis pemisah antar universitas.
                      ],
                    );
                  },
                );
              } else if (snapshot.hasError) { // Jika terjadi error saat mengambil data.
                return Text('${snapshot.error}');
              }
              return CircularProgressIndicator(); // Tampilkan loading indicator jika masih menunggu data.
            },
          ),
        ),
      ),
    );
  }
}

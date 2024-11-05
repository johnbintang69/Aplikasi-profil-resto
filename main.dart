import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catatan Transaksi Toko Komputer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TransaksiScreen(),
    );
  }
}

class TransaksiScreen extends StatefulWidget {
  @override
  _TransaksiScreenState createState() => _TransaksiScreenState();
}

class _TransaksiScreenState extends State<TransaksiScreen> {
  // Daftar barang dan harga
  final List<Map<String, dynamic>> items = [
    {'name': 'Laptop', 'price': 25000000, 'qty': 0},
    {'name': 'Mouse', 'price': 120000, 'qty': 0},
    {'name': 'Keyboard', 'price': 200000, 'qty': 0},
    {'name': 'Monitor', 'price': 1500000, 'qty': 0},
    {'name': 'Printer', 'price': 2200000, 'qty': 0},
  ];

  // Variabel total bayar dan variabel untuk menampilkan struk
  num totalBayar = 0;
  bool showStruk = false;

  // Fungsi untuk menghitung total bayar
  void calculateTotal() {
    num total = 0;
    for (var item in items) {
      total += item['price'] * item['qty'];
    }
    setState(() {
      totalBayar = total;
    });
  }

  // Fungsi untuk mereset semua input
  void reset() {
    setState(() {
      for (var item in items) {
        item['qty'] = 0;
      }
      totalBayar = 0;
      showStruk = false;
    });
  }

  // Fungsi untuk menampilkan struk
  void cetakStruk() {
    calculateTotal();
    setState(() {
      showStruk = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Toko Komputer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(items[index]['name']),
                    subtitle: Text('Harga: ${items[index]['price']}'),
                    trailing: Container(
                      width: 60,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 8),
                        ),
                        onChanged: (value) {
                          setState(() {
                            items[index]['qty'] = int.tryParse(value) ?? 0;
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: reset,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                    child: Text('Reset'),
                  ),
                  ElevatedButton(
                    onPressed: cetakStruk,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: Text('Cetak Struk'),
                  ),
                ],
              ),
            ),
            Divider(),
            if (showStruk) ...[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Struk Pembelian',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    ...items.map((item) {
                      if (item['qty'] > 0) {
                        return ListTile(
                          leading: Icon(Icons.shopping_cart),
                          title: Text('${item['name']} x ${item['qty']}'),
                          trailing: Text('${item['price'] * item['qty']}'),
                        );
                      }
                      return SizedBox.shrink();
                    }).toList(),
                    Divider(),
                    Text('Total: $totalBayar', style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),
            ],
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Bayar:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '$totalBayar',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

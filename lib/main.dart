import 'package:material_ui/material_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Car DataTable',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CarTableScreen(),
    );
  }
}

class Car {
  final String make;
  final String model;
  final double price;

  const Car({required this.make, required this.model, required this.price});
}

class CarTableScreen extends StatefulWidget {
  const CarTableScreen({super.key});

  @override
  State<CarTableScreen> createState() => _CarTableScreenState();
}

class _CarTableScreenState extends State<CarTableScreen> {
  final List<Car> _cars = [
    const Car(make: 'Honda', model: 'Civic', price: 95000),
    const Car(make: 'Toyota', model: 'Corolla', price: 88000),
    const Car(make: 'Nissan', model: 'Almera', price: 72000),
    const Car(make: 'Perodua', model: 'Myvi', price: 55000),
    const Car(make: 'Proton', model: 'X50', price: 86000),
  ];

  int? _sortColumnIndex;
  bool _sortAscending = true;
  String _searchQuery = '';

  void _sort(int columnIndex, int Function(Car a, Car b) compare) {
    setState(() {
      if (_sortColumnIndex == columnIndex) {
        _sortAscending = !_sortAscending;
      } else {
        _sortAscending = true;
      }

      _sortColumnIndex = columnIndex;

      _cars.sort((a, b) {
        final result = compare(a, b);
        return _sortAscending ? result : -result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchQuery.trim().toLowerCase();
    final filteredCars = _cars.where((car) {
      return car.make.toLowerCase().contains(query) ||
          car.model.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Car Information'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Search by car make or model',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: filteredCars.isEmpty
                  ? const Center(child: Text('No cars match your search.'))
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        sortColumnIndex: _sortColumnIndex,
                        sortAscending: _sortAscending,
                        columns: [
                          DataColumn(
                            label: const Text('Car Make'),
                            onSort: (columnIndex, ascending) {
                              _sort(
                                columnIndex,
                                (a, b) => a.make.compareTo(b.make),
                              );
                            },
                          ),
                          DataColumn(
                            label: const Text('Model'),
                            onSort: (columnIndex, ascending) {
                              _sort(
                                columnIndex,
                                (a, b) => a.model.compareTo(b.model),
                              );
                            },
                          ),
                          DataColumn(
                            label: const Text('Price (RM)'),
                            numeric: true,
                            onSort: (columnIndex, ascending) {
                              _sort(
                                columnIndex,
                                (a, b) => a.price.compareTo(b.price),
                              );
                            },
                          ),
                        ],
                        rows: filteredCars.map((car) {
                          return DataRow(
                            cells: [
                              DataCell(Text(car.make)),
                              DataCell(Text(car.model)),
                              DataCell(Text(car.price.toStringAsFixed(2))),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

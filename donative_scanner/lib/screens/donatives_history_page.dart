import 'package:donative_scanner/utils/color_constants.dart';
import 'package:flutter/material.dart';

import '../models/donative.dart';
import '../services/donative_service.dart';

class DonativesHistoryPage extends StatefulWidget {
  const DonativesHistoryPage({super.key});

  @override
  _DonativesHistoryPage createState() => _DonativesHistoryPage();
}

class _DonativesHistoryPage extends State<DonativesHistoryPage> {
  List<Donative> _donatives = [];

  @override
  void initState() {
    super.initState();
    _loadDonatives();
  }

  void _loadDonatives() async {
    List<Donative> donatives = await DonativeService.getDonatives();
    setState(() {
      _donatives = donatives;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: teal,
      body: _donatives.isEmpty
          ? const Center(
              child: CircularProgressIndicator(color: white),
            )
          : ListView.builder(
              itemCount: _donatives.length,
              itemBuilder: (BuildContext context, int index) {
                String brand = _donatives[index].brand;
                String description = _donatives[index].description;
                String quantity = _donatives[index].quantity.toString();
                return Container(
                  margin: const EdgeInsets.only(left: 25.0, right: 25.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            child: Icon(
                              Icons.delete_forever,
                              color: Colors.red.shade900,
                              size: 25.0,
                            ),
                            onTap: () {
                              showDeletionDialog(_donatives[index]);
                            },
                          ),
                          GestureDetector(
                            child: Icon(
                              Icons.edit,
                              color: Colors.teal.shade900,
                              size: 25.0,
                            ),
                            onTap: () {
                              showEditDialog(_donatives[index]);
                            },
                          ),
                          Expanded(
                            child: ListTile(
                              title: Text(description,
                                  style:
                                      Theme.of(context).textTheme.titleLarge),
                              trailing: Text('Cantidad: $quantity'),
                              subtitle: Text(brand,
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  void showDeletionDialog(Donative donative) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Atención'),
          content: const Text(
              'El donativo será eliminado del historial. Esto no se puede deshacer.'),
          actions: [
            TextButton(
              style: TextButton.styleFrom(backgroundColor: teal),
              onPressed: () async {
                await DonativeService.deleteDonatives(donative.id);
                Navigator.of(context).pop();
                _loadDonatives(); // Recargar la lista de donativos
              },
              child: Text(
                'Aceptar',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancelar',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ],
        );
      },
    );
  }

  void showEditDialog(Donative donative) {
    TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cantidad de Donativo'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Ingrese cantidad (0-100)',
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(backgroundColor: teal),
              onPressed: () async {
                int? donativeAmount = int.tryParse(controller.text);
                if (donativeAmount != null &&
                    donativeAmount >= 0 &&
                    donativeAmount <= 100) {
                  await DonativeService.updateDonatives(
                      donative.id, donativeAmount);
                  Navigator.of(context).pop();
                  _loadDonatives(); // Recargar la lista de donativos
                } else {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Por favor, ingrese un valor válido entre 0 y 100.',
                          style: Theme.of(context).textTheme.labelSmall),
                      backgroundColor: lightTeal,
                    ),
                  );
                }
              },
              child: Text(
                'Aceptar',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancelar',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ],
        );
      },
    );
  }
}

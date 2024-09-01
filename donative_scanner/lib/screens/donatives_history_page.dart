import 'package:donative_scanner/utils/color_constants.dart';
import 'package:flutter/material.dart';

import '../models/donative.dart';
import '../services/donative_service.dart';

class DonativesHistoryPage extends StatefulWidget {
  const DonativesHistoryPage({super.key});

  @override
  State<DonativesHistoryPage> createState() => _DonativesHistoryPage();
}

class _DonativesHistoryPage extends State<DonativesHistoryPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Historial de Escaneo",
            style: (TextStyle(
                color: teal, fontWeight: FontWeight.bold, fontSize: 20))),
        backgroundColor: lightTeal,
        centerTitle: true,
      ),
      backgroundColor: teal,
      body: FutureBuilder(
        future: DonativeService.getDonatives(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<Donative> data = snapshot.data;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
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
                              color: red,
                              size: 25.0,
                            ),
                            onTap: () {
                              showDeletionDialog(data[index]);
                            },
                          ),
                          GestureDetector(
                            child: Icon(
                              Icons.edit,
                              color: lightTeal,
                              size: 25.0,
                            ),
                            onTap: () {
                              showEditDialog(data[index]);
                            },
                          ),
                          Expanded(
                            child: ListTile(
                              title: Text(data[index].brand),
                              trailing: Text(
                                  'Cantidad: ${data[index].quantity.toString()}'),
                              subtitle: Text(data[index].description),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  void showDeletionDialog(Donative donative) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text(
                'Atención',
              ),
              content: Text(
                'El donativo ${donative.id} será eliminado del historial. Esto no se puede deshacer.',
              ),
              actions: [
                TextButton(
                  style: TextButton.styleFrom(backgroundColor: teal),
                  onPressed: () {
                    DonativeService.deleteDonatives(int.parse(donative.id));
                    Navigator.of(context).pop();
                    setState(() {});
                  },
                  child: Text(
                    'Aceptar',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancelar',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
              ]);
        });
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
              hintText: 'Ingrese la cantidad del donativo (0-100)',
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(backgroundColor: teal),
              onPressed: () {
                int? donativeAmount = int.tryParse(controller.text);
                if (donativeAmount != null &&
                    donativeAmount >= 0 &&
                    donativeAmount <= 100) {
                  Navigator.of(context).pop();
                  DonativeService.updateDonatives(
                      int.tryParse(donative.id), donativeAmount);
                  setState(() {});
                } else {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(this.context).showSnackBar(
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
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancelar',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          ],
        );
      },
    );
  }
}

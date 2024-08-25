import 'package:flutter/material.dart';

class CampaignPage extends StatefulWidget {
  const CampaignPage({super.key});

  @override
  _CampaignPageState createState() => _CampaignPageState();
}

class _CampaignPageState extends State<CampaignPage> {

  List<dynamic> campaigns = [
    {
      "ID": 1,
      "name": "Prueba",
      "descripcion": "Reunir 20 cosas.",
      "objective": 20,
      "current":0
    },
    {
      "ID": 2,
      "name": "GuayasCampaign",
      "descripcion": "Reunir 10 alimentos.",
      "objective": 10,
      "current":10
    },
    {
      "ID": 3,
      "name": "Ballenita",
      "descripcion": "Reunir 20 medicamentos x.",
      "objective": 20,
      "current": 7
    },
    {
      "ID": 4,
      "name": "Teleton",
      "descripcion": "Reunir 100 objetos.",
      "objective": 100,
      "current": 64
    },
    {
      "ID": 5,
      "name": "Gotitas del Saber",
      "descripcion": "Reunir 19 juguetes.",
      "objective": 19,
      "current": 8
    },
  ];
  @override
  void initState() {
    super.initState();
  }

  void goToHomePage(){

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 25.0, right: 25.0),
      child: Column(children: [
        Container(
          height: 400,
          margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: campaigns.length,
            itemBuilder: (context, index) {
              return campaignContainer(
                campaigns[index]["name"],
                campaigns[index]["ID"],
                campaigns[index]["descripcion"],
                campaigns[index]["objective"],
                campaigns[index]["current"]
              );
            },
          )
        ),
        Container(
          alignment: Alignment.bottomCenter,
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.teal[200],
              padding: const EdgeInsets.all(10.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
            onPressed: () async {
              goToHomePage();
            },
            child: Text("Crear campaña", style: Theme.of(context).textTheme.labelLarge),
          ),
        )
      ])
    );
  }

  Widget campaignContainer(String name, int id, String descripcion, int objective, int current) {
    return Container(
      width: 310,
      height: 110,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.teal[200],
      ),
      child: Column(
        children: [ 
          Text(
            name,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // columna de datos id, objective, current.
              Container(
                //width: 250,
                margin: const EdgeInsets.only(left: 25.0, right: 25.0),
                child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ID: $id',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    'Objetivo: $objective',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    'Cantidad de donativos: $current',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
                ),
              ),

              // columna descripcion.
              Container(
                //width: 400,
                margin: const EdgeInsets.only(left: 25.0, right: 25.0),
                child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Descripcion:',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    descripcion,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              ),


              // Botones editar y borrar.
              Container(
                //width: 400,
                margin: const EdgeInsets.only(left: 25.0, right: 25.0),
                child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    child: const Icon(
                      Icons.edit,
                      color: Colors.blue,
                      size: 25.0,
                    ),
                  ),
                  GestureDetector(
                    child: const Icon(
                      Icons.delete_forever,
                      color: Colors.red,
                      size: 25.0,
                    ),
                  ),
                ],
              )
              ),
            ],
          ),
        ]
      )
    );
  }
}

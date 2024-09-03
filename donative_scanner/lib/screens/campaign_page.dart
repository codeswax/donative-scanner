import 'package:donative_scanner/models/campaign.dart';
import 'package:flutter/material.dart';
import 'package:donative_scanner/services/campaign_service.dart';

class CampaignPage extends StatefulWidget {
  const CampaignPage({super.key});

  @override
  _CampaignPageState createState() => _CampaignPageState();
}

class _CampaignPageState extends State<CampaignPage> {
  int cantidad = 0;

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

        //boton crear campania
        Container(
          margin: const EdgeInsets.only(top: 20.0, bottom: 20.0, left: 20.0, right: 20.0),
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
              showCampaignDialog();
            },
            child: Text("Crear campaña", style: Theme.of(context).textTheme.labelLarge),
          ),
        ),

        // cuadros campanias
        FutureBuilder(
          future: CampaignService.getCampaings(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            } else {
              List<Campaign> data = snapshot.data;
              cantidad = int.parse(data[data.length-1].id)+1;
              return Container(
                height: 600,
                margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return campaignContainer(data[index]);
                  },
                ),
              );
            }
          },
        ),
        
      ])
    );
  }

  Widget campaignContainer(Campaign campaign){
    return Container(
      width: 310,
      height: 130,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.teal[200],
      ),
      child: Column(
        children: [ 
          Text(
            '${campaign.name}   ID: ${campaign.id}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // columna de datos id, objective, current.
              Container(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Objetivo: ${campaign.objective}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    'Cantidad de donativos: ${campaign.current}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    'Descripcion:',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    campaign.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
                ),
              ),


              // Botones editar y borrar.
              Container(
                //width: 400,
                margin: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      child: const Icon(
                        Icons.edit,
                        color: Colors.blue,
                        size: 25.0,
                      ),
                      onTap: () {
                        showEditDialog(campaign);
                      },
                    ),
                    GestureDetector(
                      child: const Icon(
                        Icons.delete_forever,
                        color: Colors.red,
                        size: 25.0,
                      ),
                      onTap: () {
                        showDeletionDialog(campaign);
                      },
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

// pantalla para eliminar campania.
  void showDeletionDialog(Campaign campaign) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('Atención',
                  style: Theme.of(context).textTheme.bodyMedium),
              content: Text(
                'La campaña ${campaign.id} será eliminado. Esto no se puede deshacer.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              actions: [
                //boton aceptar.
                TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.teal),
                  onPressed: () {
                    CampaignService.deleteCampaign(int.parse(campaign.id));
                    Navigator.of(context).pop();
                    setState(() {});
                  },
                  child: Text(
                    'Aceptar',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),

                cancelBoton(context),
              ]);
        });
  }

// Pantalla para crear campania.
  void showCampaignDialog(){

    // Variables para guardar los valores ingresados.
    final nombreValor = TextEditingController();
    final detalleValor = TextEditingController();
    final objetivoValor = TextEditingController();
    
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('id: $cantidad',
                  style: Theme.of(context).textTheme.bodyMedium),

              // Para llenar los campos
              content: Container(
                width: 310,
                height: 200,
                child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Cuadro para ingresar el nombre
                  cuadroDatos(nombreValor, 'Nombre*', 200, 50),

                  // Cuadro para ingresar la descripcion
                  cuadroDatos(detalleValor, 'Descripción*', 300, 50),

                  // Cuadro para ingresar el objetivo
                  cuadroDatos(objetivoValor, 'Objetivo*', 100, 50),

                ],
                ),
              ),

              // botones
              actions: [
                // boton crear
                TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.teal),
                  onPressed: () {
                    newCampaign(nombreValor.text, detalleValor.text, objetivoValor.text, context);
                  },
                  child: Text(
                    'Crear',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),

                cancelBoton(context),
              ]);
        });
  }

  // Pantalla para actualizar nombre y descripcion de campania.
  void showEditDialog(Campaign campaign){

    // Variables para guardar los valores ingresados.
    final nombreValor = TextEditingController();
    final detalleValor = TextEditingController();
    
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('id: ${campaign.id}',
                  style: Theme.of(context).textTheme.bodyMedium),

                  Text('nombre: ${campaign.name}',
                  style: Theme.of(context).textTheme.bodyMedium),

                  Text('Descripcion: ${campaign.description}',
                  style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
              // Para llenar los campos
              content: Container(
                width: 310,
                height: 200,
                child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  cuadroDatos(nombreValor, 'Nombre*', 200, 50),

                  TextButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.teal),
                    onPressed: () {
                      actualizaNombre(campaign.id, nombreValor.text);
                    },
                    child: Text(
                      'Actualizar Nombre',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),

                  cuadroDatos(detalleValor, 'Descripción*', 300, 50),

                  TextButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.teal),
                    onPressed: () {
                      actualizaDetalle(campaign.id, detalleValor.text);
                    },
                    child: Text(
                      'Actualizar Descripción',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),

                ],
                ),
              ),

              // botones
              actions: [
                // boton crear
                TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.teal),
                  onPressed: () {
                    actualizaTodo(campaign.id, nombreValor.text, detalleValor.text);
                  },
                  child: Text(
                    'Actualizar todo',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),

                cancelBoton(context),
              ]);
        });
  }

  void actualizaTodo(String id, String nombre, String detalle){
    if (nombre == ''){
      mostrarMensaje("llene el campo de nombre");
    } else if (detalle == ''){
      mostrarMensaje("llene el campo de detalle");
    } else {
        CampaignService.updateCampaign(id, nombre, detalle);
        mostrarMensaje("Los datos se actualizaron exitosamente");
        setState(() {});
    }
  }

  void actualizaNombre(String id, String nombre){
    if (nombre == ''){
      mostrarMensaje("llene el campo de nombre");
    } else {
        CampaignService.updateCampaignField(id, nombre, "name");
        mostrarMensaje("El nombre se actualizaron exitosamente");
        setState(() {});
    }
  }

  void actualizaDetalle(String id, String detalle){
    if (detalle == ''){
      mostrarMensaje("llene el campo de Descripción");
    } else {
        CampaignService.updateCampaignField(id, detalle, "description");
        mostrarMensaje("El detalle se actualizaron exitosamente");
        setState(() {});
    }
  }

  void newCampaign(String nombre, String detalle, String objetivo, BuildContext contexto){
    // Se valida que los datos sean correctos.
    if (nombre == ''){
      mostrarMensaje("llene el campo de nombre");
    } else if (detalle == ''){
      mostrarMensaje("llene el campo de Descripción");
    } else if (objetivo == ''){
      mostrarMensaje("llene el campo de objetivo");
    } else {
      int valor = int.tryParse(objetivo) ?? -1;
      if (valor < 0){
        mostrarMensaje("Valor en objetivo no valido, ingrese un numero entero positivo.");
      }else{
        // Se crea la campania
        CampaignService.postCampaign(cantidad.toString(), nombre, detalle, valor);
        Navigator.of(contexto).pop();
        mostrarMensaje("Los datos se subieron exitosamente");
        setState(() {});
      }
    }
  }

  void mostrarMensaje(String texto){
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(texto),
        );
      },
    );
  }

  ConstrainedBox cuadroDatos(TextEditingController controlador, String campo, double x, double y){
    return ConstrainedBox(
      constraints: BoxConstraints.tight(Size(x, y)),
      child: TextFormField(
        controller: controlador,
        decoration: InputDecoration(
          labelText: campo
        ),
      )
    );
  }

  TextButton cancelBoton(BuildContext context){
    return TextButton(
      style: TextButton.styleFrom(backgroundColor: Colors.red),
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: Text(
        'Cancelar',
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }

}

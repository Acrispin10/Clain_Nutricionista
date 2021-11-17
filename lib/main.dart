import 'package:flutter/material.dart';

import 'apiservice.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: HomeScreen(
        title: 'HOLA',
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List datos = [];
  @override
  void initState() {
    //Solo para statefulWidget
    super.initState();

    llamarDatos();
  }

  Future<void> llamarDatos() async {
    List temporal = await ServiceApi.getUserNotes();
    setState(() {
      datos = temporal; // datos es una lista
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.small(
        child: Icon(Icons.add),
        backgroundColor: Colors.teal[200],
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => SecondScreen()));
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.teal[100],
        title: Text('CLAIN'),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: ListView.builder(
            itemCount: datos.length,
            itemBuilder: (BuildContext ctxt, int i) {
              Map dato = datos[i];
              return CartaDeInfo(
                  dieta: dato["nombreDieta"],
                  info: dato["info"],
                  nota: dato["nota"]);
            }),
      ),
    );
  }
}

class CartaDeInfo extends StatelessWidget {
  CartaDeInfo(
      {Key? key, required this.dieta, required this.info, required this.nota})
      : super(key: key);

  String dieta;
  String info;
  String nota;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 15),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: Colors.teal[50],
            child: Row(
              children: [
                Icon(Icons.arrow_right, size: 25),
                Text(
                  " Dieta: " + dieta,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            color: Colors.grey[350],
            width: double.infinity,
            child: Column(
              children: [
                Flexible(
                  flex: 0,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      info + "\nNotas:\n" + nota,
                      textAlign: TextAlign.start,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  TextEditingController DietaController = TextEditingController();
  TextEditingController NombreDietaController = TextEditingController();
  TextEditingController InfoController = TextEditingController();
  TextEditingController MenuController = TextEditingController();
  TextEditingController NotaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal[100],
        title: Text('Ingresar datos Clain '),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            ///
            children: [
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'ID Dieta'),
                controller: DietaController,
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Nombre de Dieta'),
                controller: NombreDietaController,
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Información'),
                controller: InfoController,
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Menú'),
                controller: MenuController,
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Nota'),
                controller: NotaController,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal[200],
                  ),
                  onPressed: () async {
                    String Dieta = DietaController.text;
                    String NombreDieta = NombreDietaController.text;
                    String Info = InfoController.text;
                    String Menu = MenuController.text;
                    String Nota = NotaController.text;

                    //      DataModel data =
                    await ServiceApi.postdata(
                        Dieta, NombreDieta, Info, Menu, Nota);
                  },
                  child: Text("Submit"))
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:activity_beddiaf/listActivite.dart';

class Activite {
  final String title;
  final String location;
  final double price;
  final int numberOfPeople;
  final String imageUrl;
  final String imageCategory;

  Activite({
    required this.title,
    required this.location,
    required this.price,
    required this.numberOfPeople,
    required this.imageUrl,
    required this.imageCategory,
  });
}

class AddActivityScreen extends StatefulWidget {
  @override
  _AddActivityScreenState createState() => _AddActivityScreenState();
}

class _AddActivityScreenState extends State<AddActivityScreen> {
  final _formKey = GlobalKey<FormState>();

  late String _title;
  late String _location;
  late double _price;
  late int _numberOfPeople;
  String _imageUrl = '';
  late String _imageCategory;

  late TextEditingController _imageBase64Controller;

  // Ajout de variables pour la gestion du message
  bool _activityAdded = false;

  // Liste pour stocker les activités
  List<Activite> listeActivites = [];

  Future<void> _addToDatabase(Activite activite) async {
    try {
      // Ajouter l'activité à Firestore
      await FirebaseFirestore.instance.collection('activites').add({
        'title': activite.title,
        'location': activite.location,
        'price': activite.price,
        'numberOfPeople': activite.numberOfPeople,
        'imageUrl': activite.imageUrl,
        'imageCategory': activite.imageCategory,
      });
    } catch (e) {
      // Gérer les erreurs ici
      print('Erreur lors de l\'ajout à la base de données : $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _imageBase64Controller = TextEditingController();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageUrl = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter une activité'),
        backgroundColor: Colors.pink, // Changer la couleur de la barre d'applications selon votre thème
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Titre',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(12.0),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer un titre';
                    }
                    return null;
                  },
                  onSaved: (value) => _title = value!,
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Lieu',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(12.0),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer un lieu';
                    }
                    return null;
                  },
                  onSaved: (value) => _location = value!,
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Prix',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(12.0),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer un prix';
                    }
                    return null;
                  },
                  onSaved: (value) => _price = double.parse(value!),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Nombre de personnes',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(12.0),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer le nombre de personnes';
                    }
                    return null;
                  },
                  onSaved: (value) => _numberOfPeople = int.parse(value!),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Catégorie',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(12.0),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer une catégorie';
                    }
                    return null;
                  },
                  onSaved: (value) => _imageCategory = value!,
                ),
                SizedBox(height: 16.0),
                Container(
                  child: _imageUrl.isNotEmpty
                      ? kIsWeb
                          ? Image.network(_imageUrl)
                          : Image.file(File(_imageUrl))
                      : null,
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text('Choisir une image'),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      // Utiliser les données pour créer un objet Activite
                      Activite nouvelleActivite = Activite(
                        title: _title,
                        location: _location,
                        price: _price,
                        numberOfPeople: _numberOfPeople,
                        imageUrl: _imageUrl,
                        imageCategory: _imageCategory,
                      );

                      // Ajouter à la base de données
                      await _addToDatabase(nouvelleActivite);

                      // Afficher un message de succès
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Activité ajoutée avec succès!'),
                        ),
                      );

                      // Réinitialiser les champs et l'image
                      setState(() {
                        _formKey.currentState!.reset();
                        _imageUrl = '';
                        _activityAdded = true;
                      });
                    }
                  },
                  child: Text('Ajouter cette activité'),
                ),

                // Affichage du message après l'ajout de l'activité
                if (_activityAdded)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'L\'activité a été ajoutée avec succès!',
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    // Naviguer vers la liste des activités avec la liste mise à jour
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListeActivite(),
                      ),
                    );
                  },
                  child: Text('Liste d\'activités'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

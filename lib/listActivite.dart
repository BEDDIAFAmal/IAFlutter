import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:activity_beddiaf/ajouterForm.dart';

class ListeActivite extends StatelessWidget {
  final List<Activite> listeActivites;

  ListeActivite(this.listeActivites);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des activités'),
        backgroundColor: Colors.pink, // Changer la couleur de la barre d'applications selon votre thème
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: listeActivites.length,
          itemBuilder: (context, index) {
            Activite activite = listeActivites[index];

            return Card(
              elevation: 2.0,
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                title: Text(
                  activite.title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Lieu: ${activite.location}'),
                    Text('Nombre de personnes: ${activite.numberOfPeople}'),
                    Text('Prix: ${activite.price}'),
                    Text('Catégorie: ${activite.imageCategory}'),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.image),
                  onPressed: () async {
                    // Show image in full screen when IconButton is pressed
                    await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          child: kIsWeb
                              ? Image.network(activite.imageUrl)
                              : Image.file(File(activite.imageUrl)),
                        );
                      },
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

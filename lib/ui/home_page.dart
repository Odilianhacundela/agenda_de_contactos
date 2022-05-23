// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison

import 'dart:io';

import 'package:agenda_de_contactos/ui/contact_page.dart';
import 'package:flutter/material.dart';
import 'package:agenda_de_contactos/helpers/contact_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContactHelper helper = ContactHelper();

  List<Contact> contacts = [];

  @override
  void initState() {
    super.initState();
    _getAllContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contactos"),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // ignore: null_check_always_fails
          _showContactPage();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            return _contactCard(context, index);
          }),
    );
  }

  Widget _contactCard(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(children: <Widget>[
            Container(
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: contacts[index].img != null
                        ? FileImage(File(contacts[index].img!)) as ImageProvider
                        : AssetImage("images/person.png")),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    contacts[index].name ?? "",
                    style:
                        TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    contacts[index].email ?? "",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Text(
                    contacts[index].phone ?? "",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
      onTap: () {
        
        _showContactPage(contact: contacts[index]);
      },
    );
  }

  void _showContactPage ({Contact? contact}) async {
    final reContact = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: ((context) => ContactPage(
                  contact: contact,
                ))));
    if (reContact != null) {
      if (contact != null) {
        await helper.uptadeContact(reContact);
        _getAllContacts();
      } else {
        await helper.saveContact(reContact);
      }
      _getAllContacts();
    }
  }

  void _getAllContacts() {
    helper.getAllContacts().then((list) {
      setState(() {
        contacts = list;
      });
    });
  }
}

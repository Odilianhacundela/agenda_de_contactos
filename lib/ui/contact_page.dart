
// ignore_for_file: unnecessary_null_comparison

import 'package:agenda_de_contactos/helpers/contact_helper.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);



  final Contact contact;

  ContactPage({this.contact});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {

  late Contact _editorContact;
  @override
  void initState() {
    super.initState();

    if(widget.contact == null) {
      _editorContact = Contact();

    }else{
      _editorContact = Contact.fromMap(widget.contact.toMap());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(_editorContact.name ?? "Novo Contacto"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.save),
        backgroundColor: Colors.red,
        ),
    );
  }
}

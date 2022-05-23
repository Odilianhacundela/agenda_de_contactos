// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:agenda_de_contactos/helpers/contact_helper.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  final Contact? contact;
  const ContactPage({Key? key, this.contact}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  final _nameFocus = FocusNode();

  late Contact _editorContact;
  @override
  void initState() {
    super.initState();

    if (widget.contact == null) {
      _editorContact = Contact();
    } else {
      _editorContact = Contact.fromMap(widget.contact!.toMap());

      _nameController.text = _editorContact.name!;
      _emailController.text = _editorContact.email!;
      _phoneController.text = _editorContact.phone!;
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
        onPressed: () {
          if (_editorContact.name != null && _editorContact.name!.isNotEmpty) {
            Navigator.pop(context, _editorContact);
          } else {
            FocusScope.of(context).requestFocus(_nameFocus);
          }
        },
        child: const Icon(Icons.save),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              GestureDetector(
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: _editorContact.img != null
                            ? FileImage(File(_editorContact.img!))
                                as ImageProvider
                            : AssetImage("images/person.png")),
                  ),
                ),
              ),
              TextField(
                controller: _nameController,
                focusNode: _nameFocus,
                decoration: InputDecoration(labelText: "Nome"),
                onChanged: (text) {
                  setState(() {
                    _editorContact.name = text;
                  });
                },
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: "Email"),
                onChanged: (text) {
                  _editorContact.email = text;
                },
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: "Telefone"),
                onChanged: (text) {
                  _editorContact.phone = text;
                },
                keyboardType: TextInputType.phone,
              ),
            ],
          )),
    );
  }
}

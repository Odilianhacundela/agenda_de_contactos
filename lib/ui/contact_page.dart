import 'package:flutter/material.dart';

import '../helpers/contact_helper.dart';

class ContactPage  extends StatefulWidget {
  const ContactPage ({ Key? key }) : super(key: key);

  final Contact contact;
  
  ContactPage(this.contact);

  @override
  State<ContactPage > createState() => _ContactPage State();
}

class _ContactPage State extends State<ContactPage > {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}
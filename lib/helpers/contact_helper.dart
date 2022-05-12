// ignore_for_file: empty_constructor_bodies, prefer_const_declarations, unnecessary_null_comparison

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String contactTable = 'contactTable';
final String idColum = 'idColum';
final String nameColum = 'nameColum';
final String emailColum = 'emailColum';
final String phoneColum = 'phoneColum';
final String imgColum = 'imgColum';

class ContactHelper {
  static final ContactHelper _instance = ContactHelper.internal();
  factory ContactHelper() => _instance;

  ContactHelper.internal();

  late Database _db;
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "contactsnew.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(
          'CREATE TABLE $contactTable($idColum INTEGER PRIMARY KEY, $nameColum TEXT, $emailColum Text, $phoneColum TEXT, $imgColum TEXT)');
    });
  }

  Future<Contact> saveContact(Contact contact) async {
    Database dbContact = await db;
    contact.id = await dbContact.insert(contactTable, contact.toMap());
    return contact;
  }

  Future<Contact> getContact(int id) async {
    Database dbContact = await db;
    List<Map> maps = await dbContact.query(contactTable,
        columns: [idColum, nameColum, emailColum, phoneColum, imgColum],
        where: "$idColum = ?",
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Contact.fromMap(maps.first);
    } else {
      return Contact();
    }
  }

  Future<int> deleteContact(int id) async {
    Database dbContact = await db;
    return await dbContact
        .delete(contactTable, where: "$idColum = ?", whereArgs: [id]);
  }

  Future<int> uptadeContact(Contact contact) async {
    Database dbContact = await db;
    return await dbContact.update(contactTable, contact.toMap(),
        where: "$idColum = ?", whereArgs: [contact.id]);
  }

  Future<List> getAllContacts() async {
    Database dbContact = await db;
    List listMap = await dbContact.rawQuery("SELECT * FROM $contactTable");
    List<Contact> listContact = [];
    for (Map m in listMap) {
      listContact.add(Contact.fromMap(m));
    }
    return listContact;
  }

  getNumber() async {
    Database dbContact = await db;
    return Sqflite.firstIntValue(
        await dbContact.rawQuery("SELECT COUNT(*) FROM $contactTable"));
  }

  Future close() async {
    Database dbContact = await db;
    dbContact.close();
  }
}

class Contact {
  
  int id = 0;
  String name = '';
  String email = '';
  String phone = '';
  String img = '';

  Contact();

  Contact.fromMap(Map map) {
    id = map[idColum];
    name = map[nameColum];
    email = map[emailColum];
    phone = map[phoneColum];
    img = map[imgColum];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      nameColum: name,
      emailColum: email,
      phoneColum: phone,
      imgColum: img
    };

    if (id != null) {
      map[idColum] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "Contact(id: $id, name: $name, email: $email, phone: $phone, img: $img";
  }
}

import 'dart:convert';
import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:agenda/agenda.dart';

@CustomTag('contacts-app')
class ContactsApp extends PolymerElement {
  var contacts = new Contacts(); 
  
  ContactsApp.created() : super.created() {
    contacts.internalList = toObservable(contacts.internalList);
    load();
  }

  fromJson(List<Map<String, Object>> contactList) {
    contacts.fromJson(contactList);
  }

  load() {
    String json = window.localStorage['agenda'];
    if (json == null) {
      contacts.init();
    } else {
      fromJson(JSON.decode(json));
    }
  }
}
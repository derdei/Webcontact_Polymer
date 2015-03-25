part of agenda;
class Info {
  String phone;
  String email;
  
 void setPhone(String parPhone){
   phone = parPhone;
 }
 
 void setEmail(String parEmail){
   email = parEmail;
 }
 
 String getPhone(){
   return phone;
 }
 
 String getEmail(){
   return email;
 }
 
 Info (){
   setPhone(phone);
   setEmail(email);
 }
 
 String toString(){
   return 'phone: ${phone}, email: ${email}';
 }
 
}
class Contact implements Comparable {
  String name;
  String phone;
  String email;
  
  Info i = new Info();

  Contact(this.name, String parPhone, String parEmail) {
    i.setPhone(parPhone);
    i.setEmail(parEmail);
    phone = i.getPhone();
    email = i.getEmail();
    }

  Contact.fromJson(Map<String, Object> contactMap) {
    name = contactMap['name'];
    phone = contactMap['phone'];
    email = contactMap['email'];

  }

  Map<String, Object> toJson() {
    var contactMap = new Map<String, Object>();
    contactMap['name'] = name;
    contactMap['phone'] = phone; 
    contactMap['email'] = email;
    return contactMap;
  }

  String toString() {
    return '{name: ${name}, phone: ${phone}, email: ${email}}';
  }
  
  /**
   * Compares two contacts based on their names.
   * If the result is less than 0 then the first contact is less than the second,
   * if it is equal to 0 they are equal and
   * if the result is greater than 0 then the first is greater than the second.
   */
  int compareTo(Contact contact) {
    if (email != null && contact.email != null) {
      return email.compareTo(contact.email);
    } else {
      throw new Exception('a contact email must be present');
    }
  }
}

class Contacts {
  var _list = new List<Contact>();

  Iterator<Contact> get iterator => _list.iterator;
  bool get isEmpty => _list.isEmpty;

  List<Contact> get internalList => _list;
  set internalList(List<Contact> observableList) => _list = observableList;

  init() {
    var contact1 = new Contact('Dia', '514-777-5509','dia@ulaval.ca');
    var contact2 = new Contact('Dzenan', '418-777-5509','dzenan@ulaval.ca');
    var contact3 = new Contact('Ali', '581-777-5509','ali@ulaval.ca');
    this..add(contact1)..add(contact2)..add(contact3); 
  }
  
  bool add(Contact newContact) {
    if (newContact == null) {
      throw new Exception('a new contact must be present');
    }
    for (Contact contact in _list) {
      if (newContact.email == contact.email) return false;
    }
    _list.add(newContact);
    return true;
  }
        
  
  Contact find(String email) {
    for (Contact contact in _list) {
      if (contact.email == email)
        return contact;    
      }
    return null;
  }
  
  Contact findPhone(String phone) {
    for (Contact contact in _list) {
      if (contact.phone == phone) return contact;
    }
    return null;
  }
  
  Contact findName(String name) {
    for (Contact contact in _list) {
      if (contact.name == name) return contact;
    }
    return null;
  }
  
  bool remove(Contact contact) {
    return _list.remove(contact);
  }

  sort() {
    _list.sort();
  }
  
  
  List<Map<String, Object>> toJson() {
    var contactList = new List<Map<String, Object>>();
    for (Contact contact in _list) {
      contactList.add(contact.toJson());
    }
    return contactList;
  }

  fromJson(List<Map<String, Object>> contactList) {
    if (!_list.isEmpty) {
      throw new Exception('contacts are not empty');
    }
    for (Map<String, Object> contactMap in contactList) {
      Contact contact = new Contact.fromJson(contactMap);
      add(contact);
    }
  }
}


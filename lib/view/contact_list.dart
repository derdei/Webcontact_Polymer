import 'dart:convert';
import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:agenda/agenda.dart';

@CustomTag('contact-list')
class ContactList extends PolymerElement {
  @published Contacts contacts;

       
  ContactList.created() : super.created();
  add(Event e, var detail, Node target) {
    InputElement name = shadowRoot.querySelector("#name");
    InputElement phone = shadowRoot.querySelector("#phone");
    InputElement email = shadowRoot.querySelector("#email");
    LabelElement message = shadowRoot.querySelector("#message");
    ButtonElement newAdd = shadowRoot.querySelector("#add");

    var error = false;
    message.text = '';
      
    if(!email.disabled){
      
      if (name.value.trim() == '') {
      message.text = 'name is mandatory; ${message.text}';
      error = true;
    }
    if (phone.value.trim() == '') {
      message.text = 'phone is mandatory; ${message.text}';
      error = true;
    }
    if (email.value.trim() == '') {
         message.text = 'email is mandatory; ${message.text}';
         error = true;
       }
    if (!(validateEmail(email.value))) {
            message.text = '@ and . in email is mandatory; ${message.text}';
            error = true;
          }
    
    Contact contactName = contacts.findName(name.value);
       if (contactName != null) {
         message.text = 'web contact with that name already exists; ${message.text}';
         error = true;
       }
       
       Contact contactPhone = contacts.findPhone(phone.value);
              if (contactPhone != null) {
                message.text = 'web contact with that phone already exists; ${message.text}';
                error = true;
              }
    
    if ((!error) && (validateEmail(email.value))){
      var contact = new Contact(name.value, phone.value,email.value);
      if (contacts.add(contact)) {
        contacts.sort();
        save();
        name.value = "";
        phone.value = "";
        email.value = "";
      } else {
        message.text = 'web contact with that email already exists';
      }
    }
    
    }else
    {
      loadPage();
      //newAdd.text="Add";
    }
  }
    
    
  
  delete(Event e, var detail, Node target) {
    InputElement name = shadowRoot.querySelector("#name");
    InputElement phone = shadowRoot.querySelector("#phone");
    InputElement email = shadowRoot.querySelector("#email");
    LabelElement message = shadowRoot.querySelector("#message");
    message.text = '';
    Contact contact = contacts.find(email.value);
    if (contact == null) {
      message.text = 'web contact with this email does not exist';
    } else {
      name.value = contact.name;
      phone.value = contact.phone;
      if (contacts.remove(contact)) {
        save();
      name.value = "";
      phone.value = "";
      email.value = "";
      email.disabled = false;
      }
    }
  }
 
  searchtxt(Event e, var detail, Node target) {
      InputElement search = shadowRoot.querySelector("#search");
      search.value="";
    }
 

  search(Event e, var detail, Node target) {
    InputElement name = shadowRoot.querySelector("#name");
    InputElement phone = shadowRoot.querySelector("#phone");
    InputElement email = shadowRoot.querySelector("#email");
    LabelElement message = shadowRoot.querySelector("#message");
    InputElement searchinfo = shadowRoot.querySelector("#search");
    ButtonElement newAdd = shadowRoot.querySelector("#add");

    
    message.text = '';
    Contact contact;
    
    LabelElement msg = shadowRoot.querySelector("#msg");
         InputElement choice = shadowRoot.querySelector("#choice");
         var linkMessage = ' whit this ';         
    switch(choice.value){
      case "Email": contact = contacts.find(searchinfo.value); break;
      case "Name":  contact = contacts.findName(searchinfo.value);break;
      case "Phone": contact = contacts.findPhone(searchinfo.value); break;
    }
    if (contact == null) {
   message.text = 'web contact does not exist'+linkMessage+choice.value;
   } else {
   name.value = contact.name;
   phone.value = contact.phone;
   email.value = contact.email;
   email.disabled=true;
   newAdd.text="newContact";
   }
    
  }

  update (Event e, var detail, Node target) {
    LabelElement message = shadowRoot.querySelector("#message");
    InputElement email = shadowRoot.querySelector("#email");
        message.text = '';
        Contact contact = contacts.find(email.value);
        if (contact == null) {
          message.text = 'web contact with this email does not exist';
        } else {
    InputElement name = shadowRoot.querySelector("#name");
    InputElement phone = shadowRoot.querySelector("#phone");
    InputElement email = shadowRoot.querySelector("#email");
    Contact contact = contacts.find(email.value);
    contact.name = name.value;
    contact.phone = phone.value;
    save();
    loadPage();
    }
  }
  
  
  
  List<Map<String, Object>> toJson() {
    return contacts.toJson();
  }

  save() {
    window.localStorage['agenda'] = JSON.encode(toJson());
  }
  loadPage(){
  window.location.reload();
  }
  bool validateEmail(String email){
    var testEmail1 = false;
    var testEmail2 = false;

    for(var i = 0; i < email.length; i++) {
      if(email[i]=='@')
          testEmail1 = true;
      else
        if(email[i]=='.')
          testEmail2 = true;
    }  
    if((testEmail1)&&(testEmail2)) 
      return true;
    else
      return false;   
    }
}

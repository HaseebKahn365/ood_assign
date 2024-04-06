//here we should be able to add items to the inventory

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:ood_assign/buisiness_logic/inventory.dart';
import 'package:ood_assign/main.dart';

class AddContactActivity extends StatefulWidget {
  const AddContactActivity({super.key});

  @override
  State<AddContactActivity> createState() => _AdContactmActivityState();
}

class _AdContactmActivityState extends State<AddContactActivity> {
  String email = '';
  String name = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.0,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text('Add Contact',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.15,
            )),
      ),

      //add Text and Text fields for the item title, maker, description, length, width, height, and image, popup menu for the status, and owner
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(19.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Add a text field for the item title
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100.0,
                      child: Text(
                        'Name: ',
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Contact Name',
                        ),
                        onChanged: (value) {
                          setState(() {
                            name = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                // similarlly add text fields for the maker, description,
                const SizedBox(height: 20.0),

                // Add a text field for the email

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100.0,
                      child: Text(
                        'Email: ',
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Contact Email',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an email';
                          } else if (!RegExp(
                            r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
                          ).hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),

                // Add a BIG rounded container for icon or image based on selected image
                const SizedBox(height: 20.0),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.black54),
                    ),
                    onPressed: () {
                      //save the activity and go back to the previous screen
                      try {
                        inventory.contacts.add(
                          Contact(name: name, email: email),
                        );
                        Navigator.pop(context);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(e.toString()),
                          ),
                        );
                      }
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(Icons.save), // Add your desired icon here
                        Text('Save'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                //display all contact list here
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: inventory.contacts.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(inventory.contacts[index].name),
                      subtitle: Text(inventory.contacts[index].email),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

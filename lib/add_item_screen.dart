//here we should be able to add items to the inventory

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ood_assign/buisiness_logic/inventory.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ood_assign/main.dart';

class AddItemActivity extends StatefulWidget {
  final item? itemRecieved;
  Function refresher;
  AddItemActivity({super.key, this.itemRecieved, required this.refresher});

  @override
  State<AddItemActivity> createState() => _AddItemActivityState();
}

class _AddItemActivityState extends State<AddItemActivity> {
  //!state variables
  ItemStatus status = ItemStatus.AVAILABLE;
  String Title = '';
  String Maker = '';
  String Description = '';
  double? Length;
  double? Width;
  double? Height;
  Image? itemImage;
  Contact? owner; // if null that means it is owned by the user

  @override
  void initState() {
    //check if itemRecieved is not null then set the values of the item status and itemImage
    if (widget.itemRecieved != null) {
      status = widget.itemRecieved!.status;
      itemImage = widget.itemRecieved!.itemImage;
      owner = widget.itemRecieved!.owner;
      Title = widget.itemRecieved!.title;
      Maker = widget.itemRecieved!.maker!;
      Description = widget.itemRecieved!.description!;
      Length = widget.itemRecieved!.length;
      Width = widget.itemRecieved!.width;
      Height = widget.itemRecieved!.height;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.0,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        //check if itemRecieved is not null then show Edit Item instead
        title: Text((widget.itemRecieved == null) ? 'Add Item' : 'Edit Item',
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
                        'Title: ',
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          //check if itemRecieved is not null then show the title of the item
                          labelText: (widget.itemRecieved != null) ? widget.itemRecieved!.title : 'Item Title',
                        ),
                        onChanged: (value) {
                          Title = value;
                        },
                      ),
                    ),
                  ],
                ),
                // similarlly add text fields for the maker, description,
                const SizedBox(height: 20.0),

                // Add a text field for the item maker
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100.0,
                      child: Text(
                        'Maker: ',
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: (widget.itemRecieved != null) ? widget.itemRecieved!.maker : 'Item Maker',
                        ),
                        onChanged: (value) {
                          Maker = value;
                        },
                      ),
                    ),
                  ],
                ),

                // Add a text field for the item description

                const SizedBox(height: 20.0),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100.0,
                      child: Text(
                        'Description: ',
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          //check if itemRecieved is not null then show the description of the item
                          labelText: (widget.itemRecieved != null) ? widget.itemRecieved!.description : 'Item Description',
                        ),
                        onChanged: (value) {
                          Description = value;
                        },
                      ),
                    ),
                  ],
                ),

                // Add a text field for the item L x W x H separate fields in a row
                const SizedBox(height: 20.0),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100.0,
                      child: Text(
                        'L x W x H: ',
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 50.0,
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: (widget.itemRecieved != null) ? widget.itemRecieved!.length.toString() : 'L',
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                Length = double.parse(value);
                              },
                            ),
                          ),
                          SizedBox(
                            width: 50.0,
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: (widget.itemRecieved != null) ? widget.itemRecieved!.width.toString() : 'W',
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                Length = double.parse(value);
                              },
                            ),
                          ),
                          SizedBox(
                            width: 50.0,
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: (widget.itemRecieved != null) ? widget.itemRecieved!.height.toString() : 'H',
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                Length = double.parse(value);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ], //end of the L W H
                ),

                // Add a BIG rounded container for icon or image based on selected image
                const SizedBox(height: 20.0),
                //add a pop up menu selector with two options ie. Available and Borrowed
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100.0,
                      child: Text(
                        'Status: ',
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                    Container(
                      width: 200.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.0),
                        color: Colors.grey[300],
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              (status == ItemStatus.AVAILABLE)
                                  ? 'Available'
                                  : (status == ItemStatus.BORROWED)
                                      ? 'Borrowed'
                                      : 'Lent',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            child: PopupMenuButton(
                              icon: Icon(Icons.arrow_drop_down),
                              itemBuilder: (BuildContext context) {
                                return [
                                  PopupMenuItem(
                                    child: Text('Available'),
                                    value: 'Available',
                                    onTap: () {
                                      setState(() {
                                        status = ItemStatus.AVAILABLE;
                                      });
                                    },
                                  ),
                                  PopupMenuItem(
                                    child: Text('Borrowed'),
                                    value: 'Borrowed',
                                    onTap: () {
                                      setState(() {
                                        status = ItemStatus.BORROWED;
                                      });
                                    },
                                  ),
                                  //another one for lent
                                  PopupMenuItem(
                                    child: Text('Lent'),
                                    value: 'Lent',
                                    onTap: () {
                                      setState(() {
                                        status = ItemStatus.LENT;
                                      });
                                    },
                                  ),
                                ];
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                //here we first check if the item is borrow or lent then display the owner name selected otherwise display nothing.
                //also a pop up menu should display all the contacts to select from.

                const SizedBox(height: 20.0),

                if (status == ItemStatus.BORROWED || status == ItemStatus.LENT)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 100.0,
                        child: Text(
                          (status == ItemStatus.BORROWED)
                              ? 'Borrower: '
                              : (status == ItemStatus.LENT)
                                  ? 'Lent To: '
                                  : '',
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                      Container(
                        width: 200.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.0),
                          color: Colors.grey[300],
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                (owner != null) ? owner!.name : 'Select Owner',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              child: PopupMenuButton(
                                icon: Icon(Icons.arrow_drop_down),
                                itemBuilder: (BuildContext context) {
                                  return inventory.contacts.map((Contact contact) {
                                    return PopupMenuItem(
                                      child: Text(contact.name),
                                      value: contact,
                                      onTap: () {
                                        setState(() {
                                          owner = contact;
                                        });
                                      },
                                    );
                                  }).toList();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                const SizedBox(height: 20.0),

                Center(
                  child: GestureDetector(
                    onTap: () async {
                      //use image picker to pick using camera

                      final ImagePicker _picker = ImagePicker();
                      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
                      if (image != null) {
                        setState(() {
                          itemImage = Image.file(File(image.path));
                        });
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 100.0,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: (itemImage != null)
                          ? Image(
                              image: itemImage!.image,
                              fit: BoxFit.cover,
                            )
                          : Icon(
                              Icons.add_a_photo,
                              size: 100.0,
                              color: Colors.black54,
                            ),
                    ),
                  ),
                ),
                // add a remove image and Delete Item button in row
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.black54),
                      ),
                      onPressed: () {
                        setState(() {
                          itemImage = null;
                        });
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(Icons.remove), // Add your desired icon here
                          Text('Remove Image'),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.black54),
                      ),
                      onPressed: () {
                        inventory.removeItem(widget.itemRecieved!);
                        widget.refresher();
                        Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(Icons.close), // Add your desired icon here
                          Text('Delete Item'),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                //at the end add and expanded elevated button that says save

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.black54),
                    ),
                    onPressed: () {
                      //check if itemRecieved is not null then update the item otherwise add a new item
                      if (widget.itemRecieved != null) {
                        inventory.removeItem(widget.itemRecieved!);
                      }
                      inventory.items.add(
                        item(
                          title: Title,
                          maker: Maker,
                          description: Description,
                          length: Length,
                          width: Width,
                          height: Height,
                          itemImage: itemImage,
                          owner: owner,
                          status: status,
                        ),
                      );

                      widget.refresher();
                      Navigator.pop(context);
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

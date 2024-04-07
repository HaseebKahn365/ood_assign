// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ood_assign/addContactActivity.dart';
import 'package:ood_assign/add_item_screen.dart';
import 'package:ood_assign/buisiness_logic/inventory.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sharing App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
          accentColor: Colors.orange,
          cardColor: const Color.fromARGB(255, 46, 42, 42),
          backgroundColor: Color.fromARGB(255, 195, 198, 209),
          errorColor: Colors.red,
          brightness: Brightness.light,
        ),
        useMaterial3: false,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

Inventory inventory = Inventory();

class _MyHomePageState extends State<MyHomePage> {
  void refreshAll() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
              ),
            ),
            PopupMenuButton(
              color: Colors.white,
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddContactActivity(),
                        ),
                      );
                    },
                    height: 30.0,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Contacts',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ];
              },
            ),
          ],
          toolbarHeight: 80.0,
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          title: Text(
            'Sharing App',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.20,
            ),
          ),
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 5.0,
            unselectedLabelColor: Colors.white,
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            tabs: [
              Tab(text: 'ALL'),
              Tab(text: 'AVAILABLE'),
              Tab(text: 'BORROWED'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            All(
              inventory: inventory,
            ),
            Scaffold(
              body: (inventory.items.where((element) => element.status == ItemStatus.AVAILABLE).isEmpty)
                  ? Center(
                      child: Text(
                        'No items to show',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: inventory.items.where((element) => element.status == ItemStatus.AVAILABLE).length,
                      itemBuilder: (context, index) {
                        var tempItemList = inventory.items.where((element) => element.status == ItemStatus.AVAILABLE).toList();
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Card(
                            color: Colors.white,
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddItemActivity(
                                      refresher: () {
                                        setState(() {});
                                      },
                                      itemRecieved: tempItemList[index],
                                    ),
                                  ),
                                );
                              },
                              title: Text(
                                inventory.items.where((element) => element.status == ItemStatus.AVAILABLE).toList()[index].title,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              subtitle: Text(
                                inventory.items.where((element) => element.status == ItemStatus.AVAILABLE).toList()[index].description ?? '',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
            ),
            Scaffold(
              body: (inventory.items.where((element) => element.status == ItemStatus.BORROWED).isEmpty)
                  ? Center(
                      child: Text(
                        'No items to show',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: inventory.items.where((element) => element.status == ItemStatus.BORROWED).length,
                      itemBuilder: (context, index) {
                        var tempItemList = inventory.items.where((element) => element.status == ItemStatus.BORROWED).toList();
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Card(
                            color: Colors.white,
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddItemActivity(
                                      refresher: () {
                                        setState(() {});
                                      },
                                      itemRecieved: tempItemList[index],
                                    ),
                                  ),
                                );
                              },
                              title: Text(
                                inventory.items.where((element) => element.status == ItemStatus.BORROWED).toList()[index].title,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              subtitle: Text(
                                inventory.items.where((element) => element.status == ItemStatus.BORROWED).toList()[index].description ?? '',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
            ),
          ],
        ),
      ),
    );
  }
}

class All extends StatefulWidget {
  final Inventory inventory;
  const All({super.key, required this.inventory});

  @override
  State<All> createState() => _AllState();
}

class _AllState extends State<All> {
  late Function refresher;

  @override
  void initState() {
    refresher = () {
      setState(() {});
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: (widget.inventory.items.isEmpty)
              ? Center(
                  child: Text(
                    'No items to show',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: widget.inventory.items.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Card(
                        color: Colors.white,
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddItemActivity(
                                  itemRecieved: widget.inventory.items[index],
                                  refresher: refresher,
                                ),
                              ),
                            );
                          },
                          title: Text(
                            widget.inventory.items[index].title,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Text(
                            widget.inventory.items[index].description ?? '',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
        ),
        Positioned(
          top: 10.0,
          right: 10.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50.0,
              width: 50.0,
              child: FloatingActionButton(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddItemActivity(
                        refresher: refresher,
                      ),
                    ),
                  );
                },
                child: Icon(
                  Icons.add,
                  color: Colors.green,
                  size: 40,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

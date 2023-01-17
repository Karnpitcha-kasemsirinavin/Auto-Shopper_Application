
import 'package:app_draft1/List_item.dart';
import 'package:app_draft1/Item.dart';
import 'package:flutter/material.dart';

class ItemListPage extends StatelessWidget {

  List<Item> Items = List_item.getMockedItem();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: const [
            Text('Select',
            style: TextStyle(color: Colors.black),)
          ],
        ),
      )
    );
  }

}
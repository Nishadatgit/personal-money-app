import 'package:flutter/material.dart';

Future<void> showCategoryAddPopup(BuildContext context) async {
  showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          title: const Text('Add category'),
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Category Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  )),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Add'),
            )
          ],
        );
      });
}

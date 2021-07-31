import 'package:flutter/material.dart';

class Grid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: GridView.count(
          crossAxisCount: 3,
          children: List.generate(21, (index) {
            return Center(
              child: Card(
                color: Colors.grey.shade200,
                child: Column(
                  children: [
                    Icon(Icons.folder,
                        size: ((MediaQuery.of(context).size.width) / 5)),
                    Container(),
                    Text(
                      'FOLDER',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

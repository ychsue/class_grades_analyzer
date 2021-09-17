import 'package:flutter/material.dart';

class PdfDeclareDrawer extends StatelessWidget {
  const PdfDeclareDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Center(
            child: Text(
              "宣告想列印出來的", //I18N
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.add_circle_outline,
                  color: Colors.blue,
                ),
              ),
              ElevatedButton(onPressed: null, child: Text("執行")), //I18N
            ],
          ),
        ],
      ),
    );
  }
}

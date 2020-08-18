import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CasesOverviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(

        children: [
          //buttons
          Wrap(
            spacing: 10,
            children: [
              DropdownButton(
                onChanged: (index) {
                  //TODO action when the menu is tapped
                  print('selected index $index');
                },
                items: [
                  //TODO populate the Dropdown with data
                  DropdownMenuItem(
                    child: Text('Filter by Province'),
                  ),
                  DropdownMenuItem(
                    child: Text('Filter by Province'),
                  ),
                  DropdownMenuItem(
                    child: Text('Filter by Province'),
                  ),
                ],
              ),
              DropdownButton(
                onChanged: (index) {
                  //TODO action when the menu is tapped
                  print('selected index $index');
                },
                items: [
                  //TODO populate the Dropdown with data
                  DropdownMenuItem(
                    child: Text('Filter by Province'),
                  ),
                  DropdownMenuItem(
                    child: Text('Filter by Province'),
                  ),
                  DropdownMenuItem(
                    child: Text('Filter by Province'),
                  ),
                ],
              ),
              DropdownButton(
                onChanged: (index) {
                  //TODO action when the menu is tapped
                  print('selected index $index');
                },
                items: [
                  //TODO populate the Dropdown with data
                  DropdownMenuItem(
                    child: Text('Filter by Province'),
                  ),
                  DropdownMenuItem(
                    child: Text('Filter by Province'),
                  ),
                  DropdownMenuItem(
                    child: Text('Filter by Province'),
                  ),
                ],
              ),
              FlatButton(
                child: Text('Submit'),
                color: Colors.blueAccent,
                onPressed: () {},
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          //Data here
          Wrap(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.only(bottom: 0),
                  color: Colors.blueGrey,
                  child: ListTile(
                    hoverColor: Colors.blueGrey,
                    leading: CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.deepOrange,
                      child: Icon(
                          Icons.today
                      ),
                    ),
                  ),
                ),
              ),


            ],
          ),
        ],
      ),
    );
  }
}

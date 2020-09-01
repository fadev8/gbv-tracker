import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gbv_tracker/constants/constants.dart';
import 'package:gbv_tracker/widgets/figure_data_tile.dart';
import 'package:gbv_tracker/widgets/rounded_button.dart';

class FigurePage extends StatefulWidget {

  int allCases;
  int physicalCases;
  int psychologicalCases;
  int sexualCases;
  int propertyCases;
  int otherCases;

  FigurePage(
      {this.otherCases,
        this.propertyCases,
        this.psychologicalCases,
        this.physicalCases,
        this.allCases,
        this.sexualCases});
  @override
  _FigurePageState createState() => _FigurePageState();
}

class _FigurePageState extends State<FigurePage> {

  //date and datepicker
  String fromDate, toDate;
  DateTime _date = DateTime.now();

  Future<String> initDatePicker() async{
      DateTime pickedDate = await showDatePicker(context: context, initialDate: _date, firstDate: DateTime(1950), lastDate: DateTime(2100));


      if(pickedDate != null && pickedDate != _date){
        _date = pickedDate;
      }
      return _date.toString();
    }


  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(10),
      children: [
        //Button area
        ExpansionTile(
          title: Text('Filter'),
          leading: Icon(Icons.filter_list),
          children: [
            Column(
              children: [
                Wrap(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        FlatButton(
                          color: Colors.grey,
                          child: Text('From'),
                          onPressed: () async{
                            fromDate = await initDatePicker();
                            setState(() {
                            });
                          },
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            fromDate ?? '',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        FlatButton(
                          color: Colors.grey,
                          padding: EdgeInsets.all(0),
                          child: Text('To'),
                          onPressed: ()async{
                            toDate = await initDatePicker();
                            setState(() {
                            });
                          },
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            toDate ?? '',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10).copyWith(bottom: 0),
                      child: FlatButton(
                        child: Text('Preview'),
                        color: Colors.blueAccent,
                        onPressed: () {
                          //TODO Submit the value of the Dropdown button
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
        FigureDataTile(
          title: 'All cases',
          dataNumber: widget.allCases,
          iconColor: Colors.blue,
          icon: Icons.next_week,
        ),
        SizedBox(
          height: 10,
        ),

        FigureDataTile(
          title: 'Physical',
          dataNumber: widget.physicalCases,
          iconColor: Colors.red,
          icon: Icons.accessibility,
        ),
        SizedBox(
          height: 10,
        ),

        FigureDataTile(
          title: 'Psychological',
          dataNumber: widget.psychologicalCases,
          iconColor: Colors.lightBlueAccent,
          icon: Icons.accessibility,
        ),
        SizedBox(
          height: 10,
        ),

        FigureDataTile(
          title: 'Sexual',
          dataNumber: widget.physicalCases,
          iconColor: Colors.orange,
          icon: Icons.people,
        ),
        SizedBox(
          height: 10,
        ),

        FigureDataTile(
          title: 'Property',
          dataNumber: widget.propertyCases,
          iconColor: Colors.blueAccent,
          icon: FontAwesomeIcons.warehouse,
        ),
        SizedBox(
          height: 10,
        ),

        FigureDataTile(
          title: 'Others',
          dataNumber: widget.otherCases,
          iconColor: Colors.green,
          icon: FontAwesomeIcons.folderOpen,
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

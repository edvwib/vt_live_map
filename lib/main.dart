import 'package:flutter/material.dart';
import 'package:vt_live_map/vt/widgets/LiveMap.dart';

void main() {
  runApp(MaterialApp(
    title: 'VT Live Map',
    home: Start(),
  ));
}

class Start extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meny'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Realtidskarta'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => VTLiveMap()),
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> feedData = [];

  @override
  void initState() {
    super.initState();
    _fetchFeedData();
  }

  Future<void> _fetchFeedData() async {
    final response =
        await http.get(Uri.parse('http://m2.guilhermesperb.com.br/feed'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        feedData = data;
      });
    } else {
      throw Exception('Não foi possivel carregar o feed');
    }
  }

  void _showLocationDialog(double latitude, double longitude) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Localização Imagem'),
          content: Text('Latitude: $latitude\nLongitude: $longitude'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: feedData.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _showLocationDialog(
                  feedData[index]['latitude'], feedData[index]['longitude']);
            },
            child: Card(
              margin: EdgeInsets.all(10.0),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      feedData[index]['usuario'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 10),
                    Image.memory(base64Decode(feedData[index]['imagem'])),
                    SizedBox(height: 10),
                    Text(
                        'Latitude: ${feedData[index]['latitude']}\nLongitude: ${feedData[index]['longitude']}'),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/capture');
        },
        tooltip: 'Capture Image',
        child: const Icon(Icons.add),
      ),
    );
  }
}

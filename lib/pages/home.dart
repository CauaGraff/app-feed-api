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
      throw Exception('Failed to load feed data');
    }
  }

  void _showLocationDialog(double latitude, double longitude) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Image Location'),
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
          return ListTile(
            leading: Image.memory(base64Decode(feedData[index]['imagem'])),
            title: Text(feedData[index]['usuario']),
            subtitle: Text(
                'Location: ${feedData[index]['latitude']}, ${feedData[index]['longitude']}'),
            onTap: () {
              _showLocationDialog(
                  feedData[index]['latitude'], feedData[index]['longitude']);
            },
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

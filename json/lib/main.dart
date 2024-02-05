import 'package:flutter/material.dart';
import 'package:json/album.dart';
import 'package:json/networking.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<Album> album;
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    album = NetworkManager().fetchAlbum();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: "Enter Title"),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        album = NetworkManager().createAlbum(_controller.text);
                      });
                    },
                    child: const Text('Create Data')),
                const SizedBox(height: 10),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        album =
                            NetworkManager().updateAlbum(1, _controller.text);
                      });
                    },
                    child: const Text('Update Data')),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      album = NetworkManager().deleteAlbum(1);
                    });
                  },
                  child: const Text('Delete Data'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            FutureBuilder(
                future: album,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Center(
                      child: Text(snapshot.data?.title ?? 'Deleted'),
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ],
        ));
  }
}

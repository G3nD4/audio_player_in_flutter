import 'package:flutter/material.dart';
import 'package:mediation_app/assets/widgets/album_container.dart';
import 'package:mediation_app/hitmotorAPI/hitmotor_api.dart';
import 'package:mediation_app/hitmotorAPI/objects/album.dart';

class AlbumsScreen extends StatefulWidget {
  const AlbumsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AlbumsScreenState();
}

class _AlbumsScreenState extends State<AlbumsScreen> {
  int multiplier = 0;
  List<Widget> children = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 190, 190, 190),
        title: const Text('Top Albums'),
      ),
      //backgroundColor: const Color(0xffdfdfdf),
      body: _buildStreamBuilder(0),
      bottomNavigationBar: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 190, 190, 190),
                shape: BoxShape.rectangle,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                border: Border.all(color: const Color(0x4d9e9e9e), width: 1),
              ),
              child: MaterialButton(
                onPressed: () {
                  if (multiplier >= 0) {
                    setState(() {
                      _buildStreamBuilder(-1);
                  });
                  }
                },
                child: const Text('Back')
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 190, 190, 190),
                shape: BoxShape.rectangle,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                border: Border.all(color: const Color(0x4d9e9e9e), width: 1),
              ),
              child: MaterialButton(
                onPressed: () {
                  setState(() {
                    _buildStreamBuilder(1);
                  });
                },
                child: const Text('Next')
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildStreamBuilder(int multiplierValueUpdate) {
    multiplier += multiplierValueUpdate;

    return StreamBuilder(
      stream: getAlbumsFromHitmotor(multiplier).asStream(),
      builder: (context, snapshot) {
        List<Widget> children = [];

        if (snapshot.hasError) {
          return const Center(
            child: Text('No internet connection...'),
          );
        } else {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    Text('Connecting to hitmotor...')
                  ]
                )
              );
            case ConnectionState.waiting:
              return const Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    Text('Collecting albums...')
                  ]
                )
              );
            case ConnectionState.active:
              return const Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    Text('Preparing albums...')
                  ]
                )
              );
            case ConnectionState.done:
              children = snapshot.data!.map((Album album) =>
                AlbumContainer(
                  albumImage: Image.network(
                    album.imageRef,
                    errorBuilder: (BuildContext context, Object exception, stackTrace) => Image.asset('no_image.png')
                  ),
                  albumAuthor: album.author,
                  albumName: album.album,
                  href: album.href,
                )).toList();
              
              return GridView(
                padding: EdgeInsets.zero,
                shrinkWrap: false,
                scrollDirection: Axis.vertical,
                physics: const ScrollPhysics(),
                primary: false,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1.2,
                ),
                children: children
              );
          }
        }
      }
    );
  }
}

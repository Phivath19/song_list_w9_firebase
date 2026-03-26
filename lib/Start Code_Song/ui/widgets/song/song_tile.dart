import 'package:flutter/material.dart';
import 'package:song_list/Start%20Code_Song/model/artists/artist.dart';
import 'package:song_list/Start%20Code_Song/ui/utils/time_format.dart';

import '../../../model/songs/song.dart';

class SongTile extends StatelessWidget {
  const SongTile({
    super.key,
    required this.song,
    required this.isPlaying,
    required this.onTap,
    required this.artist,
  });

  final Song song;
  final bool isPlaying;
  final VoidCallback onTap;
  final Artist artist;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          onTap: onTap,
          leading: CircleAvatar(backgroundImage: NetworkImage(song.imageUrl)),
          title: Text(song.title),
          subtitle: Text(
            '${TimeFormat.fomatduration(song.duration)} min ${artist.name} - ${artist.genre}',
          ),
          trailing: Text(
            isPlaying ? "Playing" : "",
            style: TextStyle(color: Colors.amber),
          ),
        ),
      ),
    );
  }
}

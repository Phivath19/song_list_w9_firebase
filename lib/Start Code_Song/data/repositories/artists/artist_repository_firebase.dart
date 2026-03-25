import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../model/artists/artist.dart';
import '../../dtos/artist_dto.dart';
import 'artist_repository.dart';

class ArtistRepositoryFirebase extends ArtistRepository {
  final Uri artistsUri = Uri.https(
    'w9-practice-bf5f0-default-rtdb.asia-southeast1.firebasedatabase.app',
    '/artists.json',
  );

  @override
  Future<List<Artist>> fetchArtists() async {
    final http.Response response = await http.get(artistsUri);

    if (response.statusCode == 200) {
      Map<String, dynamic> artistsMap = json.decode(response.body);

      return artistsMap.entries
          .map(
            (entry) => ArtistDto.fromJson(
              entry.key, // "artist_1", "artist_2"...
              Map<String, dynamic>.from(entry.value), // artist data
            ),
          )
          .toList();
    } else {
      throw Exception('Failed to load artists');
    }
  }

  @override
  Future<Artist?> fetchArtistById(String id) async {}
}

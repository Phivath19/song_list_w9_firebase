import 'package:flutter/material.dart';
import 'package:song_list/Start%20Code_Song/data/repositories/artists/artist_repository.dart';
import 'package:song_list/Start%20Code_Song/model/artists/artist.dart';
import '../../../../data/repositories/songs/song_repository.dart';
import '../../../states/player_state.dart';
import '../../../../model/songs/song.dart';
import '../../../utils/async_value.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final ArtistRepository artistRepository;
  final PlayerState playerState;

  AsyncValue<List<Song>> songsValue = AsyncValue.loading();
  AsyncValue<List<Artist>> artistsValue = AsyncValue.loading();
  LibraryViewModel({
    required this.songRepository,
    required this.playerState,
    required this.artistRepository,
  }) {
    playerState.addListener(notifyListeners);

    // init
    _init();
  }
  List<Artist> artists = [];

  @override
  void dispose() {
    playerState.removeListener(notifyListeners);
    super.dispose();
  }

  void _init() async {
    fetchSong();
    fetchArtists();
  }

  void fetchSong() async {
    // 1- Loading state
    songsValue = AsyncValue.loading();
    notifyListeners();

    try {
      // 2- Fetch is successfull
      List<Song> songs = await songRepository.fetchSongs();
      songsValue = AsyncValue.success(songs);
    } catch (e) {
      // 3- Fetch is unsucessfull
      songsValue = AsyncValue.error(e);
    }
    notifyListeners();
  }

  void fetchArtists() async {
    artistsValue = AsyncValue.loading();
    notifyListeners();
    try {
      artists = await artistRepository.fetchArtists();
      artistsValue = AsyncValue.success(artists);
    } catch (e) {
      artistsValue = AsyncValue.error(e);
    }
    notifyListeners();
  }

  // String getArtistName(String artistId) {
  //   if (artistsValue.data == null) return artistId;
  //   return artistsValue.data!
  //       .firstWhere(
  //         (a) => a.id == artistId,
  //         orElse: () =>
  //             Artist(id: artistId, name: artistId, genre: '', imageUrl: ''),
  //       )
  //       .name;
  // }

  Artist? getArtist(Song song) {
    try {
      return artists.firstWhere((a) => a.id == song.artistId);
    } catch (e) {
      throw Exception(e);
    }
  }

  bool isSongPlaying(Song song) => playerState.currentSong == song;
  void start(Song song) => playerState.start(song);
  void stop(Song song) => playerState.stop();
}

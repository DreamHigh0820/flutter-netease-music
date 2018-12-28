import 'package:quiet/model/model.dart';
import 'package:quiet/repository/netease.dart';

class PlaylistDetail {
  PlaylistDetail(this.id, this.musicList, this.creator, this.name,
      this.coverUrl, this.trackCount);

  ///null when playlist not complete loaded
  final List<Music> musicList;

  final String name;

  final String coverUrl;

  final int id;

  final int trackCount;

  bool get loaded => musicList != null && musicList.length == trackCount;

  ///tag fro hero transition
  String get heroTag => "playlist_hero_$id";

  ///
  /// properties:
  /// avatarUrl , nickname
  ///
  final Map<String, dynamic> creator;

  static PlaylistDetail fromJson(Map playlist) {
    return PlaylistDetail(
        playlist["id"],
        _mapPlaylist(playlist["tracks"]),
        playlist["creator"],
        playlist["name"],
        playlist["coverImgUrl"],
        playlist["trackCount"]);
  }
}

///map playlist json tracks to Music list
List<Music> _mapPlaylist(List<Object> tracks) {
  if (tracks == null) {
    return null;
  }
  var list = tracks
      .cast<Map>()
      .map((e) => mapJsonToMusic(e, artistKey: "ar", albumKey: "al"));
  return list.toList();
}

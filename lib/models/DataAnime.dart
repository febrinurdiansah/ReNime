class AnimeInfo {
  final String id;
  final String title;
  final String type;
  final String releaseDate;
  final String status;
  final String url;
  final List<String> genre;
  final String othertitle;
  final String description;
  final String image;
  final int totalEpisodes;

  AnimeInfo({
    required this.id,
    required this.title,
    required this.type,
    required this.releaseDate,
    required this.status,
    required this.url,
    required this.genre,
    required this.othertitle,
    required this.description,
    required this.image,
    required this.totalEpisodes,
  });
}

class AnimeList {
  final String id;
  final String title;
  final String image;

  AnimeList({
    required this.id,
    required this.title,
    required this.image,
  });
}

class VideoSource {
  final String url;
  final bool isM3U8;
  final String quality;

  VideoSource({
    required this.url,
    required this.isM3U8,
    required this.quality,
  });
}

List<VideoSource> parseVideoSources(Map<String, dynamic> data) {
  final List<VideoSource> sources = [];
  final List<dynamic> sourcesData = data['sources'];
  for (final sourceData in sourcesData) {
    final source = VideoSource(
      url: sourceData['url'],
      isM3U8: sourceData['isM3U8'],
      quality: sourceData['quality'],
    );
    sources.add(source);
  }
  return sources;
}



class Quality {
  final String url, label;
  Quality({
    required this.url,
    required this.label,
  });
  
}

final List<Quality> videoQualities = [
    Quality(
      url:
          "https://www002.vipanicdn.net/streamhls/0789fd4f049c3ca2a49b860ea5d1f456/ep.1.1677591537.360.m3u8",
      label: "360p",
    ),
    Quality(
      url:
          "https://thepaciellogroup.github.io/AT-browser-tests/video/ElephantsDream.mp4",
      label: "480p",
    ),
    Quality(
      url:
          "https://thepaciellogroup.github.io/AT-browser-tests/video/ElephantsDream.mp4",
      label: "720p",
    ),
    Quality(
      url:
          "https://thepaciellogroup.github.io/AT-browser-tests/video/ElephantsDream.mp4",
      label: "1080p",
    ),
  ];

final List<Map<String, dynamic>> Anime = [
    { 
      'id': '1',
      'image':'images/project-1.jpg',
      'judul': "Abctoy",
      'genre': ['Action', 'Isekai','Comedy', 'Romance', 'Adventure', 'Drama'],
      "releaseDate": "2019", 
      "description": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.", 
      "totalEpisodes": 12,
      "status": "Ongoing",
    },
    {
      'id': '12',
      'image': 'images/project-2.jpg',
      'judul': "Bcave",
      'genre': ['Adventure','Isekai','Comedy', 'Romance',],
      "releaseDate": "2019", 
      "description": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.", 
      "totalEpisodes": 12,
      "status": "Ongoing",
    },
    {
      'id': '55',
      'image': 'images/anime.jpg',
      'judul': "Attack on Titan",
      'genre': ['Adventure','Isekai','Comedy', 'Romance',],
      "releaseDate": "2019", 
      "description": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.", 
      "totalEpisodes": 64,
      "status": "Ongoing",
    },
    {
      'id': '23',
      'image': 'images/project-3.PNG',
      'judul': "Cabas",
      'genre': ['Action',  'Comedy', 'Romance',  'Fantasy'],
      "releaseDate": "2019", 
      "description": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.", 
      "totalEpisodes": 12,
      "status": "Ongoing",
    },
    {
      'id': '73',
      'image': 'images/project-2.jpg',
      'judul': "Pohge",
      'genre': ['Adventure',  'Action', 'Comedy', 'Isekai', 'Romance'],
      "releaseDate": "2019", 
      "description": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.", 
      "totalEpisodes": 12,
      "status": "Ongoing",
    },
    {
      'id': '34',
      'image': 'images/project-3.PNG',
      'judul': "Sgtcom",
      'genre': ['Drama', 'Comedy', 'Romance', 'Horor'],
      "releaseDate": "2022", 
      "description": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.", 
      "totalEpisodes": 24,
      "status": "Ongoing",
    },
    {
      'id': '25',
      'image': 'images/project-1.jpg',
      'judul': "Xomcop",
      'genre': [ 'Adventure', 'Comedy', 'Romance', 'Fantasy'],
      "releaseDate": "2018", 
      "description": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.", 
      "totalEpisodes": 24,
      "status": "Complate",
    },
    {
      'id': '46',
      'image': 'images/project-2.jpg',
      'judul': "Pohge",
      'genre': ['Comedy',  'Romance', 'Sport',],
      "releaseDate": "2023", 
      "description": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.", 
      "totalEpisodes": 12,
      "status": "Ongoing",
    },
    {
      'id': '17',
      'image': 'images/project-3.PNG',
      'judul': "Sgtcom",
      'genre': ['Action', 'Drama', 'Fantasy', 'Horor'],
      "releaseDate": "2016", 
      "description": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.", 
      "totalEpisodes": 12,
      "status": "Complate",
    },
    {
      'id': '81',
      'image': 'images/project-1.jpg',
      'judul': "Xomcop",
      'genre': [ 'Adventure', 'Comedy', 'Isekai', 'Fantasy'],
      "releaseDate": "2015", 
      "description": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.", 
      "totalEpisodes": 24,
      "status": "Complate",
    },
  ];

final List<Map<String, dynamic>> TopAiring = [
    { 
      'id': '1',
      'image':'images/project-1.jpg',
      'judul': "Abctoy",
      'genre': ['Action', 'Isekai','Comedy', 'Romance', 'Adventure', 'Drama'],
    },
    {
      'id': '12',
      'image': 'images/project-2.jpg',
      'judul': "Bcave",
      'genre': ['Adventure','Isekai','Comedy', 'Romance',],
    },
    {
      'id': '23',
      'image': 'images/project-3.PNG',
      'judul': "Cabas",
      'genre': ['Action',  'Comedy', 'Romance',  'Fantasy'],
    },
    {
      'id': '73',
      'image': 'images/project-2.jpg',
      'judul': "Pohge",
      'genre': ['Adventure',  'Action', 'Comedy', 'Isekai', 'Romance'],
    },
    {
      'id': '34',
      'image': 'images/project-3.PNG',
      'judul': "Sgtcom",
      'genre': ['Drama', 'Comedy', 'Romance', 'Horor'],
    },
    {
      'id': '25',
      'image': 'images/project-1.jpg',
      'judul': "Xomcop",
      'genre': [ 'Adventure', 'Comedy', 'Romance', 'Fantasy'],
    },
    {
      'id': '46',
      'image': 'images/project-2.jpg',
      'judul': "Pohge",
      'genre': ['Comedy',  'Romance', 'Sport',],
    },
    {
      'id': '17',
      'image': 'images/project-3.PNG',
      'judul': "Sgtcom",
      'genre': ['Action', 'Drama', 'Fantasy', 'Horor'],
    },
    {
      'id': '81',
      'image': 'images/project-1.jpg',
      'judul': "Xomcop",
      'genre': [ 'Adventure', 'Comedy', 'Isekai', 'Fantasy'],
    },
  ];
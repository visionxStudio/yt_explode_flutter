class YoutubeApiClient {
  final Map<String, dynamic> payload;
  final String apiUrl;
  final Map<String, dynamic> headers;

  const YoutubeApiClient(this.payload, this.apiUrl, {this.headers = const {}});

  YoutubeApiClient.fromJson(Map<String, dynamic> json)
      : payload = json['payload'],
        apiUrl = json['apiUrl'],
        headers = json['headers'];

  Map<String, dynamic> toJson() => {
        'payload': payload,
        'apiUrl': apiUrl,
        'headers': headers,
      };

  /// Has limited streams but doesn't require signature deciphering.
  static const ios = YoutubeApiClient({
    'context': {
      'client': {
        'clientName': 'IOS',
        'clientVersion': '19.29.1',
        'deviceMake': 'Apple',
        'deviceModel': 'iPhone16,2',
        'hl': 'en',
        'osName': 'iPhone',
        'osVersion': '17.5.1.21F90',
        'timeZone': 'UTC',
        'userAgent':
            'com.google.ios.youtube/19.29.1 (iPhone16,2; U; CPU iOS 17_5_1 like Mac OS X;)',
        'gl': 'US',
        'utcOffsetMinutes': 0
      }
    },
  }, 'https://www.youtube.com/youtubei/v1/player?key=AIzaSyB-63vPrdThhKuerbB2N_l7Kwwcxj6yUAc&prettyPrint=false');

  /// This provides also muxed streams but seems less reliable than [ios].
  /// If you require an android client use [androidVr] instead.
  static const android = YoutubeApiClient({
    'context': {
      'client': {
        'clientName': 'ANDROID',
        'clientVersion': '19.09.37',
        'androidSdkVersion': 30,
        'userAgent':
            'com.google.android.youtube/19.09.37 (Linux; U; Android 11) gzip',
        'hl': 'en',
        'timeZone': 'UTC',
        'utcOffsetMinutes': 0,
      },
    },
  }, 'https://www.youtube.com/youtubei/v1/player?prettyPrint=false');

  /// Has limited streams but doesn't require signature deciphering.
  /// As opposed to [android], this works only for music.
  static const androidMusic = YoutubeApiClient({
    'context': {
      'client': {
        'clientName': 'ANDROID_MUSIC',
        'clientVersion': '2.16.032',
        'androidSdkVersion': 31,
        'userAgent':
            'com.google.android.youtube/19.29.1  (Linux; U; Android 11) gzip',
        'hl': 'en',
        'timeZone': 'UTC',
        'utcOffsetMinutes': 0,
      },
    },
  }, 'https://music.youtube.com/youtubei/v1/player?key=AIzaSyAOghZGza2MQSZkY_zfZ370N-PUdXEo8AI&prettyPrint=false');

  /// This client also provide high quality muxed stream in the HLS manifest.
  /// The streams are in m3u8 format.
  static const safari = YoutubeApiClient({
    'context': {
      'client': {
        'clientName': 'WEB',
        'clientVersion': '2.20240726.00.00',
        'userAgent':
            'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.5 Safari/605.1.15,gzip(gfe)',
        'hl': 'en',
        'timeZone': 'UTC',
        'utcOffsetMinutes': 0,
      },
    },
  }, 'https://www.youtube.com/youtubei/v1/player?prettyPrint=false');

  /// Used to bypass same restriction on videos.
  static const tv = YoutubeApiClient(
      {
        'context': {
          'client': {
            'clientName': 'TVHTML5',
            'clientVersion': '7.20240724.13.00',
            'hl': 'en',
            'timeZone': 'UTC',
            'gl': 'US',
            'utcOffsetMinutes': 0
          }
        },
        "contentCheckOk": true,
        "racyCheckOk": true
      },
      'https://www.youtube.com/youtubei/v1/player?prettyPrint=false',
      headers: {
        'Sec-Fetch-Mode': 'navigate',
        'Content-Type': 'application/json',
        'Origin': 'https://www.youtube.com',
      });

  /// Provides high quality videos (not only VR).
  static const androidVr = YoutubeApiClient({
    'context': {
      'client': {
        'clientName': 'ANDROID_VR',
        'clientVersion': '1.56.21',
        'deviceModel': 'Quest 3',
        'osVersion': '12',
        'osName': 'Android',
        'androidSdkVersion': '32',
        'hl': 'en',
        'timeZone': 'UTC',
        'utcOffsetMinutes': 0,
      },
    },
  }, 'https://www.youtube.com/youtubei/v1/player?prettyPrint=false');

  static const mediaConnect = YoutubeApiClient({
    'context': {
      'client': {
        'clientName': 'MEDIA_CONNECT_FRONTEND',
        'clientVersion': '0.1',
        'hl': 'en',
        'timeZone': 'UTC',
        'utcOffsetMinutes': 0,
      },
    },
  }, 'https://www.youtube.com/youtubei/v1/player?prettyPrint=false');

  /// Sometimes includes low quality streams (eg. 144p12).
  static const mweb = YoutubeApiClient({
    'context': {
      'client': {
        'clientName': 'MWEB',
        'clientVersion': '2.20240726.01.00',
        'hl': 'en',
        'timeZone': 'UTC',
        'utcOffsetMinutes': 0,
      },
    },
  }, 'https://www.youtube.com/youtubei/v1/player?prettyPrint=false');

  @Deprecated('Youtube always requires authentication for this client')
  static const webCreator = YoutubeApiClient({
    'context': {
      'client': {
        'clientName': 'WEB_CREATOR',
        'clientVersion': '1.20240723.03.00',
        'hl': 'en',
        'timeZone': 'UTC',
        'utcOffsetMinutes': 0,
      },
    },
  }, 'https://www.youtube.com/youtubei/v1/player?prettyPrint=false');

  /// Work even of restricted videos and provides low quality muxed streams, but requires signature deciphering.
  /// Does not work if the video has the embedding disabled.
  @Deprecated('Youtube always requires authentication for this client')
  static const tvSimplyEmbedded = YoutubeApiClient(
      {
        'context': {
          'client': {
            'clientName': 'TVHTML5_SIMPLY_EMBEDDED_PLAYER',
            'clientVersion': '2.0',
            'hl': 'en',
            'timeZone': 'UTC',
            'gl': 'US',
            'utcOffsetMinutes': 0
          }
        },
        'thirdParty': {'embedUrl': 'https://www.youtube.com/'},
        'contentCheckOk': true,
        'racyCheckOk': true
      },
      'https://www.youtube.com/youtubei/v1/player?prettyPrint=false',
      headers: {
        'Sec-Fetch-Mode': 'navigate',
        'Content-Type': 'application/json',
        'Origin': 'https://www.youtube.com',
      });
}

import 'dart:async';
import 'dart:convert';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:http/http.dart' as http;

import '../scot_api.dart';

/// Exception thrown when getPost fails.
class ContentRequestFailure implements Exception {
  final int statusCode;

  const ContentRequestFailure({required this.statusCode});

  @override
  String toString() {
    return 'ContentRequestFailure: HTTP $statusCode received';
  }
}

class NotFoundFailure implements Exception {
  final String message;

  const NotFoundFailure(this.message);
}

class ScotApiClient {
  static const _baseUrl = 'scot-api.hive-engine.com';
  final http.Client _httpClient;

  /// {@macro lightning_api_client}
  ScotApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  Future<Map<String, AccountTokenData>> getAccount(String accountName,
      {String? token}) async {
    final queryArgs = {
      'hive': '1',
    };
    if (token != null) {
      queryArgs['token'] = token;
    }
    final uri = Uri.https(_baseUrl, '/@$accountName', queryArgs);
    print('getAccount > $uri');
    final bodyJson = await _fetchData(uri);

    try {
      final account = bodyJson
          .map((key, value) => MapEntry(key, AccountTokenData.fromJson(value)));
      print('Success scot getClient $accountName');
      return account;
    } catch (e, s) {
      print('Failed to parse $accountName: $e');
      print(s);
      print('Failed data: $bodyJson');
      throw e;
    }
  }

  Future<Map<String, dynamic>> _fetchData(Uri uri) async {
    final postResponse = await _httpClient.get(uri);

    if (postResponse.statusCode != 200) {
      throw ContentRequestFailure(statusCode: postResponse.statusCode);
    }

    final data = jsonDecode(postResponse.body) as Map<String, dynamic>;
    if (data.isEmpty) {
      throw NotFoundFailure('Data not found at uri $uri');
    } else {
      return data;
    }
  }

  /// Shows information about a post
  /// Returns a map of each token to its associated PostInfo.
  Future<Map<String, PostInfo>> getPostInfo(
      {required String account,
      required String permlink,
      String? token}) async {
    final queryArgs = {
      'hive': '1',
    };
    if (token != null) {
      queryArgs['token'] = token;
    }
    final uri = Uri.https(_baseUrl, '/@$account/$permlink', queryArgs);
    final bodyJson = await _fetchData(uri);

    try {
      return bodyJson
          .map((key, value) => MapEntry(key, PostInfo.fromJson(value)));
    } catch (e, s) {
      print('Failed to parse $account - $permlink: $e');
      print(s);
      print('Failed data: $bodyJson');
      throw e;
    }
  }

  Future<TokenInfo> getTokenInfo(String token) async {
    final queryArgs = {'hive': '1', 'token': token};
    final uri = Uri.https(_baseUrl, '/info', queryArgs);
    final bodyJson = await _fetchData(uri);

    return TokenInfo.fromJson(bodyJson);
  }

  Future<TokenConfig> getConfig(String token) async {
    final queryArgs = {'hive': '1', 'token': token};
    final uri = Uri.https(_baseUrl, '/config', queryArgs);
    final bodyJson = await _fetchData(uri);

    return TokenConfig.fromJson(bodyJson);
  }

  // Future<Feed> getFeed({required String tag}) async {
  //   final queryArgs = {'hive': '1', 'tag': tag};
  //   final uri = Uri.https(_baseUrl, '/get_feed', queryArgs);
  //   final bodyJson = await _fetchData(uri);

  //   return Feed.fromJson(bodyJson);
  // }

  Future<List<Discussion>> getDiscussionsBy(
      {required DiscussionType discussionType,
      required String token,
      required String tag}) async {
    final discussionTypeStr = EnumToString.convertToString(discussionType);
    final queryArgs = {'token': token, 'tag': tag, 'hive': '1'};
    final uri = Uri.https(
        _baseUrl, '/get_discussions_by_${discussionTypeStr}', queryArgs);
    final bodyJson = await _fetchData(uri) as List;

    return bodyJson.map((e) => Discussion.fromJson(e)).toList();
  }
}

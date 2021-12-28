import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_local.dart';

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

  @override
  String toString() => 'NotFoundFailure: $message';
}

class ScotApiClient {
  static const _baseUrl = 'scot-api.hive-engine.com';
  final http.Client _httpClient;

  /// {@macro lightning_api_client}
  ScotApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client() {
    initializeDateFormatting('en-US');
  }

  Future<Map<String, Account>> getAccount(String accountName) async {
    final queryArgs = <String, String>{
      'hive': '1',
    };
    final uri = Uri.https(_baseUrl, '/@$accountName', queryArgs);
    print('scot_api.getAccount > $uri');
    final bodyJson = await _fetchData(uri);

    try {
      final account =
          bodyJson.map((key, value) => MapEntry(key, Account.fromJson(value)));
      print('Success scot getClient $accountName');
      return account;
    } catch (e, s) {
      print('Failed to parse $accountName: $e');
      print(s);
      print('Failed data: $bodyJson');
      throw e;
    }
  }

  Future<Account> getAccountForToken(String accountName,
      {required String token}) async {
    final queryArgs = <String, String>{
      'hive': '1',
    };
    queryArgs['token'] = token;
    final uri = Uri.https(_baseUrl, '/@$accountName', queryArgs);
    print('scot_api.getAccountForToken > $uri');
    final bodyJson = await _fetchData(uri);

    try {
      final account =
          bodyJson.map((key, value) => MapEntry(key, Account.fromJson(value)));
      print('Success scot getClient $accountName');
      return account[token]!;
    } catch (e, s) {
      print('Failed to parse $accountName: $e');
      print(s);
      print('Failed data: $bodyJson');
      throw e;
    }
  }

  Future<dynamic> _fetchData(Uri uri) async {
    final postResponse = await _httpClient.get(uri);

    if (postResponse.statusCode != 200) {
      throw ContentRequestFailure(statusCode: postResponse.statusCode);
    }

    final data = jsonDecode(postResponse.body);
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
    final queryArgs = <String, String>{
      'hive': '1',
    };
    if (token != null) {
      queryArgs['token'] = token;
    }
    final uri = Uri.https(_baseUrl, '/@$account/$permlink', queryArgs);
    final bodyJson = (await _fetchData(uri)) as Map<String, dynamic>;

    try {
      return bodyJson
          .map((key, value) => MapEntry(key, PostInfo.fromJson(value)));
    } catch (e, s) {
      print('Failed to parse @$account/$permlink: $e');
      print(s);
      print('Failed data: $bodyJson');
      throw e;
    }
  }

  Future<TokenInfo> getTokenInfo(String token) async {
    final queryArgs = <String, String>{'hive': '1', 'token': token};
    final uri = Uri.https(_baseUrl, '/info', queryArgs);
    final bodyJson = await _fetchData(uri);

    return TokenInfo.fromJson(bodyJson);
  }

  Future<TokenConfig> getConfig(String token) async {
    final queryArgs = <String, String>{'hive': '1', 'token': token};
    final uri = Uri.https(_baseUrl, '/config', queryArgs);
    final bodyJson = await _fetchData(uri);

    return TokenConfig.fromJson(bodyJson);
  }

  Future<List<PostInfo>> getFeed(
      {required String tag, required String token, required int limit}) async {
    final queryArgs = <String, String>{
      'hive': '1',
      'tag': tag,
      'token': token,
      'limit': limit.toString()
    };
    final uri = Uri.https(_baseUrl, '/get_feed', queryArgs);
    final bodyJson = await _fetchData(uri) as List;

    return bodyJson.map((d) => PostInfo.fromJson(d)).toList();
  }

  Future<List<Discussion>> getDiscussionsBy(DiscussionType discussionType,
      {required String token, required String tag, int? limit}) async {
    final discussionTypeStr = discussionType.name;
    final queryArgs = <String, String>{'token': token, 'tag': tag, 'hive': '1'};
    if (limit != null) {
      queryArgs['limit'] = limit.toString();
    }
    final uri = Uri.https(
        _baseUrl, '/get_discussions_by_${discussionTypeStr}', queryArgs);
    final bodyJson = await _fetchData(uri) as List;

    return bodyJson.map((e) => Discussion.fromJson(e)).toList();
  }
}

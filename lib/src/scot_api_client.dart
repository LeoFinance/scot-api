import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_local.dart';
import 'package:scot_api/scot_api.dart';

class ScotApiClient {
  /// {@macro scot_api_client}
  ScotApiClient({this.httpClient}) {
    initializeDateFormatting('en-US');
  }
  static const _baseUrl = 'scot-api.hive-engine.com';

  final http.Client? httpClient;

  Future<Map<String, Account>> getAccount(String accountName) async {
    final queryArgs = <String, String>{
      'hive': '1',
    };
    final uri = Uri.https(_baseUrl, '/@$accountName', queryArgs);
    final bodyJson = await _fetchData(uri) as Map<String, Map<String, dynamic>>;

    final account =
        bodyJson.map((key, value) => MapEntry(key, Account.fromJson(value)));
    return account;
  }

  Future<Account> getAccountForToken(
    String accountName, {
    required String token,
  }) async {
    final queryArgs = <String, String>{
      'hive': '1',
    };
    queryArgs['token'] = token;
    final uri = Uri.https(_baseUrl, '/@$accountName', queryArgs);
    final bodyJson = await _fetchData(uri) as Map<String, Map<String, dynamic>>;

    final account =
        bodyJson.map((key, value) => MapEntry(key, Account.fromJson(value)));
    return account[token]!;
  }

  Future<Map<String, dynamic>> _fetchData(Uri uri) async {
    final postResponse =
        await (httpClient != null ? httpClient!.get(uri) : http.get(uri));

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
  Future<Map<String, PostInfo>> getPostInfo({
    required String account,
    required String permlink,
    String? token,
  }) async {
    final queryArgs = <String, String>{
      'hive': '1',
    };
    if (token != null) {
      queryArgs['token'] = token;
    }
    final uri = Uri.https(_baseUrl, '/@$account/$permlink', queryArgs);
    final bodyJson = await _fetchData(uri);

    return bodyJson.map<String, PostInfo>(
      (key, dynamic value) =>
          MapEntry(key, PostInfo.fromJson(value as Map<String, dynamic>)),
    );
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

  Future<List<PostInfo>> getFeed({
    required String tag,
    required String token,
    required int limit,
  }) async {
    final queryArgs = <String, String>{
      'hive': '1',
      'tag': tag,
      'token': token,
      'limit': limit.toString()
    };
    final uri = Uri.https(_baseUrl, '/get_feed', queryArgs);
    final bodyJson = await _fetchData(uri) as List<Map<String, dynamic>>;

    return bodyJson.map(PostInfo.fromJson).toList();
  }

  Future<List<Discussion>> getDiscussionsBy(
    DiscussionType discussionType, {
    required String token,
    required String tag,
    int? limit,
  }) async {
    final discussionTypeStr = discussionType.name;
    final queryArgs = <String, String>{'token': token, 'tag': tag, 'hive': '1'};
    if (limit != null) {
      queryArgs['limit'] = limit.toString();
    }
    final uri = Uri.https(
      _baseUrl,
      '/get_discussions_by_$discussionTypeStr',
      queryArgs,
    );
    final bodyJson = await _fetchData(uri) as List<Map<String, dynamic>>;

    return bodyJson.map(Discussion.fromJson).toList();
  }
}

/// Exception thrown when getPost fails.
class ContentRequestFailure implements Exception {
  const ContentRequestFailure({required this.statusCode});

  final int statusCode;

  @override
  String toString() {
    return 'ContentRequestFailure: HTTP $statusCode received';
  }
}

/// Exception thrown when a resource cannot be found
class NotFoundFailure implements Exception {
  const NotFoundFailure(this.message);

  final String message;

  @override
  String toString() => 'NotFoundFailure: $message';
}

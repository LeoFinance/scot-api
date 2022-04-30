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
    final bodyJson = await _fetchData(uri) as Map<String, dynamic>;
    if (bodyJson.isEmpty) {
      throw const NotFoundFailure('Account not found');
    }

    return {
      for (final a in bodyJson.entries)
        a.key: Account.fromJson(a.value as Map<String, dynamic>)
    };
  }

  Future<Account> getAccountForToken(
    String accountName, {
    required String token,
  }) async {
    final queryArgs = <String, String>{'hive': '1', 'token': token};
    final uri = Uri.https(_baseUrl, '/@$accountName', queryArgs);
    final bodyJson = await _fetchData(uri) as Map<String, dynamic>;

    if (!bodyJson.containsKey(token)) {
      throw const NotFoundFailure('Token not found');
    }
    return Account.fromJson(bodyJson[token] as Map<String, dynamic>);
  }

  Future<dynamic> _fetchData(Uri uri) async {
    final postResponse =
        await (httpClient != null ? httpClient!.get(uri) : http.get(uri));

    if (postResponse.statusCode != 200) {
      throw ContentRequestFailure(statusCode: postResponse.statusCode);
    }

    return jsonDecode(postResponse.body) as Object;
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
    final bodyJson = await _fetchData(uri) as Map<String, dynamic>;
    if (bodyJson.isEmpty) {
      throw const NotFoundFailure('Post not found');
    }

    return {
      for (final a in bodyJson.entries)
        a.key: PostInfo.fromJson(a.value as Map<String, dynamic>)
    };
  }

  Future<TokenInfo> getTokenInfo(String token) async {
    final queryArgs = <String, String>{'hive': '1', 'token': token};
    final uri = Uri.https(_baseUrl, '/info', queryArgs);
    final bodyJson = await _fetchData(uri) as Map<String, dynamic>;

    return TokenInfo.fromJson(bodyJson);
  }

  Future<TokenConfig> getConfig(String token) async {
    final queryArgs = <String, String>{'hive': '1', 'token': token};
    final uri = Uri.https(_baseUrl, '/config', queryArgs);
    final bodyJson = await _fetchData(uri) as Map<String, dynamic>;

    return TokenConfig.fromJson(bodyJson);
  }

  Future<List<PostInfo>> getFeed({
    required String tag,
    required String token,
    int? limit,
  }) async {
    final queryArgs = <String, String>{
      'hive': '1',
      'tag': tag,
      'token': token,
    };
    if (limit != null) {
      queryArgs['limit'] = limit.toString();
    }
    final uri = Uri.https(_baseUrl, '/get_feed', queryArgs);
    final list = await _fetchData(uri) as List<dynamic>;

    return [for (final p in list) PostInfo.fromJson(p as Map<String, dynamic>)];
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
    final list = await _fetchData(uri) as List<dynamic>;

    return [
      for (final p in list) Discussion.fromJson(p as Map<String, dynamic>)
    ];
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

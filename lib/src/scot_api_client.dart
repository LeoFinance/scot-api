import 'dart:async';
import 'dart:convert';

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

/// Exception thrown when account is not found.
class AccountNotFoundFailure implements Exception {
  final String accountName;

  AccountNotFoundFailure({required this.accountName});

  @override
  String toString() => 'AccountNotFoundFailure: $accountName';
}

/// Exception thrown when token is not found.
class TokenNotFoundFailure implements Exception {
  final String token;

  TokenNotFoundFailure({required this.token});

  @override
  String toString() => 'TokenNotFoundFailure: $token';
}

/// Exception thrown when post is not found.
class PostNotFoundFailure implements Exception {
  final String account;
  final String permlink;

  PostNotFoundFailure({required this.account, required this.permlink});

  @override
  String toString() => 'PostNotFoundFailure: $account - $permlink';
}

class ScotApiClient {
  static const _baseUrl = 'scot-api.hive-engine.com';
  final http.Client _httpClient;

  /// {@macro lightning_api_client}
  ScotApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  Future<Map<String, AccountTokenData>> getAccount(
      {required String accountName, String? token}) async {
    final queryArgs = {
      'hive': '1',
    };
    if (token != null) {
      queryArgs['token'] = token;
    }
    final uri = Uri.https(_baseUrl, '/@$accountName', queryArgs);
    print('getAccount > $uri');

    final postResponse = await _httpClient.get(uri);

    if (postResponse.statusCode != 200) {
      throw ContentRequestFailure(statusCode: postResponse.statusCode);
    }

    final bodyJson = jsonDecode(postResponse.body) as Map<String, dynamic>;

    if (bodyJson.isEmpty) {
      throw AccountNotFoundFailure(accountName: accountName);
    }

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

    final postResponse = await _httpClient.get(uri);

    if (postResponse.statusCode != 200) {
      throw ContentRequestFailure(statusCode: postResponse.statusCode);
    }

    final bodyJson = jsonDecode(postResponse.body) as Map<String, dynamic>;

    if (bodyJson.isEmpty) {
      throw PostNotFoundFailure(account: account, permlink: permlink);
    }

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

    final postResponse = await _httpClient.get(uri);

    if (postResponse.statusCode != 200) {
      throw ContentRequestFailure(statusCode: postResponse.statusCode);
    }

    final bodyJson = jsonDecode(postResponse.body) as Map<String, dynamic>;

    if (bodyJson.isEmpty) {
      throw TokenNotFoundFailure(token: token);
    }

    return TokenInfo.fromJson(bodyJson);
  }
}

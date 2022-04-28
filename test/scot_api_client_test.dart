// ignore_for_file: prefer_const_constructors
import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:scot_api/scot_api.dart';
import 'package:test/test.dart';

import 'scot_api_client_test.mocks.dart';

@GenerateMocks([http.Client, http.Response, Uri])
void main() {
  group('ScotApiClient', () {
    late MockClient httpClient;
    late ScotApiClient scotApiClient;

    setUp(() {
      httpClient = MockClient();
      scotApiClient = ScotApiClient(httpClient: httpClient);
    });

    group('constructor', () {
      test('does not require an httpClient', () {
        expect(ScotApiClient(), isNotNull);
      });
    });

    group('getPostInfo', () {
      const author = 'cwow2';
      const permlink = 'selling-my-hive-goodbye';
      const token = 'LEO';
      final queryParams = {'hive': '1', 'token': token};
      final scotbotUri = Uri.https(
        'scot-api.hive-engine.com',
        '@$author/$permlink',
        queryParams,
      );

      test('throws ContentRequestFailure on non-200 response', () async {
        final response = MockResponse();
        when(response.statusCode).thenReturn(400);
        when(httpClient.get(scotbotUri)).thenAnswer((_) async => response);
        expect(
          scotApiClient.getPostInfo(
            account: author,
            permlink: permlink,
            token: token,
          ),
          throwsA(isA<ContentRequestFailure>()),
        );
      });

      test('throws PostNotFoundFailure on no data returned', () async {
        final response = MockResponse();
        when(response.statusCode).thenReturn(200);
        when(response.body).thenReturn(jsonEncode(<String, String>{}));
        when(httpClient.get(scotbotUri)).thenAnswer((_) async => response);
        expect(
          scotApiClient.getPostInfo(
            account: author,
            permlink: permlink,
            token: token,
          ),
          throwsA(isA<NotFoundFailure>()),
        );
      });

      test('returns Post on valid response', () async {
        final response = MockResponse();
        when(response.statusCode).thenReturn(200);
        when(response.body).thenReturn(
          await File('test/samples/post_info_by_token.json').readAsString(),
        );
        when(httpClient.get(scotbotUri)).thenAnswer((_) async => response);
        final actual = await scotApiClient.getPostInfo(
          account: author,
          permlink: permlink,
          token: token,
        );
        verify(
          httpClient.get(scotbotUri),
        ).called(1);

        expect(
          actual,
          isA<Map<String, PostInfo>>()
              .having((m) => m, 'map', hasLength(1))
              .having((m) => m.keys.first, 'token', 'LEO')
              .having(
                (m) => m.values.first,
                'value',
                isA<PostInfo>()
                    .having((p) => p.author, 'author', author)
                    .having(
                      (p) => p.authorperm,
                      'authorperm',
                      '@$author/$permlink',
                    )
                    .having(
                      (p) => p.activeVotes,
                      'activeVotes',
                      contains(
                        ActiveVote(
                          authorperm: '',
                          blockNum: 58733178,
                          percent: 2000,
                          revoted: null,
                          rshares: 0,
                          timestamp: DateTime.parse('2021-10-30T08:36:51Z'),
                          token: 'LEO',
                          voter: 'clockviper',
                          weight: 0,
                        ),
                      ),
                    ),
              ),
        );
      });
    });
  });
}

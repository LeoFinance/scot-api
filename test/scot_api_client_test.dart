// ignore_for_file: prefer_const_constructors
import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:faker/faker.dart';
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

    group('getAccount', () {
      final accountName = faker.internet.userName();

      test('returns Map<String, Account> on valid response', () async {
        final response = MockResponse();
        when(response.statusCode).thenReturn(200);
        when(response.body).thenReturn(
          await File('test/samples/get_account.json').readAsString(),
        );
        when(
          httpClient.get(
            any,
          ),
        ).thenAnswer((_) async => response);
        expect(
          await scotApiClient.getAccount(accountName),
          isA<Map<String, Account>>(),
        );
      });

      // test('throws NotFoundError if user not found', () async {
      //   final response = MockResponse();
      //   when(response.statusCode).thenReturn(200);
      //   when(response.body).thenReturn('{}');
      //   when(
      //     httpClient.get(
      //       any,
      //     ),
      //   ).thenAnswer((_) async => response);
      //   expect(scotApiClient.getAccount(accountName),
      //   throwsA(NotFoundFailure));
      // });
    });

    group('getAccountForToken', () {
      final accountName = faker.internet.userName();

      test('returns Account on valid response', () async {
        final response = MockResponse();
        when(response.statusCode).thenReturn(200);
        when(response.body).thenReturn(
          await File('test/samples/get_account.json').readAsString(),
        );
        when(
          httpClient.get(
            any,
          ),
        ).thenAnswer((_) async => response);
        expect(
          await scotApiClient.getAccountForToken(accountName, token: 'LEO'),
          isA<Account>(),
        );
      });

      // test('throws NotFoundError if user not found', () async {
      //   final response = MockResponse();
      //   when(response.statusCode).thenReturn(200);
      //   when(response.body)
      //       .thenReturn('test/samples/get_account_not_found.json');
      //   when(
      //     httpClient.get(
      //       any,
      //     ),
      //   ).thenAnswer((_) async => response);
      //   expect(scotApiClient.getAccount(accountName),
      //   throwsA(NotFoundFailure));
      // });
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

    group('getTokenInfo', () {
      final token = faker.currency.name();

      test('returns TokenInfo on valid response', () async {
        final response = MockResponse();
        when(response.statusCode).thenReturn(200);
        when(response.body).thenReturn(
          await File('test/samples/token_info.json').readAsString(),
        );
        when(
          httpClient.get(
            any,
          ),
        ).thenAnswer((_) async => response);
        expect(
          await scotApiClient.getTokenInfo(token),
          isA<TokenInfo>(),
        );
      });
    });

    group('getConfig', () {
      final token = faker.currency.name();

      test('returns TokenConfig on valid response', () async {
        final response = MockResponse();
        when(response.statusCode).thenReturn(200);
        when(response.body).thenReturn(
          await File('test/samples/token_config.json').readAsString(),
        );
        when(
          httpClient.get(
            any,
          ),
        ).thenAnswer((_) async => response);
        expect(
          await scotApiClient.getConfig(token),
          isA<TokenConfig>(),
        );
      });
    });

    group('getFeed', () {
      final tag = faker.lorem.word();
      final token = faker.currency.name();

      test('returns List<PostInfo> on valid response', () async {
        final response = MockResponse();
        when(response.statusCode).thenReturn(200);
        when(response.body).thenReturn(
          await File('test/samples/feed.json').readAsString(),
        );
        when(
          httpClient.get(
            any,
          ),
        ).thenAnswer((_) async => response);
        expect(
          await scotApiClient.getFeed(tag: tag, token: token),
          isA<List<PostInfo>>(),
        );
      });
    });

    group('getDiscussionsBy', () {
      final token = faker.currency.name();
      final tag = faker.lorem.word();

      test('returns List<Discussion> on valid response', () async {
        final response = MockResponse();
        when(response.statusCode).thenReturn(200);
        when(response.body).thenReturn(
          await File('test/samples/feed.json').readAsString(),
        );
        when(
          httpClient.get(
            any,
          ),
        ).thenAnswer((_) async => response);
        expect(
          await scotApiClient.getDiscussionsBy(
            DiscussionType.created,
            token: token,
            tag: tag,
          ),
          isA<List<Discussion>>(),
        );
      });
    });
  });
}

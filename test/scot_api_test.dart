import 'package:scot_api/scot_api.dart';
import 'dart:convert';
import 'dart:io';
import 'package:test/test.dart';

void main() {
  group('AccountTokenData', () {
    group('fromJson', () {
      test('decodes from JSON', () async {
        final json = await File('test/helpers/fake_account.json')
            .readAsString()
            .then(jsonDecode) as Map<String, dynamic>;

        expect(
            AccountTokenData.fromJson(json['LEO']!),
            isA<AccountTokenData>()
                .having((atd) => atd.symbol, 'symbol', 'LEO')
                .having((atd) => atd.stakedTokens, 'stakedTokens', 1007659));
      });
    });
  });

  group('PostInfo', () {
    group('fromJson', () {
      test('decodes from JSON', () async {
        final json = await File('test/helpers/fake_post_info.json')
            .readAsString()
            .then(jsonDecode) as Map<String, dynamic>;

        expect(
            PostInfo.fromJson(json['LEO']!),
            isA<PostInfo>()
                .having((p) => p.token, 'token', 'LEO')
                .having((p) => p.author, 'author', 'khaleelkazi')
                .having(
                    (p) => p.activeVotes.length, 'active_votes length', 680));
      });
    });
  });

  group('ActiveVote', () {
    group('fromJson', () {
      test('reads a single record from active_votes', () async {
        final json = (await File('test/helpers/fake_post_info.json')
            .readAsString()
            .then(jsonDecode))["LEO"]['active_votes'][0];

        expect(
            ActiveVote.fromJson(json),
            isA<ActiveVote>()
                .having((d) => d.voter, 'voter', 'adumbrate')
                .having((d) => d.timestamp, 'timestamp',
                    DateTime.parse('2021-10-24T21:19:06Z')));
      });
    });
  });

  group('TokenInfo', () {
    group('fromJson', () {
      test('reads TokenInfo', () async {
        final json = (await File('test/helpers/fake_token_info.json')
            .readAsString()
            .then(jsonDecode) as Map<String, dynamic>);
        expect(
            TokenInfo.fromJson(json),
            isA<TokenInfo>().having(
                (t) => t.pendingRshares, 'pendingRshares', 499140101733));
      });
    });
  });
}

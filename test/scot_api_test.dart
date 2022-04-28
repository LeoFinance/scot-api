import 'dart:convert';
import 'dart:io';

import 'package:scot_api/scot_api.dart';
import 'package:test/test.dart';

void main() {
  group('AccountTokenData', () {
    group('fromJson', () {
      test('decodes from JSON', () async {
        final s =
            await File('test/samples/account_token_data.json').readAsString();
        final json = jsonDecode(s) as Map<String, dynamic>;

        final leoAccount = json['LEO'] as Map<String, dynamic>;
        expect(
          Account.fromJson(leoAccount),
          isA<Account>()
              .having((atd) => atd.symbol, 'symbol', 'LEO')
              .having((atd) => atd.stakedTokens, 'stakedTokens', 1007659),
        );
      });
    });
  });

  group('PostInfo', () {
    group('fromJson', () {
      test('decodes from JSON', () async {
        final s = await File('test/samples/post_info.json').readAsString();
        final json = jsonDecode(s) as Map<String, dynamic>;

        expect(
          PostInfo.fromJson(json),
          isA<PostInfo>()
              .having((p) => p.token, 'token', 'LEO')
              .having((p) => p.author, 'author', 'cwow2')
              .having(
                (p) => p.activeVotes.length,
                'active_votes length',
                160,
              ),
        );
      });

      test('decodes from JSON if no active votes', () async {
        final s =
            await File('test/samples/post_info_non_leo.json').readAsString();
        final json = jsonDecode(s) as Map<String, dynamic>;

        expect(
          PostInfo.fromJson(json),
          isA<PostInfo>()
              .having((p) => p.activeVotes, 'active_votes', hasLength(0)),
        );
      });
    });
  });

  group('ActiveVote', () {
    group('fromJson', () {
      test('reads a single record from active_votes', () async {
        final s = await File('test/samples/post_info.json').readAsString();
        final postInfoJson = jsonDecode(s) as Map<String, dynamic>;
        final activeVoteJson =
            (postInfoJson['active_votes'] as List)[0] as Map<String, dynamic>;

        expect(
          ActiveVote.fromJson(activeVoteJson),
          isA<ActiveVote>()
              .having((d) => d.voter, 'voter', 'clockviper')
              .having(
                (d) => d.timestamp,
                'timestamp',
                DateTime.parse('2021-10-30T08:36:51Z'),
              ),
        );
      });
    });
  });

  group('TokenInfo', () {
    group('fromJson', () {
      test('reads TokenInfo', () async {
        final s = await File('test/samples/token_info.json').readAsString();
        final json = jsonDecode(s) as Map<String, dynamic>;
        expect(
          TokenInfo.fromJson(json),
          isA<TokenInfo>().having(
            (t) => t.pendingRshares,
            'pendingRshares',
            499140101733,
          ),
        );
      });
    });
  });
}

import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'account_token_data.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class AccountTokenData {
  static final DateFormat longDateTimeFormatter =
      DateFormat("EEE, dd MMM yyyy HH:mm:ss 'GMT'");

  static DateTime fromLongDateTime(String json) =>
      longDateTimeFormatter.parse(json);
  static String toLongDateTime(DateTime dateTime) =>
      longDateTimeFormatter.format(dateTime);

  static DateTime fromUTCDateTime(String json) => DateTime.parse(json + 'Z');
  static String toUTCDateTime(DateTime dateTime) =>
      dateTime.toIso8601String().replaceFirst('Z', '');

  final int downvotingPower;
  final int earnedToken;

  @JsonKey(fromJson: fromUTCDateTime, toJson: toUTCDateTime)
  final DateTime lastDownvoteTime;

  @JsonKey(fromJson: fromLongDateTime, toJson: toLongDateTime)
  final DateTime lastPost;
  @JsonKey(fromJson: fromLongDateTime, toJson: toLongDateTime)
  final DateTime lastRootPost;

  @JsonKey(fromJson: fromUTCDateTime, toJson: toUTCDateTime)
  final DateTime lastVoteTime;

  @JsonKey(fromJson: fromLongDateTime, toJson: toLongDateTime)
  final DateTime lastWonMiningClaim;

  @JsonKey(fromJson: fromLongDateTime, toJson: toLongDateTime)
  final DateTime lastWonStakingClaim;

  final bool muted;
  final String name;
  final int pendingToken;
  final double stakedMiningPower;
  final int stakedTokens;
  final String symbol;
  final int votingPower;

  final dynamic loki;

  AccountTokenData(
      {required this.downvotingPower,
      required this.earnedToken,
      required this.lastDownvoteTime,
      required this.lastPost,
      required this.lastRootPost,
      required this.lastVoteTime,
      required this.lastWonMiningClaim,
      required this.lastWonStakingClaim,
      required this.muted,
      required this.name,
      required this.pendingToken,
      required this.stakedMiningPower,
      required this.stakedTokens,
      required this.symbol,
      required this.votingPower,
      this.loki});

  factory AccountTokenData.fromJson(Map<String, dynamic> json) {
    try {
      return _$AccountTokenDataFromJson(json);
    } catch (e, s) {
      print('Failed parsing account $json');
      print(s);
      throw e;
    }
  }

  Map<String, dynamic> toJson() => _$AccountTokenDataToJson(this);
}

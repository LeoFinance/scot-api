import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'account.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Account extends Equatable {
  const Account({
    required this.downvotingPower,
    this.earnedMiningToken = 0,
    this.earnedOtherToken = 0,
    this.earnedStakingToken = 0,
    required this.earnedToken,
    required this.lastDownvoteTime,
    required this.lastPost,
    required this.lastRootPost,
    required this.lastVoteTime,
    required this.lastWonMiningClaim,
    required this.lastWonStakingClaim,
    required this.muted,
    required this.precision,
    required this.name,
    required this.pendingToken,
    required this.stakedMiningPower,
    required this.stakedTokens,
    required this.symbol,
    this.downvoteWeightMultiplier = 1.0,
    this.voteWeightMultiplier = 1.0,
    required this.votingPower,
    this.loki,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return _$AccountFromJson(json);
  }

  static final DateFormat longDateTimeFormatter =
      DateFormat("EEE, dd MMM yyyy HH:mm:ss 'GMT'");

  static DateTime fromLongDateTime(String json) =>
      longDateTimeFormatter.parseUtc(json);
  static String toLongDateTime(DateTime dateTime) =>
      longDateTimeFormatter.format(dateTime).replaceFirst('Z', '');

  static DateTime fromUTCDateTime(String json) => DateTime.parse('${json}Z');
  static String toUTCDateTime(DateTime dateTime) =>
      dateTime.toIso8601String().replaceFirst('Z', '');

  final int downvotingPower;
  final int earnedMiningToken;
  final int earnedOtherToken;
  final int earnedStakingToken;
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
  final int precision;
  final int stakedTokens;
  final String symbol;
  final int votingPower;
  final double downvoteWeightMultiplier;
  final double voteWeightMultiplier;

  final dynamic loki;

  @override
  List<Object?> get props => [
        name,
        symbol,
        votingPower,
        muted,
        downvotingPower,
        earnedMiningToken,
        earnedOtherToken,
        earnedStakingToken,
        earnedToken,
        lastDownvoteTime,
        lastPost,
        lastRootPost,
        lastVoteTime,
        lastWonMiningClaim,
        lastWonStakingClaim,
        pendingToken,
        precision,
        voteWeightMultiplier,
        stakedMiningPower,
        stakedTokens,
      ];

  static Account empty = Account(
    downvotingPower: 10000,
    earnedToken: 0,
    lastDownvoteTime: DateTime.utc(2019),
    lastPost: DateTime.utc(2019),
    lastRootPost: DateTime.utc(2019),
    lastVoteTime: DateTime.utc(2019),
    lastWonMiningClaim: DateTime.utc(2019),
    lastWonStakingClaim: DateTime.utc(2019),
    muted: false,
    name: '',
    pendingToken: 0,
    stakedMiningPower: 0,
    precision: 3,
    stakedTokens: 0,
    symbol: '',
    votingPower: 10000,
  );

  @visibleForTesting
  Account copyWith({String? name, String? symbol}) {
    return Account(
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
      votingPower: votingPower,
      muted: muted,
      downvotingPower: downvotingPower,
      earnedMiningToken: earnedMiningToken,
      earnedOtherToken: earnedOtherToken,
      earnedStakingToken: earnedStakingToken,
      earnedToken: earnedToken,
      lastDownvoteTime: lastDownvoteTime,
      lastPost: lastPost,
      lastRootPost: lastRootPost,
      lastVoteTime: lastVoteTime,
      lastWonMiningClaim: lastWonMiningClaim,
      lastWonStakingClaim: lastWonStakingClaim,
      pendingToken: pendingToken,
      precision: precision,
      voteWeightMultiplier: voteWeightMultiplier,
      stakedMiningPower: stakedMiningPower,
      stakedTokens: stakedTokens,
    );
  }

  Map<String, dynamic> toJson() => _$AccountToJson(this);

  @override
  bool get stringify => true;
}

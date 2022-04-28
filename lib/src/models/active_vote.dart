import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'active_vote.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ActiveVote extends Equatable {
  const ActiveVote({
    this.authorperm,
    required this.blockNum,
    required this.percent,
    required this.revoted,
    required this.rshares,
    required this.timestamp,
    required this.token,
    required this.voter,
    required this.weight,
  });

  factory ActiveVote.fromJson(Map<String, dynamic> json) =>
      _$ActiveVoteFromJson(json);

  static DateTime _toUTC(String json) {
    return DateTime.parse(json + (json.endsWith('Z') ? '' : 'Z'));
  }

  final String? authorperm;
  final int blockNum;
  final int percent;
  final dynamic revoted;
  final int rshares;
  @JsonKey(fromJson: _toUTC)
  final DateTime timestamp;
  final String token;
  final String voter;
  final int weight;

  @override
  List<Object> get props =>
      [blockNum, percent, rshares, timestamp, token, voter, weight];

  Map<String, dynamic> toJson() => _$ActiveVoteToJson(this);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_vote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActiveVote _$ActiveVoteFromJson(Map<String, dynamic> json) => ActiveVote(
      authorperm: json['authorperm'] as String?,
      blockNum: json['block_num'] as int,
      percent: json['percent'] as int,
      revoted: json['revoted'],
      rshares: json['rshares'] as int,
      timestamp: ActiveVote._toUTC(json['timestamp'] as String),
      token: json['token'] as String,
      voter: json['voter'] as String,
      weight: json['weight'] as int,
    );

Map<String, dynamic> _$ActiveVoteToJson(ActiveVote instance) =>
    <String, dynamic>{
      'authorperm': instance.authorperm,
      'block_num': instance.blockNum,
      'percent': instance.percent,
      'revoted': instance.revoted,
      'rshares': instance.rshares,
      'timestamp': instance.timestamp.toIso8601String(),
      'token': instance.token,
      'voter': instance.voter,
      'weight': instance.weight,
    };

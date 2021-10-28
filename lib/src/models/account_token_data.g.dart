// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_token_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountTokenData _$AccountTokenDataFromJson(Map<String, dynamic> json) =>
    AccountTokenData(
      downvotingPower: json['downvoting_power'] as int,
      earnedToken: json['earned_token'] as int,
      lastDownvoteTime: DateTime.parse(json['last_downvote_time'] as String),
      lastPost: AccountTokenData.fromLongDateTime(json['last_post'] as String),
      lastRootPost:
          AccountTokenData.fromLongDateTime(json['last_root_post'] as String),
      lastVoteTime: DateTime.parse(json['last_vote_time'] as String),
      lastWonMiningClaim: AccountTokenData.fromLongDateTime(
          json['last_won_mining_claim'] as String),
      lastWonStakingClaim: AccountTokenData.fromLongDateTime(
          json['last_won_staking_claim'] as String),
      muted: json['muted'] as bool,
      name: json['name'] as String,
      pendingToken: json['pending_token'] as int,
      stakedMiningPower: (json['staked_mining_power'] as num).toDouble(),
      stakedTokens: json['staked_tokens'] as int,
      symbol: json['symbol'] as String,
      votingPower: json['voting_power'] as int,
      loki: json['loki'],
    );

Map<String, dynamic> _$AccountTokenDataToJson(AccountTokenData instance) =>
    <String, dynamic>{
      'downvoting_power': instance.downvotingPower,
      'earned_token': instance.earnedToken,
      'last_downvote_time': instance.lastDownvoteTime.toIso8601String(),
      'last_post': AccountTokenData.toLongDateTime(instance.lastPost),
      'last_root_post': AccountTokenData.toLongDateTime(instance.lastRootPost),
      'last_vote_time': instance.lastVoteTime.toIso8601String(),
      'last_won_mining_claim':
          AccountTokenData.toLongDateTime(instance.lastWonMiningClaim),
      'last_won_staking_claim':
          AccountTokenData.toLongDateTime(instance.lastWonStakingClaim),
      'muted': instance.muted,
      'name': instance.name,
      'pending_token': instance.pendingToken,
      'staked_mining_power': instance.stakedMiningPower,
      'staked_tokens': instance.stakedTokens,
      'symbol': instance.symbol,
      'voting_power': instance.votingPower,
      'loki': instance.loki,
    };

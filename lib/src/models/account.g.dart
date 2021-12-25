// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
      downvotingPower: json['downvoting_power'] as int,
      earnedMiningToken: json['earned_mining_token'] as int? ?? 0,
      earnedOtherToken: json['earned_other_token'] as int? ?? 0,
      earnedStakingToken: json['earned_staking_token'] as int? ?? 0,
      earnedToken: json['earned_token'] as int,
      lastDownvoteTime:
          Account.fromUTCDateTime(json['last_downvote_time'] as String),
      lastPost: Account.fromLongDateTime(json['last_post'] as String),
      lastRootPost: Account.fromLongDateTime(json['last_root_post'] as String),
      lastVoteTime: Account.fromUTCDateTime(json['last_vote_time'] as String),
      lastWonMiningClaim:
          Account.fromLongDateTime(json['last_won_mining_claim'] as String),
      lastWonStakingClaim:
          Account.fromLongDateTime(json['last_won_staking_claim'] as String),
      muted: json['muted'] as bool,
      precision: json['precision'] as int,
      name: json['name'] as String,
      pendingToken: json['pending_token'] as int,
      stakedMiningPower: (json['staked_mining_power'] as num).toDouble(),
      stakedTokens: json['staked_tokens'] as int,
      symbol: json['symbol'] as String,
      downvoteWeightMultiplier:
          (json['downvote_weight_multiplier'] as num?)?.toDouble() ?? 1.0,
      voteWeightMultiplier:
          (json['vote_weight_multiplier'] as num?)?.toDouble() ?? 1.0,
      votingPower: json['voting_power'] as int,
      loki: json['loki'],
    );

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'downvoting_power': instance.downvotingPower,
      'earned_mining_token': instance.earnedMiningToken,
      'earned_other_token': instance.earnedOtherToken,
      'earned_staking_token': instance.earnedStakingToken,
      'earned_token': instance.earnedToken,
      'last_downvote_time': Account.toUTCDateTime(instance.lastDownvoteTime),
      'last_post': Account.toLongDateTime(instance.lastPost),
      'last_root_post': Account.toLongDateTime(instance.lastRootPost),
      'last_vote_time': Account.toUTCDateTime(instance.lastVoteTime),
      'last_won_mining_claim':
          Account.toLongDateTime(instance.lastWonMiningClaim),
      'last_won_staking_claim':
          Account.toLongDateTime(instance.lastWonStakingClaim),
      'muted': instance.muted,
      'name': instance.name,
      'pending_token': instance.pendingToken,
      'staked_mining_power': instance.stakedMiningPower,
      'precision': instance.precision,
      'staked_tokens': instance.stakedTokens,
      'symbol': instance.symbol,
      'voting_power': instance.votingPower,
      'downvote_weight_multiplier': instance.downvoteWeightMultiplier,
      'vote_weight_multiplier': instance.voteWeightMultiplier,
      'loki': instance.loki,
    };

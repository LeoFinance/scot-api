// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenInfo _$TokenInfoFromJson(Map<String, dynamic> json) => TokenInfo(
      claimedToken: json['claimed_token'] as int,
      commentPendingRshares: json['comment_pending_rshares'] as int,
      commentRewardPool: json['comment_reward_pool'] as int,
      enableAutomaticAccountClaim:
          json['enable_automatic_account_claim'] as bool,
      enableCommentRewardPool: json['enable_comment_reward_pool'] as bool,
      enabled: json['enabled'] as bool,
      enabledServices: json['enabled_services'] as String,
      hive: json['hive'] as bool,
      inflationTools: json['inflation_tools'] as int,
      issuedToken: json['issued_token'],
      issuer: json['issuer'] as String,
      lastComputePostRewardBlockNum:
          json['last_compute_post_reward_block_num'] as int,
      lastMiningClaimBlockNum: json['last_mining_claim_block_num'] as int,
      lastMiningClaimTrx: json['last_mining_claim_trx'] as String,
      lastOtherAccountsTransferBlockNum:
          json['last_other_accounts_transfer_block_num'] as int,
      lastProcessedMiningClaimBlockNum:
          json['last_processed_mining_claim_block_num'] as int,
      lastProcessedStakingClaimBlockNum:
          json['last_processed_staking_claim_block_num'] as int,
      lastReductionBlockNum: json['last_reduction_block_num'] as int,
      lastRewardBlockNum: json['last_reward_block_num'] as int,
      lastRshares2DecayTime: json['last_rshares2_decay_time'] as String,
      lastStakingClaimBlockNum: json['last_staking_claim_block_num'],
      lastStakingClaimTrx: json['last_staking_claim_trx'],
      lastStakingMiningUpdateBlockNum:
          json['last_staking_mining_update_block_num'] as int,
      miningEnabled: json['mining_enabled'] as bool,
      miningRewardPool: json['mining_reward_pool'] as int,
      nextMiningClaimNumber: json['next_mining_claim_number'] as int,
      nextStakingClaimNumber: json['next_staking_claim_number'] as int,
      otherRewardPool: json['other_reward_pool'] as int,
      pendingRshares: json['pending_rshares'] as int,
      pendingToken: json['pending_token'] as int,
      precision: json['precision'] as int,
      rewardPool: json['reward_pool'] as int,
      rewardsToken: json['rewards_token'] as int,
      setupComplete: json['setup_complete'] as int,
      stakedMiningPower: (json['staked_mining_power'] as num).toDouble(),
      stakedToken: json['staked_token'] as int,
      stakingEnabled: json['staking_enabled'] as bool,
      stakingRewardPool: json['staking_reward_pool'] as int,
      startBlockNum: json['start_block_num'] as int,
      startDate: json['start_date'] as String,
      symbol: json['symbol'] as String,
      totalGeneratedToken: json['total_generated_token'] as int,
      votingEnabled: json['voting_enabled'] as bool,
    );

Map<String, dynamic> _$TokenInfoToJson(TokenInfo instance) => <String, dynamic>{
      'claimed_token': instance.claimedToken,
      'comment_pending_rshares': instance.commentPendingRshares,
      'comment_reward_pool': instance.commentRewardPool,
      'enable_automatic_account_claim': instance.enableAutomaticAccountClaim,
      'enable_comment_reward_pool': instance.enableCommentRewardPool,
      'enabled': instance.enabled,
      'enabled_services': instance.enabledServices,
      'hive': instance.hive,
      'inflation_tools': instance.inflationTools,
      'issued_token': instance.issuedToken,
      'issuer': instance.issuer,
      'last_compute_post_reward_block_num':
          instance.lastComputePostRewardBlockNum,
      'last_mining_claim_block_num': instance.lastMiningClaimBlockNum,
      'last_mining_claim_trx': instance.lastMiningClaimTrx,
      'last_other_accounts_transfer_block_num':
          instance.lastOtherAccountsTransferBlockNum,
      'last_processed_mining_claim_block_num':
          instance.lastProcessedMiningClaimBlockNum,
      'last_processed_staking_claim_block_num':
          instance.lastProcessedStakingClaimBlockNum,
      'last_reduction_block_num': instance.lastReductionBlockNum,
      'last_reward_block_num': instance.lastRewardBlockNum,
      'last_rshares2_decay_time': instance.lastRshares2DecayTime,
      'last_staking_claim_block_num': instance.lastStakingClaimBlockNum,
      'last_staking_claim_trx': instance.lastStakingClaimTrx,
      'last_staking_mining_update_block_num':
          instance.lastStakingMiningUpdateBlockNum,
      'mining_enabled': instance.miningEnabled,
      'mining_reward_pool': instance.miningRewardPool,
      'next_mining_claim_number': instance.nextMiningClaimNumber,
      'next_staking_claim_number': instance.nextStakingClaimNumber,
      'other_reward_pool': instance.otherRewardPool,
      'pending_rshares': instance.pendingRshares,
      'pending_token': instance.pendingToken,
      'precision': instance.precision,
      'reward_pool': instance.rewardPool,
      'rewards_token': instance.rewardsToken,
      'setup_complete': instance.setupComplete,
      'staked_mining_power': instance.stakedMiningPower,
      'staked_token': instance.stakedToken,
      'staking_enabled': instance.stakingEnabled,
      'staking_reward_pool': instance.stakingRewardPool,
      'start_block_num': instance.startBlockNum,
      'start_date': instance.startDate,
      'symbol': instance.symbol,
      'total_generated_token': instance.totalGeneratedToken,
      'voting_enabled': instance.votingEnabled,
    };

import 'package:json_annotation/json_annotation.dart';

part 'token_info.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TokenInfo {
  TokenInfo({
    required this.claimedToken,
    required this.commentPendingRshares,
    required this.commentRewardPool,
    required this.enableAutomaticAccountClaim,
    required this.enableCommentRewardPool,
    required this.enabled,
    required this.enabledServices,
    required this.hive,
    required this.inflationTools,
    required this.issuedToken,
    required this.issuer,
    required this.lastComputePostRewardBlockNum,
    required this.lastMiningClaimBlockNum,
    required this.lastMiningClaimTrx,
    required this.lastOtherAccountsTransferBlockNum,
    required this.lastProcessedMiningClaimBlockNum,
    required this.lastProcessedStakingClaimBlockNum,
    required this.lastReductionBlockNum,
    required this.lastRewardBlockNum,
    required this.lastRshares2DecayTime,
    required this.lastStakingClaimBlockNum,
    required this.lastStakingClaimTrx,
    required this.lastStakingMiningUpdateBlockNum,
    required this.miningEnabled,
    required this.miningRewardPool,
    required this.nextMiningClaimNumber,
    required this.nextStakingClaimNumber,
    required this.otherRewardPool,
    required this.pendingRshares,
    required this.pendingToken,
    required this.precision,
    required this.rewardPool,
    required this.rewardsToken,
    required this.setupComplete,
    required this.stakedMiningPower,
    required this.stakedToken,
    required this.stakingEnabled,
    required this.stakingRewardPool,
    required this.startBlockNum,
    required this.startDate,
    required this.symbol,
    required this.totalGeneratedToken,
    required this.votingEnabled,
  });

  final int claimedToken;
  final int commentPendingRshares;
  final int commentRewardPool;
  final bool enableAutomaticAccountClaim;
  final bool enableCommentRewardPool;
  final bool enabled;
  final String enabledServices;
  final bool hive;
  final int inflationTools;
  final dynamic issuedToken;
  final String issuer;
  final int lastComputePostRewardBlockNum;
  final int lastMiningClaimBlockNum;
  final String lastMiningClaimTrx;
  final int lastOtherAccountsTransferBlockNum;
  final int lastProcessedMiningClaimBlockNum;
  final int lastProcessedStakingClaimBlockNum;
  final int lastReductionBlockNum;
  final int lastRewardBlockNum;
  final String lastRshares2DecayTime;
  final dynamic lastStakingClaimBlockNum;
  final dynamic lastStakingClaimTrx;
  final int lastStakingMiningUpdateBlockNum;
  final bool miningEnabled;
  final int miningRewardPool;
  final int nextMiningClaimNumber;
  final int nextStakingClaimNumber;
  final int otherRewardPool;
  final int pendingRshares;
  final int pendingToken;
  final int precision;
  final int rewardPool;
  final int rewardsToken;
  final int setupComplete;
  final double stakedMiningPower;
  final int stakedToken;
  final bool stakingEnabled;
  final int stakingRewardPool;
  final int startBlockNum;
  final String startDate;
  final String symbol;
  final int totalGeneratedToken;
  final bool votingEnabled;

  factory TokenInfo.fromJson(Map<String, dynamic> json) =>
      _$TokenInfoFromJson(json);

  Map<String, dynamic> toJson() => _$TokenInfoToJson(this);
}

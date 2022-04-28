import 'package:json_annotation/json_annotation.dart';

part 'token_config.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class TokenConfig {
  const TokenConfig({
    required this.allowlistAccount,
    required this.authorCurveExponent,
    required this.authorRewardPercentage,
    required this.badgeFee,
    required this.beneficiariesAccount,
    required this.beneficiariesRewardPercentage,
    required this.cashoutWindowDays,
    required this.curationCurveExponent,
    required this.disableDownvoting,
    required this.downvotePowerConsumption,
    required this.downvoteRegenerationSeconds,
    required this.downvoteWindowDays,
    required this.enableAccountAllowlist,
    required this.enableAccountMuting,
    required this.enableCommentBeneficiaries,
    required this.excludeApps,
    required this.excludeAppsFromTokenBeneficiary,
    required this.excludeBeneficiariesAccounts,
    required this.excludeTags,
    required this.feePostAccount,
    required this.feePostAmount,
    required this.feePostExemptBeneficiaryAccount,
    required this.feePostExemptBeneficiaryWeight,
    required this.hiveCommunity,
    required this.hiveEnabled,
    required this.hiveEngineEnabled,
    required this.issueToken,
    required this.jsonMetadataAppValue,
    required this.jsonMetadataKey,
    required this.jsonMetadataValue,
    required this.maxAutoClaimAmount,
    required this.minerTokens,
    required this.miningPoolClaimNumber,
    required this.miningPoolClaimsPerYear,
    required this.mutingAccount,
    required this.nDailyPostsMutedAccounts,
    required this.otherPoolAccounts,
    required this.otherPoolPercentage,
    required this.otherPoolSendTokenPerYear,
    required this.pobCommentPoolPercentage,
    required this.pobPoolPercentage,
    required this.posmPoolPercentage,
    required this.postRewardCurve,
    required this.postRewardCurveParameter,
    required this.promotedPostAccount,
    required this.reductionEveryNBlock,
    required this.reductionPercentage,
    required this.rewardsToken,
    required this.rewardsTokenEveryNBlock,
    required this.stakedRewardPercentage,
    required this.stakingPoolClaimNumber,
    required this.stakingPoolClaimsPerYear,
    required this.stakingPoolPercentage,
    required this.steemEnabled,
    required this.steemEngineEnabled,
    required this.tagAddingWindowHours,
    required this.token,
    required this.tokenAccount,
    required this.useStakingCirculatingQuotent,
    required this.votePowerConsumption,
    required this.voteRegenerationSeconds,
    required this.voteWindowDays,
  });

  factory TokenConfig.fromJson(Map<String, dynamic> json) =>
      _$TokenConfigFromJson(json);

  final dynamic allowlistAccount;
  final double authorCurveExponent;
  final double authorRewardPercentage;
  final double badgeFee;
  final String beneficiariesAccount;
  final double beneficiariesRewardPercentage;
  final double cashoutWindowDays;
  final double curationCurveExponent;
  final bool disableDownvoting;
  final int downvotePowerConsumption;
  final int downvoteRegenerationSeconds;
  final int downvoteWindowDays;
  final dynamic enableAccountAllowlist;
  final bool enableAccountMuting;
  final bool enableCommentBeneficiaries;
  final dynamic excludeApps;
  final String excludeAppsFromTokenBeneficiary;
  final String excludeBeneficiariesAccounts;
  final String excludeTags;
  final dynamic feePostAccount;
  final int feePostAmount;
  final dynamic feePostExemptBeneficiaryAccount;
  final int feePostExemptBeneficiaryWeight;
  final String hiveCommunity;
  final bool hiveEnabled;
  final bool hiveEngineEnabled;
  final bool issueToken;
  final dynamic jsonMetadataAppValue;
  final String jsonMetadataKey;
  final String jsonMetadataValue;
  final double maxAutoClaimAmount;
  final String minerTokens;
  final int miningPoolClaimNumber;
  final int miningPoolClaimsPerYear;
  final String mutingAccount;
  final int nDailyPostsMutedAccounts;
  final String otherPoolAccounts;
  final double otherPoolPercentage;
  final int otherPoolSendTokenPerYear;
  final double pobCommentPoolPercentage;
  final double pobPoolPercentage;
  final double posmPoolPercentage;
  final String postRewardCurve;
  final dynamic postRewardCurveParameter;
  final String promotedPostAccount;
  final int reductionEveryNBlock;
  final double reductionPercentage;
  final double rewardsToken;
  final int rewardsTokenEveryNBlock;
  final double stakedRewardPercentage;
  final int stakingPoolClaimNumber;
  final int stakingPoolClaimsPerYear;
  final double stakingPoolPercentage;
  final bool steemEnabled;
  final bool steemEngineEnabled;
  final double tagAddingWindowHours;
  final String token;
  final String tokenAccount;
  final bool useStakingCirculatingQuotent;
  final int votePowerConsumption;
  final int voteRegenerationSeconds;
  final int voteWindowDays;

  Map<String, dynamic> toJson() => _$TokenConfigToJson(this);
}

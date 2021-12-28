import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'models.dart';

part 'post_info.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class PostInfo extends Equatable {
  PostInfo({
    required this.activeVotes,
    required this.app,
    required this.author,
    required this.authorCurveExponent,
    required this.authorPayoutBeneficiaries,
    required this.authorperm,
    required this.beneficiariesPayoutValue,
    required this.block,
    required this.cashoutTime,
    required this.children,
    required this.created,
    required this.curatorPayoutValue,
    required this.declinePayout,
    required this.desc,
    required this.hive,
    required this.jsonMetadata,
    required this.lastPayout,
    required this.lastUpdate,
    required this.mainPost,
    required this.muted,
    required this.parentAuthor,
    required this.parentPermlink,
    required this.pendingToken,
    required this.precision,
    required this.promoted,
    required this.scoreHot,
    required this.scorePromoted,
    required this.scoreTrend,
    required this.tags,
    required this.title,
    required this.token,
    required this.totalPayoutValue,
    required this.totalVoteWeight,
    required this.voteRshares,
  });

  final List<ActiveVote> activeVotes;
  final String? app;
  final String author;
  final double authorCurveExponent;
  final String authorPayoutBeneficiaries;
  final String authorperm;
  final int beneficiariesPayoutValue;
  final int block;
  final DateTime cashoutTime;
  final int children;
  final DateTime created;
  final int curatorPayoutValue;
  final bool declinePayout;
  final String desc;
  final bool hive;
  final String jsonMetadata;
  final DateTime lastPayout;
  final DateTime lastUpdate;
  final bool mainPost;
  final bool muted;
  final String parentAuthor;
  final String parentPermlink;
  final int pendingToken;
  final int precision;
  final int promoted;
  final double scoreHot;
  final double scorePromoted;
  final double scoreTrend;
  final String tags;
  final String title;
  final String token;
  final int totalPayoutValue;
  final int totalVoteWeight;
  final int voteRshares;

  @override
  List<Object?> get props => [
        activeVotes,
        app,
        author,
        authorCurveExponent,
        authorPayoutBeneficiaries,
        authorperm,
        beneficiariesPayoutValue,
        block,
        cashoutTime,
        children,
        created,
        curatorPayoutValue,
        declinePayout,
        desc,
        hive,
        jsonMetadata,
        lastPayout,
        mainPost,
        muted,
        parentAuthor,
        parentPermlink,
        pendingToken,
        precision,
        promoted,
        scoreHot,
        scorePromoted,
        scoreTrend,
        tags,
        title,
        token,
        totalPayoutValue,
        totalVoteWeight,
        voteRshares
      ];

  factory PostInfo.fromJson(Map<String, dynamic> json) =>
      _$PostInfoFromJson(json);

  Map<String, dynamic> toJson() => _$PostInfoToJson(this);

  @override
  bool get stringify => true;
}

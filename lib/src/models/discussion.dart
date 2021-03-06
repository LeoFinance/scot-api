import 'package:json_annotation/json_annotation.dart';
import 'package:scot_api/src/models/models.dart';

part 'discussion.g.dart';

enum DiscussionType {
  created,
  trending,
  promoted,
  hot,
  blog,
  comments,
  replies
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Discussion {
  const Discussion({
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
    required this.permlink,
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

  factory Discussion.fromJson(Map<String, dynamic> json) =>
      _$DiscussionFromJson(json);

  static final DateTime _emptyDateTime = DateTime(1970);
  static final Discussion empty = Discussion(
    activeVotes: [],
    app: '',
    author: '',
    authorCurveExponent: 0,
    authorPayoutBeneficiaries: '',
    authorperm: '',
    beneficiariesPayoutValue: 0,
    block: 0,
    cashoutTime: _emptyDateTime,
    children: 0,
    created: _emptyDateTime,
    curatorPayoutValue: 0,
    declinePayout: false,
    desc: '',
    hive: true,
    jsonMetadata: '',
    lastPayout: _emptyDateTime,
    lastUpdate: _emptyDateTime,
    mainPost: false,
    muted: false,
    parentAuthor: '',
    parentPermlink: '',
    pendingToken: 0,
    permlink: '',
    precision: 0,
    promoted: 0,
    scoreHot: 0,
    scorePromoted: 0,
    scoreTrend: 0,
    tags: '',
    title: '',
    token: '',
    totalPayoutValue: 0,
    totalVoteWeight: 0,
    voteRshares: 0,
  );

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
  final String permlink;
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

  Map<String, dynamic> toJson() => _$DiscussionToJson(this);

  @override
  String toString() => 'tribe.Discussion @$author/$permlink';
}

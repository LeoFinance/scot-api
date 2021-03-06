## 0.1.0

- First public release.

## 0.1.1

- Fix type cast errors

## 0.2.0

- `getAccountForToken` renamed to `getAccountForSymbol`
- Added `Account.empty`
- `getAccount` and `getAccountForSymbol` no longer throw `NotFoundFailure`.
  Instead, they simply return what is returned by scot-api.
  This means `getAccount` returns an empty Map and `getAccountForSymbol`
  returns an object like `Account.empty` except the `name` and `symbol` fields
  are set.

## 0.2.1

- `gePostInfo` returns an empty Map if not found

## 0.3.0

- Add Discussion.empty

## 0.4.0

- Add ActiveVote.empty

## 0.4.1

- PostInfo.authorPayoutBeneficiaries can be null
- PostInfo.parentAuthor and parentPermlink can be null

## 0.4.2

- Add 'comments' and 'replies' to allowed DiscussionTypes

## 0.4.3

- Add maxConnections parameter to client to throttle the number of parallel 
  connections
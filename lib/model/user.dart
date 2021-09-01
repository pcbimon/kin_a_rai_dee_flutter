/// `food` table name
final String tableUser = 'user';

final String columnUserId = 'id';
final String columnUserName = 'foodName';
final String columnTokenId = 'tokenId';

class User {
  int? id;
  final String userName;
  final String tokenId;
  User(this.id, this.userName, this.tokenId);
  User.fromMap(Map map)
      : this.id = map[columnUserId] as int?,
        this.userName = map[columnUserName] as String,
        this.tokenId = map[columnTokenId] as String;

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      columnUserName: userName,
      columnTokenId: tokenId
    };
    if (id != null) {
      map[columnUserId] = id;
    }
    return map;
  }
}

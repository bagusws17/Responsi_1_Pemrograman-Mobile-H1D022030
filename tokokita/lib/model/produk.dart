class Produk {
  int? id;
  String? account;
  int? balance; // Change this line
  String? status;
  Produk({this.id, this.account, this.balance, this.status});
  factory Produk.fromJson(Map<String, dynamic> obj) {
    return Produk(
        id: obj['id'],
        account: obj['account'],
        balance: obj['balance'],
        status: obj['status']);
  }
}
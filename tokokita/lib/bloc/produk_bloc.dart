import 'dart:convert';
import 'package:responsi1/helpers/api.dart';
import 'package:responsi1/helpers/api_url.dart';
import 'package:responsi1/model/produk.dart';

class ProdukBloc {
  static Future<List<Produk>> getProduks() async {
    String apiUrl = ApiUrl.listProduk;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listProduk = (jsonObj as Map<String, dynamic>)['data'];
    List<Produk> produks = [];
    for (int i = 0; i < listProduk.length; i++) {
      produks.add(Produk.fromJson(listProduk[i]));
    }
    return produks;
  }

  static Future<Map<String, dynamic>> addProduk({Produk? produk}) async {
    String apiUrl = ApiUrl.createProduk;
    var body = {
      "account": produk!.account,
      "balance": produk.balance.toString(),
      "status": produk.status
    };
    try {
      var response = await Api().post(apiUrl, body);
      var jsonObj = json.decode(response.body);
      return {
        'status': jsonObj['status'],
        'message': jsonObj['message'] ?? 'Account sudah ada',
        'data': jsonObj['data']
      };
    } catch (e) {
      return {
        'status': false,
        'message': 'Terjadi kesalahan: ${e.toString()}',
      };
    }
  }

  static Future updateProduk({required Produk produk}) async {
    String apiUrl = ApiUrl.updateProduk(produk.id!);
    print(apiUrl);
    var body = {
      "account": produk.account,
      "balance": produk.balance.toString(),
      "status": produk.status
    };
    print("Body : $body");
    var response = await Api().put(apiUrl, jsonEncode(body));
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> deleteProduk({int? id}) async {
    String apiUrl = ApiUrl.deleteProduk(id!);
    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['data'];
  }
}
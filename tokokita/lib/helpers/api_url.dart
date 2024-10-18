class ApiUrl {
  static const String baseUrl = 'http://responsi.webwizards.my.id/api';
  static const String registrasi = baseUrl + '/registrasi';
  static const String login = baseUrl + '/login';
  static const String listProduk = baseUrl + '/keuangan/saldo';
  static const String createProduk = baseUrl + '/keuangan/saldo';

  static String updateProduk(int id) {
    return baseUrl + '/keuangan/saldo/' + id.toString() + '/update';
  }

  static String showProduk(int id) {
    return baseUrl + '/keuangan/saldo/' + id.toString();
  }

  static String deleteProduk(int id) {
    return baseUrl + '/keuangan/saldo/' + id.toString()  + '/delete';
  }
}

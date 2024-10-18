import 'package:flutter/material.dart';
import 'package:responsi1/bloc/produk_bloc.dart';
import 'package:responsi1/model/produk.dart';
import 'package:responsi1/ui/produk_page.dart';
import 'package:responsi1/widget/success_dialog.dart';
import 'package:responsi1/widget/warning_dialog.dart';

// ignore: must_be_immutable
class ProdukForm extends StatefulWidget {
  Produk? produk;
  ProdukForm({Key? key, this.produk}) : super(key: key);
  @override
  _ProdukFormState createState() => _ProdukFormState();
}

class _ProdukFormState extends State<ProdukForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH ACCOUNT";
  String tombolSubmit = "SIMPAN";
  final _accountTextboxController = TextEditingController();
  final _balanceTextboxController = TextEditingController();
  final _statusTextboxController = TextEditingController();
  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.produk != null) {
      setState(() {
        judul = "UBAH ACCOUNT";
        tombolSubmit = "UBAH";
        _accountTextboxController.text = widget.produk!.account!;
        _balanceTextboxController.text = widget.produk!.balance.toString();
        _statusTextboxController.text = widget.produk!.status!;
      });
    } else {
      judul = "TAMBAH ACCOUNT";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(judul)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _accountTextField(),
                _balanceTextField(),
                _statusTextField(),
                _buttonSubmit()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _accountTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Account"),
      keyboardType: TextInputType.text,
      controller: _accountTextboxController,
      style: const TextStyle(color: Colors.white),
      validator: (value) {
        if (value!.isEmpty) {
          return "Account harus diisi";
        }
        return null;
      },
    );
  }

  Widget _balanceTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Balance"),
      keyboardType: TextInputType.number,
      controller: _balanceTextboxController,
      style: const TextStyle(color: Colors.white),
      validator: (value) {
        if (value!.isEmpty) {
          return "Balance harus diisi";
        }
        return null;
      },
    );
  }

  Widget _statusTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Status"),
      keyboardType: TextInputType.text,
      controller: _statusTextboxController,
      style: const TextStyle(color: Colors.white),
      validator: (value) {
        if (value!.isEmpty) {
          return "Status harus diisi";
        }
        return null;
      },
    );
  }

  Widget _buttonSubmit() {
    return OutlinedButton(
        child: Text(tombolSubmit),
        onPressed: () {
          var validate = _formKey.currentState!.validate();
          if (validate) {
            if (!_isLoading) {
              if (widget.produk != null) {
                ubah();
              } else {
                simpan();
              }
            }
          }
        });
  }

  simpan() {
    setState(() {
      _isLoading = true;
    });
    Produk createProduk = Produk(id: null);
    createProduk.account = _accountTextboxController.text;
    createProduk.balance = int.parse(_balanceTextboxController.text);
    createProduk.status = _statusTextboxController.text;
    ProdukBloc.addProduk(produk: createProduk).then((value) {
      if (value['status']) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => SuccessDialog(
            description: "Account berhasil ditambahkan",
            okClick: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) => const ProdukPage(),
                ),
              );
            },
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) => WarningDialog(
            description: value['message'],
          ),
        );
      }
    }).catchError((error) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "Simpan gagal, silahkan coba lagi",
        ),
      );
    }).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });
  }

  ubah() {
    setState(() {
      _isLoading = true;
    });
    Produk updateProduk = Produk(id: widget.produk!.id!);
    updateProduk.account = _accountTextboxController.text;
    updateProduk.balance = int.parse(_balanceTextboxController.text);
    updateProduk.status = _statusTextboxController.text;
    ProdukBloc.updateProduk(produk: updateProduk).then((value) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => SuccessDialog(
          description: "Account berhasil diubah",
          okClick: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => const ProdukPage(),
              ),
            );
          },
        ),
      );
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
            description: "Permintaan ubah data gagal, silahkan coba lagi",
          ));
    });
    setState(() {
      _isLoading = false;
    });
  }
}
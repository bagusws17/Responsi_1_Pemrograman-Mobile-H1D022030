<?php

namespace App\Controllers;

use App\Models\MProduk;

class SaldoController extends RestfulController
{
    public function create()
    {
        $data = [
            'account' => $this->request->getVar('account'),
            'balance' => $this->request->getVar('balance'),
            'status' => $this->request->getVar('status')
        ];
        $model = new MProduk();
        $model->insert($data);
        $saldo = $model->find($model->getInsertID());
        return $this->responseHasil( 200, true , $saldo);
    }

    public function list()
    {
        $model = new MProduk();
        $saldo = $model->findAll();
        return $this->responseHasil(200, true, $saldo); 
    }

    public function detail($id)
    {
        $model = new MProduk();
        $saldo = $model->find($id);
        return $this->responseHasil(200, true, $saldo);
    }

    public function ubah($id)
    {
        $data = [
            'account' => $this->request->getVar('kode_produk'),
            'balance' => $this->request->getVar('nama_produk'),
            'status' => $this->request->getVar('status')
        ];
        $model = new MProduk();
        $model->update($id, $data);
        $saldo = $model->find($id);
        return $this->responseHasil(200, true, $saldo); 
    }

    public function hapus($id)
    {
        $model = new MProduk();
        $saldo = $model->delete($id);
        return $this->responseHasil(200, true, $saldo); 
    }
}
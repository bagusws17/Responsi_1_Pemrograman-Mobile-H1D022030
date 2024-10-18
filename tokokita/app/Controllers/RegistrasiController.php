<?php

namespace App\Controllers;

use App\Models\Mregistrasi;

class RegistrasiController extends RestfulController
{
    public function registrasi()
    {
        $data = [
            'nama' => $this->request->getVar('nama'),
            'email' => $this->request->getVar('email'),
            'password' => password_hash($this->request->getVar('password'), PASSWORD_DEFAULT)
        ];

        $model = new Mregistrasi();
        $model->save($data);
        return $this->responseHasil(200, true, "Registrasi Berhasil");
    }
}
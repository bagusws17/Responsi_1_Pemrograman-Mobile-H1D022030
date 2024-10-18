<?php

namespace App\Models;

use CodeIgniter\Model;

class Mregistrasi extends Model
{
    protected $table = 'member';
    protected $allowedFields = ['nama', 'email', 'password'];
}
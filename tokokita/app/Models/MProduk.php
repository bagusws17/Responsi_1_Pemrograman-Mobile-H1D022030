<?php

namespace App\Models;

use CodeIgniter\Model;

class MProduk extends Model
{
    protected $table = 'saldo';
    protected $primaryKey = 'id';
    protected $allowedFields = ['account', 'balance', 'status'];
}
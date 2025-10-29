<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Receipt extends Model
{
    protected $fillable = [
        'order_id',
        'print_format',
        'html_snapshot',
        'wa_url',
        'printed_by',
        'printed_at',
        'reprint_of_id',
    ];

    protected $casts = [
        'print_format' => 'integer',
        'printed_at'   => 'datetime',
    ];

    public function order()
    {
        return $this->belongsTo(Order::class);
    }
    public function printer()
    {
        return $this->belongsTo(User::class, 'printed_by');
    }
    public function parent()
    {
        return $this->belongsTo(Receipt::class, 'reprint_of_id');
    }
}

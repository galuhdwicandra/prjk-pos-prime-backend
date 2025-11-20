<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class OrderChangeLog extends Model
{
    protected $fillable = ['order_id', 'actor_id', 'action', 'diff_json', 'note', 'occurred_at'];
    protected $casts = ['diff_json' => 'array', 'occurred_at' => 'datetime'];
    public function order()
    {
        return $this->belongsTo(Order::class);
    }
    public function actor()
    {
        return $this->belongsTo(User::class, 'actor_id');
    }
}

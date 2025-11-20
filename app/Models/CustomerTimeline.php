<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class CustomerTimeline extends Model
{
    protected $table = 'customer_timelines';

    protected $fillable = [
        'customer_id',
        'event_type',
        'title',
        'note',
        'meta',
        'happened_at',
    ];

    protected $casts = [
        'meta'        => 'array',
        'happened_at' => 'datetime',
    ];
}

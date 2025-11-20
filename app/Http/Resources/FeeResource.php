<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class FeeResource extends JsonResource
{
    public function toArray($request)
    {
        return [
            'id'         => $this->id,
            'cabang_id'  => $this->cabang_id,
            'name'       => $this->name,
            'kind'       => $this->kind,
            'calc_type'  => $this->calc_type,
            'rate'       => (float) $this->rate,
            'base'       => $this->base,
            'is_active'  => (bool) $this->is_active,
            'created_at' => optional($this->created_at)->toISOString(),
            'updated_at' => optional($this->updated_at)->toISOString(),
        ];
    }
}

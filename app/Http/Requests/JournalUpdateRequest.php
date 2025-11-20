<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class JournalUpdateRequest extends FormRequest
{
    public function rules(): array
    {
        return (new JournalStoreRequest())->rules();
    }
}

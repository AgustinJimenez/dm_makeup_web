<?php
    $columns = array("FECHA", "LUGAR", "USUARIO", "ESTADO", "ACCIONES");
?>
<div class="table-responsive">
    <table class="data-table table table-bordered table-striped table-hover">
        <thead class="bg-primary">
            <tr>
                @foreach ($columns as $column)
                    <th>{{ $column }}</th>
                @endforeach
            </tr>
        </thead>
        <tbody>
        </tbody>
        <tfoot class="bg-primary">
            <tr>
                @foreach ($columns as $column)
                    <th>{{ $column }}</th>
                @endforeach
            </tr>
        </tfoot>
    </table>
</div>
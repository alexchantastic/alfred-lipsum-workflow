<?php
$length = $argv[1];
$number = $argv[2];

exec("curl http://loripsum.net/api/plaintext/" . $length . "/" . $number . "/", $data);

$data = implode("\n", $data);

$data = rtrim($data);

echo $data;

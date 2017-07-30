<?php
include_once('lib/LoremIpsum.php');

$lipsum = new joshtronic\LoremIpsum();

$type = $argv[1];
$length = $argv[2];

if (!$length) {
  $length = 1;
}

if ($type === 'words') {
  echo ucfirst($lipsum->words($length));
}
elseif ($type === 'sentences') {
  echo ucfirst($lipsum->sentences($length));
}
elseif ($type === 'paragraphs') {
  echo ucfirst($lipsum->paragraphs($length));
}

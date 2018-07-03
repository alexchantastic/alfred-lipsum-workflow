<?php
include_once('lib/LoremIpsum.php');

$lipsum = new joshtronic\LoremIpsum();

$type = $argv[1];
$length = $argv[2];

$length = $length ? $length : 1;

/**
 * Characters
 *
 * Generates characters of lorem ipsum.
 *
 * @param  integer $count how many characters to generate
 * @return string generated lorem ipsum characters
 */
function characters($count) {
  global $lipsum;

  $character_count = 0;
  $words_array = array();

  while ($character_count < $count) {
    $word = $lipsum->word();
    $word_length = strlen($word);

    $character_count += $word_length + count($words_array);

    array_push($words_array, $word);  
  }

  $words = implode(' ', $words_array);
  $words = substr($words, 0, $count);

  $last_character = substr($words, -1);

  if ($last_character === ' ') {
    $words = substr($words, 0, -1) . substr($lipsum->word(), 0, 1);
  }

  return $words;
}

if ($type === 'characters') {
  echo ucfirst(characters($length));
}
elseif ($type === 'words') {
  echo ucfirst($lipsum->words($length));
}
elseif ($type === 'sentences') {
  echo ucfirst($lipsum->sentences($length));
}
elseif ($type === 'paragraphs') {
  echo ucfirst($lipsum->paragraphs($length));
}

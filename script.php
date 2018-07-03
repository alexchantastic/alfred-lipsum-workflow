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
  $words_count = 0;
  $words_array = array();

  while ($character_count < $count) {
    $word = $lipsum->word();
    $word_length = strlen($word);

    if ($word !== $words_array[$words_count - 1]) {
      $character_count += $word_length + count($words_array);

      array_push($words_array, $word);  

      $words_count = count($words_array);
    }
  }

  $words = implode(' ', $words_array);
  $words = substr($words, 0, $count);

  $last_character = substr($words, -1);

  if ($last_character === ' ') {
    $words = substr($words, 0, -1) . substr($lipsum->word(), 0, 1);
  }

  return $words;
}

switch ($type) {
  case 'characters':
    $output = characters($length);
    break;
  case 'words':
    $output = $lipsum->words($length);
    break;
  case 'sentences':
    $output = $lipsum->sentences($length);
    break;
  case 'paragraphs':
    $output = $lipsum->paragraphs($length);
    break;
}

echo ucfirst($output);
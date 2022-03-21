#!/bin/sh

# lipsum-shell
# https://github.com/alexchantastic/lipsum-shell

# MIT License
#
# Copyright (c) 2022 Alex Chan
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

version="1.0.1"
word_pool=("ad" "adipiscing" "aliqua" "aliquip" "amet" "anim" "aute" "cillum" "commodo"
         "consectetur" "consequat" "culpa" "cupidatat" "deserunt" "do" "dolor" "dolore"
         "duis" "ea" "eiusmod" "elit" "enim" "esse" "est" "et" "eu" "ex" "excepteur"
         "exercitation" "fugiat" "id" "in" "incididunt" "ipsum" "irure" "labore" "laboris"
         "laborum" "lorem" "magna" "minim" "mollit" "nisi" "non" "nostrud" "nulla"
         "occaecat" "officia" "pariatur" "proident" "qui" "quis" "reprehenderit" "sed"
         "sint" "sit" "sunt" "tempor" "ullamco" "ut" "velit" "veniam" "voluptate")
default_min_words=4
default_max_words=8
default_min_sentences=5
default_max_sentences=10
         
# Generate a series of characters
#
# @param  int $count  Number of characters to generate
# @return string
generate_characters() {
  local count word words characters

  count=$1

  while [ ${#characters} -lt $count ]
  do
    word=$(generate_words 1)
    words+=($word)
    characters=${words[@]}
  done

  echo ${characters:0:$count}
}

# Generate a series of words
#
# @param  int $count  Number of words to generate
# @return string
generate_words() {
  local i count rand word words

  count=$1

  for ((i=0; i<$count; i++))
  do
    rand=$(( RANDOM % ${#word_pool[*]} ))
    word=${word_pool[$rand]}
    words+=($word)
  done

  echo ${words[@]}
}

# Generate a series of sentences
#
# @param  int $count    Number of sentences to generate
# @param  int $min      Minimum number of words per sentence (default: 4)
# @param  int $max      Maximum number of words per sentence (default: 8)
# @return string
generate_sentences() {
  local i count min max len placement sentence sentences

  count=$1
  min=${2:-$default_min_words}
  max=${3:-$default_max_words}

  for ((i=0; i<$count; i++))
  do
    len=$(( RANDOM % (${max} - ${min} + 1 ) + ${min} ))
    sentence=$(generate_words $len)
    sentence=$(capitalize "$sentence")

    # Randomly distribute commas throughout the sentences
    if [[ $len > 1 && $(( RANDOM % 2 )) = 1 ]]; then
      placement=$(( RANDOM % ($len - 1) + 1 ))
      sentence=$(sed "s/ /, /"$placement <<<$sentence)
    fi

    sentences+=($sentence.)
  done

  echo ${sentences[@]}
}

# Generate a series of paragraphs
#
# @param  int $count        Number of paragraphs to generate
# @param  int $min          Minimum number of sentences per paragraph (default: 5)
# @param  int $max          Maximum number of sentences per paragraph (default: 10)
# @param  int $min_words    Minimum number of words per sentence (default: 4)
# @param  int $max_words    Maximum number of words per sentence (default: 8)
# @return string
generate_paragraphs() {
  local i count min max len min_words max_words paragraph paragraphs

  count=$1
  min=${2:-$default_min_sentences}
  max=${3:-$default_max_sentences}
  min_words=${4:-$default_min_words}
  max_words=${5:-$default_max_words}

  for ((i=0; i<$count; i++))
  do
    len=$(( RANDOM % (${max} - ${min} + 1) + ${min} ))
    paragraph=$(generate_sentences $len $min_words $max_words)
    paragraphs+=$paragraph

    # Add linebreaks
    if [ ! $i = $(( $count - 1 )) ]; then
      paragraphs+="\n\n"
    fi
  done

  echo ${paragraphs[@]}
}

# Capitalize the first letter in a string
#
# @param  string $string    String to capitalize
# @return string
capitalize() {
  local string first_letter ord

  string=$1
  first_letter=${string:0:1}

  if [[ ${first_letter} == [a-z] ]]; then
    ord=$(printf '%o' "'${first_letter}")
    ord=$(( ord - 40 ))
    first_letter=$(printf '%b' '\'${ord})
  fi

  echo "${first_letter}${string:1}"
}

# Show help information
#
# @return string
show_help() {
  echo "Generates lorem ipsum dummy text"
  echo
  echo "Usage: lipsum [-t] [-c] [-m|M|w|W|h|v]"
  echo "Options:"
  echo "  -t    Type of text structure to generate (characters|words|sentences|paragraphs)"
  echo "  -c    Number of structures to generate"
  echo "  -m    Minimum number of structures to generate (applies to sentence and paragraph only)"
  echo "  -M    Maximum number of structures to generate (applies to sentence and paragraph only)"
  echo "  -w    Minimum number of words to generate per sentence (applies to paragraph only)"
  echo "  -W    Maximum number of words to generate per sentence (applies to paragraph only)"
  echo "  -v    Print version"
  echo "  -h    Print help"

  exit 0
}

# Show version information
#
# @return string
show_version() {
  echo "lipsum $version"

  exit 0
}

while getopts t:c:m:M:w:W:hv option
do
  case $option in
    t) type=${OPTARG};;
    c) count=${OPTARG};;
    m) min=${OPTARG};;
    M) max=${OPTARG};;
    w) min_words=${OPTARG};;
    W) max_words=${OPTARG};;
    h) show_help;;
    v) show_version;;
    *) exit 1;;
  esac
done

case $type in
  characters|character|char|c)
    printf "$(capitalize "$(generate_characters $count)")"
    ;;
  words|word|w)
    printf "$(capitalize "$(generate_words $count)")"
    ;;
  sentences|sentence|sent|s)
    printf "$(generate_sentences $count $min $max)"
    ;;
  paragraphs|paragraph|para|p)
    printf "$(generate_paragraphs $count $min $max $min_words $max_words)"
    ;;
esac

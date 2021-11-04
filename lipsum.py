import sys
from lib.lorem import lorem

args = sys.argv
type = args[1]
count = int(args[2]) if len(args) >= 3 else 1

def get_character(count):
  pool = lorem.get_word(1)

  while len(pool) <= count:
    pool += ' ' + lorem.get_word(1)

  return pool[0:count]

def lipsum(type):
  if type == 'characters':
    return get_character(count).capitalize()

  elif type == 'words':
    return lorem.get_word(count).capitalize()

  elif type == 'sentences':
    return lorem.get_sentence(count)

  elif type == 'paragraphs':
    return lorem.get_paragraph(count, '\n\n')

  else:
    return lorem.get_sentence(count)

sys.stdout.write(lipsum(type))
sys.stdout.flush()

import sys
from lib.lorem import lorem

args = sys.argv
type = args[1]
count = int(args[2]) if len(args) >= 3 else 1

def lipsum(type):
  if type == 'characters':
    return ''

  elif type == 'words':
    return lorem.get_word(count).capitalize()

  elif type == 'sentences':
    return lorem.get_sentence(count)

  elif type == 'paragraphs':
    return lorem.get_paragraph(count)

  else:
    return lorem.get_sentence(count)

print(lipsum(type))

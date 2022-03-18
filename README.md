# alfred-lipsum-workflow

![Screenshot](https://user-images.githubusercontent.com/604167/42200962-8c4c8a76-7e4a-11e8-9642-cffbef06798f.png)

An [Alfred 4](https://www.alfredapp.com/) workflow for generating [lorem ipsum](https://en.wikipedia.org/wiki/Lorem_ipsum) dummy text using [JarryShaw/lorem](https://github.com/JarryShaw/lorem).

## Dependencies

Since macOS Monterey 12.3 no longer comes packaged with Python, you will need to install Python 3 starting with the `v3.2.0` release and have it accessible via `python3`. If you would prefer to stick with Python 2, you can utilize the `v3.1.x` release and have `python` pointed to Python 2.

To install Python 3:

1. Open Terminal (or any terminal app)
2. Run `xcode-select --install`
3. Click **Install** on the prompt that appears
4. After the download completes, click **Done**

Alternatively, you can also install Python 3 with [Homebrew](https://brew.sh/):

```sh
brew install python3
```

Note that you will need to alias this to `python3`.

You can verify that Python 3 has been installed by running `python3 --version` in Terminal. This should produce output that looks like this:

```sh
$ python3 --version
Python 3.8.9
```

## Installation

1. Install Python 3
2. [Download the workflow](https://github.com/alexchantastic/alfred-lipsum-workflow/releases/latest)
3. Double click the `.alfredworkflow` file to install

Note that the [Alfred Powerpack](https://www.alfredapp.com/powerpack/) is required to use workflows.

## Usage

1. Use the keyword `lipsum` to trigger the workflow
2. Select format you want to generate (characters, words, sentences, or paragraphs)
3. (Optional) Type in the number of the format you would like to generate (defaults to 1)
4. Press `enter` to copy to clipboard and paste into the forefront application or just `⌘ + c` to copy to clipboard

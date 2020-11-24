# sscp
Wrapper for `scp` to simplify server uploads and downloads. NOT a replacement, and only meant for very basic use cases.

## Installation

Clone this repo, or download as a zip file, and run `make install`.

## Running the command

`sscp [command] [options]`

where:

- `command` could be `upload` or `download`
- `options` are flags (`sscp upload --help` lists down all the flags with defaults)

*Note*: if your parameters are somewhat permanent (such as `user`), modify `agent.sh` to hardcode values and run `make install`.

### Examples

To upload a folder named "test": `sscp upload --folder test`

To download a folder named "test": `sscp download --folder test`

# CAESER++

Caeser++ is a silly programming language based on Latin.

The language is defined in [caeser++.bnf](caeser++.bnf) and there are a few example programmes:
- [example.cae](example.cae)
- [example2.cae](example2.cae)

Copilot's coding agent has written me a [lexer](caeser_lexer.py), [parser](caeser_parser.py) and [interpreter](caeser_interpreter.py) in Python.
The interpreter can be run from the CLI with the command `py interpreter.py`. 
The interpreter takes a file name as an argument, but will default to running `example.cae` if the argument is ommitted.

## To Do
- [ ] String concatenation is not implemented correctly
- [ ] Some more challenging examples should be created
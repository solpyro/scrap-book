class Token:
    def __init__(self, type, value):
        self.type = type
        self.value = value
    
    def __str__(self):
        return f"Token({self.type}, {self.value})"

class Lexer:
    def __init__(self, text):
        self.text = text
        self.pos = 0
        self.current_char = self.text[0] if text else None

    def error(self):
        raise Exception(f"Invalid character at position {self.pos}: {self.current_char}")

    def advance(self):
        self.pos += 1
        self.current_char = self.text[self.pos] if self.pos < len(self.text) else None

    def skip_whitespace(self):
        while self.current_char and self.current_char.isspace():
            self.advance()

    def numeral(self):
        numerals = {"C", "D", "I", "L", "M", "V", "X"}
        result = ""
        while self.current_char and self.current_char in numerals:
            result += self.current_char
            self.advance()
        return result

    def identifier(self):
        result = ""
        while self.current_char and (self.current_char.isalpha() or self.current_char.isdigit()):
            if self.current_char.lower() != "u":
                result += self.current_char
            self.advance()
        return result

    def string(self):
        self.advance()
        result = ""
        while self.current_char and self.current_char != "\"":
            if self.current_char.lower() != "u":
                result += self.current_char
            self.advance()
        if not self.current_char:
            raise Exception("Unterminated string literal")
        self.advance()
        return result

    def character(self):
        self.advance()
        if not self.current_char:
            raise Exception("Unterminated character literal")
        result = self.current_char
        self.advance()
        if not self.current_char or self.current_char != "'":
            raise Exception("Invalid character literal")
        self.advance()
        return result

    def get_next_token(self):
        while self.current_char:
            if self.current_char.isspace():
                self.skip_whitespace()
                continue

            if self.current_char.isalpha():
                text_pos = self.text[self.pos:]
                
                if text_pos.startswith("By the decree of Caeser"):
                    self.pos += len("By the decree of Caeser")
                    self.current_char = self.text[self.pos] if self.pos < len(self.text) else None
                    return Token("DECREE", "By the decree of Caeser")
                
                if text_pos.startswith("Hail Caeser"):
                    self.pos += len("Hail Caeser")
                    self.current_char = self.text[self.pos] if self.pos < len(self.text) else None
                    return Token("HAIL", "Hail Caeser")
                
                if text_pos.startswith("Long live Rome"):
                    self.pos += len("Long live Rome")
                    self.current_char = self.text[self.pos] if self.pos < len(self.text) else None
                    return Token("END", "Long live Rome")

                # Check keywords before checking for numerals to avoid treating keywords
                # that start with roman numerals as numbers
                if text_pos.startswith("sic"):
                    self.pos += 3
                    self.current_char = self.text[self.pos] if self.pos < len(self.text) else None
                    return Token("SIC", "sic")

                if text_pos.startswith("est"):
                    self.pos += 3
                    self.current_char = self.text[self.pos] if self.pos < len(self.text) else None
                    return Token("EST", "est")

                if text_pos.startswith("scribere"):
                    self.pos += len("scribere")
                    self.current_char = self.text[self.pos] if self.pos < len(self.text) else None
                    return Token("SCRIBERE", "scribere")

                if text_pos.startswith("legere"):
                    self.pos += len("legere")
                    self.current_char = self.text[self.pos] if self.pos < len(self.text) else None
                    return Token("LEGERE", "legere")

                if text_pos.startswith("verum"):
                    self.pos += len("verum")
                    self.current_char = self.text[self.pos] if self.pos < len(self.text) else None
                    return Token("VERUM", True)

                if text_pos.startswith("falsus"):
                    self.pos += len("falsus")
                    self.current_char = self.text[self.pos] if self.pos < len(self.text) else None
                    return Token("FALSUS", False)

                if text_pos.startswith("et"):
                    self.pos += 2
                    self.current_char = self.text[self.pos] if self.pos < len(self.text) else None
                    return Token("ET", "et")

                # Check for roman numerals after all keywords
                if self.current_char in "CDILMVX":
                    return Token("NUMBER", self.numeral())
                
                # Must be an identifier
                return Token("IDENTIFIER", self.identifier())

            if self.current_char == "\"":
                return Token("STRING", self.string())

            if self.current_char == "'":
                return Token("CHAR", self.character())

            if self.current_char == ",":
                self.advance()
                return Token("COMMA", ",")

            if self.current_char == ".":
                self.advance()
                return Token("DOT", ".")

            if self.current_char == "+":
                self.advance()
                if self.current_char == "+":
                    self.advance()
                    return Token("INCREMENT", "++")
                return Token("PLUS", "+")

            if self.current_char == "-":
                self.advance()
                if self.current_char == "-":
                    self.advance()
                    return Token("DECREMENT", "--")
                return Token("MINUS", "-")

            if self.current_char == "*":
                self.advance()
                return Token("MULTIPLY", "*")

            if self.current_char == "/":
                self.advance()
                return Token("DIVIDE", "/")

            self.error()

        return Token("EOF", None)


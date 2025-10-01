from caeser_lexer import Lexer

class Parser:
    def __init__(self, lexer):
        self.lexer = lexer
        self.current_token = self.lexer.get_next_token()

    def error(self, expected=None):
        msg = f"Invalid syntax. Got {self.current_token.type}"
        if expected:
            msg += f", expected {expected}"
        raise Exception(msg)

    def eat(self, token_type):
        if self.current_token.type == token_type:
            self.current_token = self.lexer.get_next_token()
        else:
            self.error(token_type)

    def program(self):
        declarations = self.declaration_block()
        self.eat("HAIL")
        statements = self.statement_block()
        self.eat("END")
        return {"declarations": declarations, "statements": statements}

    def declaration_block(self):
        self.eat("DECREE")
        declarations = []
        while self.current_token.type == "SIC":
            declarations.append(self.declaration())
        return declarations

    def declaration(self):
        self.eat("SIC")
        identifier = self.current_token.value
        self.eat("IDENTIFIER")
        value = None
        if self.current_token.type == "EST":
            self.eat("EST")
            value = self.expression()
        self.eat("COMMA")
        return {"type": "declaration", "identifier": identifier, "value": value}

    def statement_block(self):
        statements = []
        while self.current_token.type != "END":
            statements.append(self.statement())
        return statements

    def statement(self):
        if self.current_token.type == "SCRIBERE":
            stmt = self.io_operation()
        elif self.current_token.type == "IDENTIFIER":
            # Save lexer state
            identifier = self.current_token.value
            self.eat("IDENTIFIER")
            
            # Check what kind of statement this is
            if self.current_token.type == "EST":
                self.eat("EST")
                value = self.expression()
                stmt = {"type": "assignment", "identifier": identifier, "value": value}
            elif self.current_token.type == "INCREMENT":
                self.eat("INCREMENT")
                stmt = {"type": "increment", "identifier": identifier}
            elif self.current_token.type == "DECREMENT":
                self.eat("DECREMENT")
                stmt = {"type": "decrement", "identifier": identifier}
            else:
                # Must be part of an expression
                # First create a variable node for the identifier we already consumed
                stmt = {"type": "variable", "name": identifier}
                
                # Now check if this is part of a binary operation
                if self.current_token.type in ("PLUS", "MINUS", "MULTIPLY", "DIVIDE"):
                    token = self.current_token
                    self.eat(token.type)
                    stmt = {
                        "type": "binary_op",
                        "op": token.type.lower(),
                        "left": stmt,
                        "right": self.expression()
                    }
        else:
            stmt = self.expression()
        
        self.eat("DOT")
        return stmt

    def io_operation(self):
        self.eat("SCRIBERE")
        expr = self.expression()
        return {"type": "output", "expression": expr}

    def expression(self):
        if self.current_token.type in ("VERUM", "FALSUS"):
            return self.logic_expression()
        elif self.current_token.type in ("STRING", "CHAR"):
            return self.text_expression()
        else:
            return self.numeric_expression()

    def numeric_expression(self):
        node = self.term()
        while self.current_token.type in ("PLUS", "MINUS"):
            token = self.current_token
            if token.type == "PLUS":
                self.eat("PLUS")
            else:
                self.eat("MINUS")
            node = {"type": "binary_op", "op": token.type.lower(), "left": node, "right": self.term()}
        return node

    def term(self):
        node = self.factor()
        while self.current_token.type in ("MULTIPLY", "DIVIDE"):
            token = self.current_token
            if token.type == "MULTIPLY":
                self.eat("MULTIPLY")
            else:
                self.eat("DIVIDE")
            node = {"type": "binary_op", "op": token.type.lower(), "left": node, "right": self.factor()}
        return node

    def factor(self):
        token = self.current_token
        if token.type == "NUMBER":
            self.eat("NUMBER")
            return {"type": "number", "value": token.value}
        elif token.type == "IDENTIFIER":
            self.eat("IDENTIFIER")
            return {"type": "variable", "name": token.value}
        self.error()

    def text_expression(self):
        token = self.current_token
        if token.type in ("STRING", "CHAR"):
            self.eat(token.type)
            expr = {"type": token.type.lower(), "value": token.value}
            if self.current_token.type == "ET":
                self.eat("ET")
                return {"type": "concatenation", "left": expr, "right": self.text_expression()}
            return expr
        self.error()

    def logic_expression(self):
        token = self.current_token
        if token.type in ("VERUM", "FALSUS"):
            self.eat(token.type)
            return {"type": "logic", "value": token.value}
        self.error()

def parse(text):
    lexer = Lexer(text)
    parser = Parser(lexer)
    return parser.program()

if __name__ == "__main__":
    import os
    import json
    
    with open(os.path.join(os.path.dirname(__file__), "example.cae"), "r") as f:
        program = f.read()
    
    try:
        ast = parse(program)
        print("Parse successful!")
        print("AST:", json.dumps(ast, indent=2))
    except Exception as e:
        print("Parse error:", str(e))

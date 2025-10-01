from caeser_parser import Parser
from caeser_lexer import Lexer

class Interpreter:
    def __init__(self):
        self.variables = {}
    
    def evaluate(self, ast):
        # Handle top level program structure
        for decl in ast.get('declarations', []):
            self.evaluate_declaration(decl)
        
        for stmt in ast.get('statements', []):
            self.evaluate_statement(stmt)
    
    def evaluate_declaration(self, declaration):
        identifier = declaration['identifier']
        value = declaration.get('value')
        if value is None:
            self.variables[identifier] = None
        else:
            self.variables[identifier] = self.evaluate_expression(value)
    
    def evaluate_statement(self, statement):
        stmt_type = statement['type']
        if stmt_type == 'output':
            value = self.evaluate_expression(statement['expression'])
            print(value)
        elif stmt_type == 'assignment':
            value = self.evaluate_expression(statement['value'])
            self.variables[statement['identifier']] = value
        elif stmt_type == 'increment':
            current = self.roman_to_int(str(self.variables[statement['identifier']]))
            self.variables[statement['identifier']] = self.int_to_roman(current + 1)
    
    def evaluate_expression(self, expr):
        if expr is None:
            return None
        
        expr_type = expr['type']
        if expr_type == 'string':
            return expr['value']
        elif expr_type == 'number':
            return expr['value']  # Keep Roman numerals as strings
        elif expr_type == 'variable':
            return self.variables.get(expr['name'])
        elif expr_type == 'binary_op':
            left = self.evaluate_expression(expr['left'])
            right = self.evaluate_expression(expr['right'])
            if expr['op'] == 'plus':
                # Convert Roman numerals to int, add, then convert back
                left_val = self.roman_to_int(str(left))
                right_val = self.roman_to_int(str(right))
                return self.int_to_roman(left_val + right_val)
            # Add more operators as needed
        return None
    
    def roman_to_int(self, roman_num):
        roman_values = {
            'I': 1,
            'V': 5,
            'X': 10,
            'L': 50,
            'C': 100,
            'D': 500,
            'M': 1000
        }
        
        total = 0
        prev_value = 0
        
        for char in reversed(roman_num):
            current_value = roman_values[char]
            if current_value >= prev_value:
                total += current_value
            else:
                total -= current_value
            prev_value = current_value
            
        return total
    
    def int_to_roman(self, num):
        roman_symbols = [
            ('M', 1000),
            ('CM', 900),
            ('D', 500),
            ('CD', 400),
            ('C', 100),
            ('XC', 90),
            ('L', 50),
            ('XL', 40),
            ('X', 10),
            ('IX', 9),
            ('V', 5),
            ('IV', 4),
            ('I', 1)
        ]
        
        result = ''
        for symbol, value in roman_symbols:
            while num >= value:
                result += symbol
                num -= value
        return result

def main():
    import sys
    
    # Get filename from command line args or use default
    filename = sys.argv[1] if len(sys.argv) > 1 else 'example.cae'
    
    try:
        with open(filename, 'r') as file:
            content = file.read()
        
        lexer = Lexer(content)
        parser = Parser(lexer)
        ast = parser.program()
        
        interpreter = Interpreter()
        interpreter.evaluate(ast)
    except FileNotFoundError:
        print(f"Error: Could not find file '{filename}'")
        print("Usage: python interpreter.py [filename]")
        print("If no filename is provided, defaults to 'example.cae'")
    except Exception as e:
        print(f"Error while processing '{filename}': {str(e)}")

if __name__ == '__main__':
    main()
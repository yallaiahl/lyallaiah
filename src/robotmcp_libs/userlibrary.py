"""UserLibrary: a simple Robot Framework user library

Implements the older dynamic library API methods `get_keyword_names`
and `run_keyword` so Robot Framework can query and execute keywords
dynamically.

Provided keywords:
- Echo: returns the given message
- Add Numbers: returns sum of two numbers
- Multiply Numbers: returns product of two numbers (second arg optional)

Usage in Robot: `Library    src.robotmcp_libs.userlibrary.UserLibrary`
"""

class UserLibrary:
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'

    def __init__(self):
        self._keywords = {
            'Echo': self._echo,
            'Add Numbers': self._add_numbers,
            'Multiply Numbers': self._multiply_numbers,
        }

    def get_keyword_names(self):
        """Return a list of available keyword names."""
        return list(self._keywords.keys())

    def run_keyword(self, name, args=None, kwargs=None):
        """Run the keyword named `name` with positional `args` and `kwargs`.

        - `name` (str): keyword name as returned by `get_keyword_names`
        - `args` (list): positional arguments
        - `kwargs` (dict): keyword arguments
        """
        if args is None:
            args = []
        if kwargs is None:
            kwargs = {}

        try:
            func = self._keywords[name]
        except KeyError:
            raise RuntimeError(f'Keyword "{name}" not found')

        return func(*args, **kwargs)

    # --- actual keyword implementations ---
    def _echo(self, message=''):
        return message

    def _add_numbers(self, a, b):
        return float(a) + float(b)

    def _multiply_numbers(self, a, b=1):
        return float(a) * float(b)

part of lex.src.combinator;

class _FoldErrors<T> extends Parser<T> {
  final Parser<T> parser;

  _FoldErrors(this.parser);

  @override
  ParseResult<T> parse(SpanScanner scanner, [int depth = 1]) {
    var result = parser.parse(scanner, depth + 1).change(parser: this);
    var errors = result.errors.fold<List<SyntaxError>>([], (out, e) {
      if (!out.any((b) => b == e)) out.add(e);
      return out;
    });
    return result.change(errors: errors);
  }
}
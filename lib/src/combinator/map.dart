part of lex.src.combinator;

class _Map<T, U> extends Parser<U> {
  final Parser<T> parser;
  final U Function(ParseResult<T>) f;

  _Map(this.parser, this.f);

  @override
  ParseResult<U> parse(SpanScanner scanner, [int depth = 1]) {
    var result = parser.parse(scanner, depth + 1);
    return new ParseResult<U>(
      this,
      result.successful,
      result.errors,
      span: result.span,
      value: result.successful ? f(result) : null,
    );
  }
}


class _Change<T, U> extends Parser<U> {
  final Parser<T> parser;
  final ParseResult<U> Function(ParseResult<T>) f;

  _Change(this.parser, this.f);

  @override
  ParseResult<U> parse(SpanScanner scanner, [int depth = 1]) {
    return f(parser.parse(scanner, depth + 1)).change(parser: this);
  }
}
# UUID

Generation of UUIDs based on [RFC 4122](https://datatracker.ietf.org/doc/html/rfc4122).

## Usage

```motoko
let g = uuid.Generator();
uuid.toText(g.new());
// F253F1F0-2885-169F-169F-2885F253F1F0
```

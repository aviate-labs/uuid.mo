let base = https://github.com/internet-computer/base-package-set/releases/download/moc-0.7.4/package-set.dhall sha256:3a20693fc597b96a8c7cf8645fda7a3534d13e5fbda28c00d01f0b7641efe494
let Package = { name : Text, version : Text, repo : Text, dependencies : List Text }

let additions = [
  { name = "array"
  , version = "v0.2.1"
  , repo = "https://github.com/aviate-labs/array.mo"
  , dependencies = [ "base-0.7.3" ] : List Text
  },
  { name = "encoding"
  , version = "v0.4.1"
  , repo = "https://github.com/aviate-labs/encoding.mo"
  , dependencies = [ "base-0.7.3", "array" ]
  },
  { name = "io"
  , version = "v0.3.2"
  , repo = "https://github.com/aviate-labs/io.mo"
  , dependencies = [ "base-0.7.3" ]
  }
] : List Package

in  base # additions

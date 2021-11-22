let upstream = https://github.com/aviate-labs/package-set/releases/download/v0.1.2/package-set.dhall sha256:770d9d2bd9752457319e8018fdcef2813073e76e0637b1f37a7f761e36e1dbc2
let Package = { name : Text, version : Text, repo : Text, dependencies : List Text }
let additions = [
  { name = "array"
  , repo = "https://github.com/aviate-labs/array.mo"
  , version = "v0.2.0"
  , dependencies = [ "base" ]
  },
  { name = "io"
  , repo = "https://github.com/aviate-labs/io.mo"
  , version = "v0.3.0"
  , dependencies = [ "base" ]
  },
  { name = "rand"
  , repo = "https://github.com/aviate-labs/rand.mo"
  , version = "v0.2.1"
  , dependencies = [ "base" ]
  },
] : List Package
in  upstream # additions

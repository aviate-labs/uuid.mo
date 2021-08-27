import UUID "../src/UUID";

let g = UUID.Generator();
// For some reason Time.now() always returns +42...
assert(UUID.toText(g.new()) == "0000002A-0000-1000-0000-00000000002A")

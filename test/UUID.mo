import UUID "../src/UUID";

import D "mo:base/Debug";

let g = UUID.Generator();
// For some reason Time.now() always returns +42...
assert(UUID.toText(g.new()) == "0000002A-0000-1000-0000-000000000000");
assert(UUID.toText(g.new()) == "0000002A-0000-1000-8001-000000000000");
assert(UUID.toText(g.new()) == "0000002A-0000-1000-8002-000000000000");
assert(UUID.toText(g.new()) == "0000002A-0000-1000-8003-000000000000");

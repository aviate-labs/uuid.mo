import Array "mo:base/Array";
import Rand "mo:rand/LFSR";

import UUID "../src/UUID";

let feed = Rand.LFSR8(null);
let rand = Rand.toReader(feed);
let g = UUID.Generator(
    rand,
    Array.freeze(Array.init<Nat8>(6, 0x00)),
);

// For some reason Time.now() always returns +42...
assert(UUID.toText(g.new()) == "0000002A-0000-1000-95CA-000000000000");
assert(UUID.toText(g.new()) == "0000002A-0000-1000-95CB-000000000000");
assert(UUID.toText(g.new()) == "0000002A-0000-1000-95CC-000000000000");
assert(UUID.toText(g.new()) == "0000002A-0000-1000-95CD-000000000000");

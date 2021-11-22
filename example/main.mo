import Debug "mo:base/Debug";
import XorShift "mo:rand/XorShift";

import UUID "../src/UUID";
import Source "../src/Source";

actor {
    private let rr = XorShift.toReader(XorShift.XorShift64(null));
    private let c = [0, 0, 0, 0, 0, 0]; // Replace with identifier of canister f.e.
    private let s = Source.Source(rr, c);

    public func new() : async Text {
        let id = s.new();
        Debug.print(debug_show((id, id.size())));
        UUID.toText(id);
    };
};

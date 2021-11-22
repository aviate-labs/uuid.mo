import Debug "mo:base/Debug";
import XorShift "mo:rand/XorShift";

import UUID "../src/UUID";
import Source "../src/Source";
import AsyncSource "../src/async/SourceV4";

actor {
	private let ae = AsyncSource.Source();

	private let rr = XorShift.toReader(XorShift.XorShift64(null));
	private let c : [Nat8] = [0, 0, 0, 0, 0, 0]; // Replace with identifier of canister f.e.
	private let se = Source.Source(rr, c);

	public func newAsync() : async Text {
	    let id = await ae.new();
	    Debug.print(debug_show((id, id.size())));
	    UUID.toText(id);
	};

	public func newSync() : async Text {
	    let id = se.new();
	    Debug.print(debug_show((id, id.size())));
	    UUID.toText(id);
	};
};

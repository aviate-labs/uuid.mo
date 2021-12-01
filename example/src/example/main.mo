import Debug "mo:base/Debug";
import UUID "mo:uuid/UUID";
import Source "mo:uuid/Source";
import AsyncSource "mo:uuid/async/SourceV4";
import XorShift "mo:rand/XorShift";

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

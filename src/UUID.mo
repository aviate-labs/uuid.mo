import Hex "mo:encoding/Hex";
import List "mo:base/List";

module {
	// A UUID is a 128 bit (16 byte) Universal Unique IDentifier as defined in RFC 4122.
	public type UUID = [Nat8];

	// Converts the UUID to its textual representation.
	public func toText(uuid : UUID) : Text {
	    var t = "";
	    let xs = List.fromArray(uuid);
	    let (p0, xs0) = List.split(4, xs);
	    t #= Hex.encode(List.toArray(p0)) # "-";
	    let (p1, xs1) = List.split(2, xs0);
	    t #= Hex.encode(List.toArray(p1)) # "-";
	    let (p2, xs2) = List.split(2, xs1);
	    t #= Hex.encode(List.toArray(p2)) # "-";
	    let (p3, xs3) = List.split(2, xs2);
	    t # Hex.encode(List.toArray(p3)) # "-" # Hex.encode(List.toArray(xs3));
	};
};

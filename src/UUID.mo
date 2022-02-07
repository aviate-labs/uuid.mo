import Hex "mo:encoding/Hex";
import List "mo:base/List";
import Bool "mo:base/Bool";
import Array "mo:base/Array";
import Nat8 "mo:base/Nat8";
import Nat32 "mo:base/Nat32";
import Hash "mo:base/Hash";
import Text "mo:base/Text";
import Buffer "mo:base/Buffer";

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

	public func hash(uuid : UUID): Hash.Hash{ 
		var buffer = Buffer.Buffer<Nat32>(16); //128 bit - 16 byte 
		for(n8 in uuid.vals()){
			var n = Nat8.toNat(n8);
			var n32 = Nat32.fromNat(n);
			buffer.add(n32);
		};	
		return Hash.hashNat8(buffer.toArray());
	};

	public func equal(uuid : UUID, uuid2 : UUID): Bool = Array.equal(uuid, uuid2, Nat8.equal);
};

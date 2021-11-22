import Array "mo:base/Array";
import Array_ "mo:array/Array";
import Blob "mo:base/Blob";
import Random "mo:base/Random";

import UUID "../UUID";

module {
	public class Source() {
		private var r : [Nat8] = [];

		// The strength of the UUIDs is based on the strength of `Random.blob`.
		public func new() : async UUID.UUID {
			let r = await read(16);
			let uuid = Array.thaw<Nat8>(r);
			uuid[6] := (uuid[6] & 0x0f) | 0x40; // Version 4
			uuid[8] := (uuid[8] & 0x3f) | 0x80; // Variant is 10
			Array.freeze(uuid);
		};

		private func read(n : Nat) : async [Nat8] {
			return if (r.size() == n) {
				let b = await Random.blob();
				let bs = r;
				r := Blob.toArray(b);
				bs;
			} else if (r.size() < n) {
				let b = await Random.blob();
				let (bs, r_) = Array_.split<Nat8>(Blob.toArray(b), n);
				r := r_;
				bs;
			} else {
				let (bs, r_) = Array_.split<Nat8>(r, n);
				r := r_;
				bs;
			};
		};
	};
};

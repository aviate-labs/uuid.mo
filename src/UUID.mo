import Array "mo:base/Array";
import Binary "mo:encoding/Binary";
import Hex "mo:encoding/Hex";
import Int "mo:base/Int";
import IO "mo:io/IO";
import List "mo:base/List";
import Nat8 "mo:base/Nat8";
import Nat16 "mo:base/Nat16";
import Nat32 "mo:base/Nat32";
import Nat64 "mo:base/Nat64";
import Time "mo:base/Time";

module {    
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
    
    public class Generator(
        rand : IO.Reader<Nat8>,
        node : [Nat8],
    ) {
        if (node.size() != 6) assert(false);

        private let lillian    : Nat64 = 2299160;          // Julian day of 15 Oct 1582.
        private let unix       : Nat64 = 2440587;          // Julian day of 1 Jan 1970.
        private let epoch      : Nat64 = unix - lillian;   // Days between epochs.
        private let g1582      : Nat64 = epoch * 86400;    // Seconds between epochs.
        private let g1582ns100 : Nat64 = g1582 * 10000000; // 100s of a nanoseconds between epochs.
        
        private var lastTime      : Nat64 = 0;
        private var clockSequence : Nat16 = 0;

        // Generates a new UUID.
        public func new() : UUID {
            let (now, clock) = time();
            let low  = Nat32.fromNat(Nat64.toNat(now & 0xFFFFFFFF));
            let mid  = Nat16.fromNat(Nat64.toNat((now >> 32) & 0xFFFF));
            let high = Nat16.fromNat(Nat64.toNat((now >> 48) & 0x0FFF)) | 0x1000;
            append<Nat8>([
                Binary.BigEndian.fromNat32(low),
                Binary.BigEndian.fromNat16(mid),
                Binary.BigEndian.fromNat16(high),
                Binary.BigEndian.fromNat16(clock),
                node,
            ]);
        };

        private func time() : (Nat64, Nat16) {
            let t = Nat64.fromNat(Int.abs(Time.now()));
            if (clockSequence == 0) {
                setClockSequence(null);
            };
            let now = t/100 + g1582ns100;
            if (now <= lastTime) {
                clockSequence := ((clockSequence + 1) & 0x3fff) | 0x8000;
            };
            lastTime := now;
            (t, clockSequence);
        };

        // Sets the clock sequence to the lower 14 bits of seq, null generates a new clock sequence.
        public func setClockSequence(seq : ?Nat16) {
            var s : Nat16 = switch (seq) {
                case (null) {
                    let (bs, err) = rand.read(2);
                    nat8to16(bs[0]) << 8 | nat8to16(bs[1]);
                };
                case (? s) { s; };
            };
            let oldSequence = clockSequence;
            clockSequence := s & 0x3FFF | 0x8000;
            if (oldSequence != clockSequence) {
                lastTime := 0;
            };
        };

        private func append<A>(xs : [[A]]) : [A] {
            var ys : [A] = [];
            for (v in xs.vals()) {
                ys := Array.append(ys, v);
            };
            ys;
        };

        private func nat8to16(n : Nat8) : Nat16 {
            Nat16.fromNat(Nat8.toNat(n));
        };
    };
};

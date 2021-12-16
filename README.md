# UUID

Generation of UUIDs based on [RFC 4122](https://datatracker.ietf.org/doc/html/rfc4122).

## Usage

```motoko
// import Source uuid/async/SourceV4
// import UUID uuid/UUID

let g = Source.Source();
UUID.toText(await g.new());
// F253F1F0-2885-169F-169F-2885F253F1F0
```

---

This library was incentivized by [ICDevs](https://ICDevs.org).  You can view more about the bounty on the [forum](https://forum.dfinity.org/t/icdevs-org-bounty-4-uuid-motoko-library/8648) or [website](https://icdevs.org/bounties/2021/11/17/UUID-motoko-library.html). The bounty was funded by The Dragginz Team and the award was graciously donated by [di-wu](https://github.com/di-wu) to the treasury of ICDevs.org so that we could pursue more bounties. If you use this library and gain value from it, please consider a [donation](https://icdevs.org/donations.html) to ICDevs.

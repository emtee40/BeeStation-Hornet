/// INTERNAL USE ONLY - byond doesn't like undef block defines on older versions
#define CACHED_REF(datum) (datum:cached_ref ||= "\ref[datum]")

/// Takes a datum as input, returns its ref string, or a cached version of it
/// This allows us to cache \ref creation, which ensures it'll only ever happen once per datum, saving string tree time
/// It is slightly less optimal then a []'d datum, but the cost is massively outweighed by the potential savings
/// It will only work for datums mind, for datum reasons
/// : because of the embedded typecheck
#define FAST_REF(datum) (isdatum(datum) ? CACHED_REF(datum) : "\ref[datum]")

/// FAST_REF but with 512 tag support
/// Retrieves the \ref string (aka [0xd3adb33f]) of a given datum, or its tag if DF_USE_TAG is set
#define REF(datum) (isdatum(datum) ? ((datum:datum_flags & DF_USE_TAG) && datum:tag ? "[datum:tag]" : CACHED_REF(datum)) : "\ref[datum]")

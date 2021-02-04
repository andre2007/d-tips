---
title: Copy folder recursive
tags:
    - file_system
---
# Copy folder recursive

``` d
void copyRecurse(string from, string to)
{
    import std.file: copy, dirEntries, isDir, isFile, mkdirRecurse, SpanMode;
    import std.path: buildNormalizedPath, buildPath;

    from = buildNormalizedPath(from);
    to = buildNormalizedPath(to);

    if (isDir(from))
    {
        mkdirRecurse(to);

        auto entries = dirEntries(from, SpanMode.breadth);
        foreach (entry; entries)
        {
            auto dst = buildPath(to, entry.name[from.length + 1 .. $]);
                // + 1 for the directory separator
            if (isFile(entry.name)) copy(entry.name, dst);
            else mkdirRecurse(dst);
        }
    }
    else copy(from, to);
}
```
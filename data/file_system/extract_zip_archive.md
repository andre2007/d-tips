---
title: Extract zip archive
tags:
    - file_system
    - zip
---
# Extract zip archive

``` d
void extractArchive(string archivePath, string destinationPath)
{
    import std.path, std.zip, std.file, std.stdio, std.string;
    
    ZipArchive archive = new ZipArchive(read(archivePath));
    
    foreach (name, am; archive.directory)
    {
        string destination = buildNormalizedPath(destinationPath, name);
        if (!destination.dirName.exists)
            mkdirRecurse(destination.dirName);
        if (!name.endsWith("/"))
        {
            archive.expand(am);
            am.expandedData.toFile(destination);
        }
    }
}
```


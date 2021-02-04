---
title: List windows system drives
some_url: https://gist.github.com/aferust/5cc3209a6b6caf1062271a082c093b87
tags:
    - file_system
    - windows
---
# List windows system drives

``` d
import std.stdio, std.string;

alias std.string.toStringz CSTR;

import core.sys.windows.windows;

extern(Windows)
{
    DWORD GetLogicalDrives();
    UINT GetDriveTypeA(LPCSTR lpRootPathName);
    UINT GetDriveTypeW(LPCWSTR lpRootPathName);
    //The drive type cannot be determined. 
    const UINT DRIVE_UNKNOWN = 0;
    //The root path is invalid; for example, there is no volume is mounted at the path.
    const UINT DRIVE_NO_ROOT_DIR = 1;
    //The drive has removable media; for example, a floppy drive, thumb drive, or flash card reader.
    const UINT DRIVE_REMOVABLE = 2; 
    //The drive has fixed media; for example, a hard drive or flash drive.
    const UINT DRIVE_FIXED = 3; 
    //The drive is a remote (network) drive.
    const UINT DRIVE_REMOTE = 4; 
    //The drive is a CD-ROM drive.
    const UINT DRIVE_CDROM = 5; 
    //The drive is a RAM disk.
    const UINT DRIVE_RAMDISK = 6; 
}

char[][] LocalDrives()
{
    DWORD mask = GetLogicalDrives();
    char[] drive = new char[3];
    char[][] list;  
    
    drive[1..3] = ":\\";    
    for(int i = 0; i < 26; i++)
    {
        if (mask & 0x1<<i)
        {
            drive[0] = cast(char)('A' + cast(char)i);
            list ~= drive.dup;
        }       
    }
    
    return list;
}

template SortDrive(UINT TYPE) { char[][] SortDrive() {
    char[][] list;
    
    foreach(drive; LocalDrives())
    {
        switch(GetDriveTypeA(CSTR(drive)))
        {
            case TYPE:
                list ~= drive;
                break;
            default:
                break;
        }
    }
    
    return list;
}}

alias SortDrive!(DRIVE_FIXED)       FixedDrives;
alias SortDrive!(DRIVE_REMOVABLE)   RemovableDrives;
alias SortDrive!(DRIVE_REMOTE)      RemoteDrives;
alias SortDrive!(DRIVE_CDROM)       CdDrives;
alias SortDrive!(DRIVE_RAMDISK)     RamDisks;

void main()
{
    writeln("Fixed    : ",FixedDrives());
    writeln("Removable: ",RemovableDrives());
    writeln("Remote   : ",RemoteDrives());
    writeln("Cd       : ",CdDrives());
    writeln("Ramdisk  : ",RamDisks());
}
```

Prepare Yourself like there is No Tomorrow
==========================================
I just hope that my computer never dies, but no one can guarantee that.

Homemade Benchmark (Compression)
--------------------------------
I did a benchmark for different compression algorithms implementations such as pixz, xz, gzip, brotli, bzip2.

tar

Just in case!
-------------
No one is perfect! And so am I, sometimes I still accidentally deleted some files. Here are some file recovery tips:

### If file still opened in an application
I will demonstrate this by deleting the pdf file **while** I am still viewing it in zathura pdf viewer.

1. Check the PID of the application with `pgrep zathura` (or `ps aux | grep zathura`), output: `10678`
2. Lists the opened files `file /proc/10678/fd/*` (or `ls -l`) and find the pdf file labeled `(deleted)`
3. Copy that by `cat /proc/10678/fd/13 > lv.pdf` and you should be able to view your file now.

### If file/directory not overwritten yet on ext3/ext4 file system
If possible, unmount the partition or else get a live rescue disk with `extundelete`. After the partition is unmounted, use `extundelete --undelete-files`.

**Warning:** Make sure that the file really isn't overwritten (no mkdir dir/no touch file)

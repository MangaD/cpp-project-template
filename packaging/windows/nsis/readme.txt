The bitmap has some tricks to work: https://stackoverflow.com/a/28768495/3049315

With GIMP, when exporting BMP, expand "compatibility options" and tick
"Do not write color space information". Tick 24 bits.

If using imagemagick, do: convert banner.bmp BMP3:banner.bmp

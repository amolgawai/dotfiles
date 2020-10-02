# vim Tips and Tricks

## Learning resources, references
1. [vimcasts](http://vimcasts.org/)
2. [Course on vimcasts](http://vimcasts.org/training/core-vim-course/)

## delete empty lines

    :g/^$/d

## relative ranges

    :.-2,.+8<command>

## join two lines
 pressing "J" at any place in the line you can combine the current line and the next line

## Delete from cursor till nth occurence of character x

    wd4/x<Enter>
or

    <n>df<x>
where:

    <n> is the number of occurrence of particular character
    df<x> means delete till you find the occurrence of character x

## Formatting
To format a line to the left

    :left.

Use this format an entire file:

    :%le

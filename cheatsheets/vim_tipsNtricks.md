# vim Tips and Tricks

## delete empty lines

    :g/^$/d

## relative ranges

    :.-2,.+8y 

## join two lines
 pressing "J" at any place in the line you can combine the current line and the next line
 
## Delete from cursor till nth occurence of character x

    wd4/x<Enter>
or

    <n>df<x>
where:

    <n> is the number of occurrence of particular character
    df<x> means delete till you find the occurrence of character x

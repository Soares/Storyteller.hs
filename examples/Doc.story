#     Headers are denoted by hashes      #
##  The number of hashes denotes level  ##
### Only leading hashes count. ###########
#### You can even leave them off entirely.
################## Depth can be arbitrary,
########## if your renderer supports it. #

= @Tag #cat1 #cat2
+ @Character @Item @Etc
% @Place @Parent @SuperParent
@ Date/time expression as supported
& This is how you start scenes off.
& All annotations start with a symbol at the very beginning of a line.
& - The = symbol declares the scene (with a tag and a list of categories),
&   allowing the scene to be referenced later.
& - The + symbol declares what characters and items are present.
&   This allows us to do consistency checks.
& - The % symbol declares the place in a hierarchical list.
&   Such place annotations will be used to build the map.
& - The @ symbol allows you to enter a date/time expression (single moment or
&   range) as defined by your renderer.
& Finally, the & allows you to enter scene-relevant text and notes.
& Formatting /is/ permitted within notes.

# Formatting includes ####################

/italic/
*bold*
~sub~
~sup~
`code`
$math$
/and, *of course, `nesting`*/.

> You may also make block quotes,
> also with /nesting/, by leading the line with a >.
> Quotes may be followed immediately by a hyphen-signaled
- attribution

Three or more stars, separated by zero or more spaces, denote a horizontal rule:
* * * *

Three blank lines or dashes separated as above denote an unruled line break:
- - - -

All special characters can be \*escaped\*.

You may use an escaped space \  as a no-op if you need to trick the parser.
(For example if you want to close a mode on a new line, but don't want to
start a block quote, you can start the new line with
\ >)

- - - -

# Comments ###############################

There are three types of comments:
{! TODOS which get recorded in a TODO file in your wiki !}
{- Notes, which may get recorded depending upon your settings -}
{# And comments, which may span multiple lines and are
   completely stripped and ignored from your text. #}


# Advanced Options #######################

{+ you/may/include/files/with | pipe | separated | arguments +}
How different file types are treated is implementation dependant.


You may make assertions. For example, we could assert that
|@SomeEvent occurred on=January 1^st^|. This will output the text "January 1^st^"
and also use your date/time parser to assert that @SomeEvent occurred on Jan 1.
If you mark dates and times in your text that are subject to change then these
assertions will let you know exactly what to change when you shuffle your
timeline around. They are also used to create the timeline initially, i.e. if
storyteller has never heard of @SomeEvent before, we now know that it occurred
on Jan 1 and will enforce that.

[1|You can include footnotes with this syntax.]
[*|They don't need to be numbers.]
[|You can even leave them off for auto-numbering.]

[@HashTag|
  By providing a hashtag, you may also mark the text not as a footnote but
  as a block of text that should be included in the wiki for that tag (i.e. the
  description of a character or item.) The text will be output as if unannotated
  but will also appear in the wiki under that hashtag.]

Finally, you can include special text modes as supported by your renderer.
For instance, if your renderer defines the 'verse' mode, you could have:

<verse|
    There once was a man from Nantucket,
    With a … you get the idea.>

If supported, you can use special formatting options in the mode, such as

<size=200 font="some font"|Big text in different fonts.>

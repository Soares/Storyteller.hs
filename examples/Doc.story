# Hashes denote a scene header.
## The number of leading hashes denotes the header level.
### For aesthetic purposes, trailing hashes are ignored ########################
= @Tag #cat1 #cat2
+ @Character @Item @Etc
% @Place @Parent @SuperParent
@ Date/time expression if supported
& This block of text denotes a scene.
& Scenes can have #headers, =declarations, +appearances, %places, @times, and,
& of course, &notes.
& All these annotations will be combined into a scene block.
& So long as your headers are increasing sequentially in depth, they are
& all part of the same scene (as above). If there are blank lines between them
& or if they do not progress sequentially, they are different scenes.
& No single attribution is required to start a scene, any may be omitted.
& =declarations are followed by at most one hash tag and a list of categories.
&  this allows the scene to be referenced later.
& +appearances are followed by a list of hash tags of characters, items, etc.
&  that are present in the scene, allowing for consistency checks.
& %places are followed by a hierarchical list of places, used to make the map.
&  (i.e. % @WashingtonDC @UnitedStates)
& @times are parsed by your chosen date/time parser, if supported. They may
&  support a range or a single moment, depending upon your parser.
& Finally, &notes allow you to enter scene-relevant text and notes.
& Formatting /is/ permitted within notes.

# Text Formatting ##############################################################

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

Dashes separated as above denote an unruled line break:

- - - -

Three blank lines not followed by a new scene also denote an unruled line break:



All special characters can be \*escaped\*.

You may use an escaped space \  as a no-op if you need to trick the parser.
(For example if you want to close a mode on a new line, but don't want to
start a block quote, you can start the new line with
\ >)

- - - -

# Comments and Notes ###########################################################

There are three types of comments:
{! TODOS which get recorded in a TODO file in your wiki !}
{- Notes, which may get recorded depending upon your settings -}
{# And comments, which may span multiple lines and are
   completely stripped and ignored from your text. #}


# Advanced Options #############################################################

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

# Comment Gotchas ##############################################
= @Scenes #have {-comment support-}
{! Todos can be {! Nested !} !}
{- Notes can be {- Nested -} -}
{# Comments can be
  both multi-line
  and {# nested #}
#}


# Syntax Gotchas ###############################################
- Attributions only come after quotes.
/italic *bold*/
*bold /italic/*
~nesting /italic *and bold*/~
/nesting italic *bold ^coloring^*/
\/ \* \^ \~ \` \$ \= \% \@ \& \| \[ \] \{ \} \<


# Directive Gotchas ############################################
[1| Nested [2| footnotes]]
[footnotes \| with pipes| are pretty cool.]
<nested| <modes| are> possible>

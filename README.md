# Tell Stories #

Storyteller is a tool for writing stories. It provides a few things:

- A language (similar to markdown) suited for telling stories.
- A compiler to turn those files into PDFs, EPUBs, or other file types.
- A system to read your annotations and help you build a wiki.

The story language itself is similar to markdown (see the [examples/](https://github.com/Soares/Storyteller.hs/tree/master/examples/Doc.story) directory)
but also allows a few types of annotations:

- Scene annotations. Scenes can me marked with:
  - Hashtags naming them
  - Categories describing them
  - Characters who are present
  - A place and a time
  - Notes
- Text assertions.

Storyteller will build a timeline from your scenes and annotations and make sure
that everybody can physically be in the right place at the right time. It will
also build you a timeline, a hierarchical tree of locations, and the beginnings
of a wiki that knows about your characters, events, and locations.

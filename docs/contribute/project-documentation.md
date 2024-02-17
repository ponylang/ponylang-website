# Project Documentation

Documentation is the lifeblood of an Open Source project. It makes it easier to get new users up and running with the language. Our ability to grow Pony usage will be directly tied to the quality and breadth of our documentation. Assisting with adding documentation for Pony is a great way to get started helping out with Pony.

## Standard Library Documentation Improvements

* Add documentation in the form of docstrings to the standard libraries
* Add examples of usage to package level docstrings

## Generated Documentations Improvements

The current generated documentation is hard to parse and could use a facelift in terms of layout and formatting. In addition to changes that would impact the content layout itself,  the MkDocs theme that is currently used has issues with the sidebar functioning in a very frustrating fashion. It doesn't keep the sidebar focused on content you are viewing. It doesn't highlight the correct menu item if you deep link into documentation. And several other issues as well. Lastly, generated documentation isn't online. New pony users have to get pony installed and generate the documentation themselves. That results in multiple hurdles.

We want to:

* Get docs building automatically on each commit and hosted at ReadTheDocs.
* Switch to the Read the docs theme that solves the sidebar issues (MkDocs is a pale imitation)
* Improve the layout and formatting of documentation itself.

## Improving Examples

The examples that come with Pony are often not idiomatic. One of the ways people are going to learn is to copy code from examples into what they are trying to accomplish. It behooves us to make sure that the examples are of the highest quality. Idiomatic, with comments, without performance anti-patterns etc. We need to undertake a general cleanup of existing examples and writing up a guide for people looking to contribute other examples.

## Improving the Tutorial

There's plenty that people bring up as needing improvement/missing from the Tutorial.

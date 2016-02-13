# statocles-plugin-hierpage
A Hierarchical Page list plugin for Statocles.

Eventually to possibly be Statocles::Plugin::HierPage

Inspired by my [circa-2009 WordPress plugin](https://wordpress.org/plugins/hierarchical-pages/)

When called, by default this will return an HTML series of nested `<ul>/<li>` elements
describing the site structure as seen from 'here,' the current document.  List items will be tagged
according to their relative location from here.

Optionally, documents containing multiple named anchors will have a list of those anchors,
which will only be emitted within that document itself. See [note](http://stackoverflow.com/questions/5319754/cross-reference-named-anchor-in-markdown) on
defining named anchors in Markdown.

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

In `_save_pagelist`,

    map { $_->{type} eq 'text/html' ? ref $_->{app} : () } @{$args[0]->{pages}}

produces, e.g., `Statocles::App::Blog`

    join(',', sort map { $_->{type} eq 'text/html' ? keys %{$_} : () } @{$args[0]->{pages}})

produces

    _links,_pages,app,data,date,document,layout,markdown,path
    search_change_frequency,search_priority,site,
    template,title,type

while

    map { $_->{type} eq 'text/html' ? scalar $_->{path}->stringify : () } @{$args[0]->{pages}}

produces an array containing `'/blog/index.html'`.

Also,
        
    map { (ref $_->app) . " : " . $_->path . " : " . $_->document->title } grep { $_->isa( 'Statocles::Page::Document' ) } @{$site->pages}  
    0  'Statocles::App::Basic : /index.html : Main Page'
    1  'Statocles::App::Blog : /blog/2016/02/16/first-post/index.html : First Post'
    2  'Statocles::App::Basic : /pagexx/another.html : Another Page'

Could derive 'app name' with `((ref $_->app) =~ s/Statocles::App:://r`

== Debugging ==

I used this command line:

    $ perl -d -I /home/my/path/to/statocles-plugin-hierpage/lib `which statocles` build



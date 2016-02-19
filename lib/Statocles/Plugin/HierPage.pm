
package Statocles::Plugin::HierPage v0.0.01 {

    # use Moo; # or Moose, or ...
    use Statocles::Base 'Class';
    with 'Statocles::Plugin';
 
    # If site-configurable parameters are needed, add them here; in site.yml,
    # use setup like:
    #   hierpage:
    #       $class: 'Statocles::Plugin::HierPage'
    #       $args:
    #           - app: 'MyPage'
    # -- For now, this is commented out.
    # has app => (
    #             is => 'ro',
    #             isa => Str,
    #             default => sub { 'Plain' },
    #            );
    
    my $_ugly_hack;

    sub _save_pagelist {
        my ( $self, $site, @args ) = @_;

        # For now, set a debugger breakpoint so we can examine everything.
        # $DB::single = 1;        # XXX
        $_ugly_hack = $site->pages;

    }

    sub pagelist {
        my ( $self, $args, @helper_args ) = @_;
        # $args is a hash containing:
        #   app    The current app, e.g., "Statocles::App::Basic"
        #   doc    The current document, e.g., of class Statocles::Document
        #   page   The current page, e.g., of class Statocles::Page::Document
        #   self   Depends on template in use; for a document, same as 'doc' above.
        #   site   The current site, e.g., of class Statocles::Site
        # @helper_args is the list of argument passed from the template
 
        # At this point, we can use info about the current-being-built
        # page.  Within a page we can say » $self->page « but here we
        # need » $args->{page} « , e.g.:
        #   $args->{page}->document->path    = "/index.markdown"  # the source file
        #   $args->{page}->path              = "/index.html"      # file to be created
        #   ref $args->{page}->app           = "Statocles::App::Basic" # active App for this page

        # For now, set a debugger breakpoint so we can examine everything.

        # Find the app that created this page / document
        my $this_page_app = ref $args->{page}->app; # Statocles::App::Basic
        my $this_doc_class = ref $args->{page};     # Statocles::Page::Document

        # Find all the documents, of our same class, created with this page's app
        # XXX TODO: Use site's cached page list
        my @app_page_list = grep { defined $_->app && $_->app->isa( $this_page_app ) }
          @{$_ugly_hack}; # TODO: @{$args->pages};
        $DB::single = 1;   # XXX

        # NOTE: When finding document nesting levels, consider
        # $_->app->url_root although '/' is usually the site's root

        my $page_info = join ( "\n",
                               sort                # XXX asciibetically by href url, eww
                               map { '   * <a href="' . $_->path . # $_->site->url($_->path) .
                                       '">' . $_->document->title . "</a>" }
                               grep { $_->isa( $this_doc_class ) } @app_page_list
                             );

        return $page_info ;

    }

    sub register {
        my ( $self, $site ) = @_;
        # We register our event handlers and theme helpers:
        $site->theme->helper( pagelist => sub { $self->pagelist( @_ ) } );
        $site->on( before_build_write => sub { $self->_save_pagelist( @_ ) } );
        return $self;
    }

};

1;

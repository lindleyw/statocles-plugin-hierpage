
package Statocles::Plugin::HierPage v0.0.01 {

    # use Moo; # or Moose, or ...
    use Statocles::Base 'Class';
    with 'Statocles::Plugin';
 
    sub register {
        my ( $self, $site ) = @_;
        # Register things like event handlers and theme helpers
    }
 
    sub pagelist {
        my ( $self, $args, $type, $text ) = @_;
 
        # Handle Mojolicious begin/end
        if ( ref $text eq 'CODE' ) {
            $text = $text->();
            # begin/end starts with a newline, so remove it to prevent too
            # much top space
            $text =~ s/^\n//;
        }
 
        # XXX We need to normalize this so that the current page is always
        # `$args->{page}`
        my $page = $args->{page} || $args->{self};
        if ( $page ) {
            # TODO Add cleverness here.
            # For now, set a debugger breakpoint so we can examine everything.
            $DB::single = 1;
        }
    }

};

1;

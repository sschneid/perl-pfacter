package Pfacter::puppetversion;

#

sub pfact {
    my $self  = shift;
    my ( $p ) = shift->{'pfact'};

    my ( $r );

    for ( $p->{'kernel'} ) {
        /AIX|Linux/ && do {
            if ( -e '/usr/bin/puppet' ) {
                open( F, '/usr/bin/puppet -V |' );
                foreach ( <F> ) { $r = $1 if /^(\d.*)$/; last; }
                close( F );
            }
        };

        if ( $r ) { return( $r ); }
        else      { return( 0 ); }
    }
}

1;

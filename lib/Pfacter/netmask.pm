package Pfacter::netmask;

#

sub pfact {
    my $self  = shift;
    my ( $p ) = shift->{'pfact'};

    my ( $r );

    for ( $p->{'kernel'} ) {
        /Darwin/ && do {
            my ( $c );

            $c = '/sbin/ifconfig -a |' if -e '/sbin/ifconfig';

            if ( $c ) {
                open( F, $c );
                my ( @F ) = <F>;
                close( F );

                my ( $d, @i );

                foreach ( @F ) {
                    $d = $1 if /^(\w+)\:/;

                    if ( /netmask\s+0x([\da-fx]+)/ ) {
                        push @i, "$d=" . join( '.', map { hex } unpack( '(A2)*', $1 ) );
                    }
                };

                $r = join ' ', sort @i;
            }
        };

        /Linux/ && do {
            if ( -e '/sbin/ifconfig' ) {
                open( F, '/sbin/ifconfig -a |' );
                my ( @F ) = <F>;
                close( F );

                my ( $d, @i );

                foreach ( @F ) {
                    $d = $1 if ( /^(\w+)\s+/ || /^(\w+:\d+)\s+/ );
                    push @i, "$d=$1" if /Mask:(\d+\.\d+\.\d+\.\d+)/;
                }

                $r = join ' ', sort @i;
            }
        };

        if ( $r ) { return( $r ); }
        else      { return( 0 ); }
    }
}

1;

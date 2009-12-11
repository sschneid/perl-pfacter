package Pfacter;

our $VERSION = '1.14';

sub modulelist {
    my $self   = shift;
    my $kernel = shift;

    my @modules = qw(
    
        architecture
        disk
        domain
        filesystems
        fqdn
        hardwaremanufacturer
        hardwaremodel
        hardwareplatform
        hardwareproduct
        hostname
        ipaddress
        kernel
        kernelrelease
        kernelversion
        localtime
        macaddress
        memory
        memorytotal
        netmask
        operatingsystem
        processor
        processorcount
        productid
        serialnumber
        swap
        uniqueid

    );

    # Kernel-specific
    for ( $kernel ) {
        /Linux/ && do {
            push @modules, qw(

                lsbcodename
                lsbdescription
                lsbid
                lsbrelease

            );
        };
    }

    # Application-specific
    if ( -e '/var/cfengine/bin/cfagent' ) {
        push @modules, qw(

            cfclasses
            cfversion

        );
    }

    if ( -e '/usr/bin/puppet' ) {
        push @modules, qw(

            puppetversion

        );
    }

    return sort @modules;
}

1;

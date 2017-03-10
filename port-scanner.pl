#!/usr/bin/perl
use strict;
use IO::Socket::PortState qw(check_ports);
my $hostfile = 'hosts.txt';
my %port_hash = (
        tcp => {
            21      => {},
            22      => {},
            25      => {},
            80      => {},
            }
        );
        my $timeout = 5;
        open HOSTS, '<', $hostfile or die "Cannot open $hostfile:$!\n";
        while (my $host = <HOSTS>) {
                chomp($host);
                my $host_hr = check_ports($host,$timeout,\%port_hash);
                print "Host - $host\n";
                for my $port (sort {$a <=> $b} keys %{$host_hr->{tcp}}) {
                        my $status = $host_hr->{tcp}{$port}{open} ? "open" : "closed";
                        print "$port - $status\n";
                }
        }
        print "\n";
}

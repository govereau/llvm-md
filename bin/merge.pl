#!/usr/bin/perl -w

die "bad args $#ARGV" if ($#ARGV < 2);

my $orig    = $ARGV[0];
my $new     = $ARGV[1];
my $results = $ARGV[2];

# find out which functions we want from optimized
my %opt;

open FUNCS, $results or die $!;
while (<FUNCS>) {
    if (/OK (.*)$/) {
        $opt{$1} = "";
    }
}
close FUNCS;

# collect optimized functions to use

open OPT, $new or die $!;
while (<OPT>) {
    my $line=$_;
    if ($line =~ /^define .+@(.+)\(/) {
        my $f = $1;
        my $body = $line;
        while (<OPT>) {
            $body .= $_;
            last if (/^\}/);
        }
        $opt{$f} = $body if exists $opt{$f};
    }
    #print($line);
}
close OPT;

# build output file

open UNOPT, $orig or die $!;
while (<UNOPT>) {
    my $line=$_;
    if ($line =~ /^define .+@(.+)\(/) {
        my $f = $1;
        my $body = $line;
        while (<UNOPT>) {
            $body .= $_;
            last if (/^\}/);
        }
        if (exists $opt{$f}) {
            print(";;;;REPLACED $f\n$opt{$f}\n");
        } else {
            print($body);
        }
    } else {
        print $line
    }
}
close UNOPT;

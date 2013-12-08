#!/usr/bin/perl

use 5.010;
use strict;
use warnings;

# Usage: ./convert.pl src.htm > dest.csv
# Author: Seth Rainsdon srainsdon@nunetnetworks.net
# This pulls a table out of a html file and turns it in to a csv

sub prt
{
	print "@_";
	print OUTFILE "@_";
}

my ($src, $dest) = @ARGV;
my $newline = 1;
 open (INFILE, $src);
 open (OUTFILE, $dest);
 while (<INFILE>) {
 	chomp;
 	my $input = $_;
 	if ($input =~ m/<td>/) {
		$input =~ s/<t[dh][>]*>|<\/t[dh]>//g;
		$input =~ s/^\s+|\s+$//g ;     # remove both leading and trailing whitespace;
		if ($newline) {
			&prt("$Date, $input");
			$newline = 0;
		} else {
			&prt(", $input");
		}
	}
	elsif ($input =~ m/<\/tr>/) {
		&prt("\n");
		$newline = 1;
	}
 close (INFILE);
 close (OUTFILE);

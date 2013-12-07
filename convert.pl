#!/usr/bin/perl

use 5.010;
use strict;
use warnings;

# Usage: ./convert.pl src.htm > dest.csv

# Author: Seth Rainsdon srainsdon@nunetnetworks.net

# This pulls a table out of a html file and turns it in to a csv

my ($src, $dest) = @ARGV;
my $newline = 1;
 open (INFILE, $src);
 while (<INFILE>) {
 	chomp;
 	my $input = $_;
 	if ($input =~ m/<td>/) {
		$input =~ s/<t[dh][>]*>|<\/t[dh]>//g;
		$input =~ s/^\s+|\s+$//g ;     # remove both leading and trailing whitespace;
		if ($newline) {
			print "$input";
			$newline = 0;
		} else {
			print ", $input";
		}
	}
	elsif ($input =~ m/<\/tr>/) {
		print "\n";
		$newline = 1;
	}
	
 }
 close (INFILE);
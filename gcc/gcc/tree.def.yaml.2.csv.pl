use strict;
use warnings;
#use YAML;
use YAML::Syck;

use Data::Dumper;

my $file = shift @ARGV;

warn "reading file $file";

# Load a YAML stream of 3 YAML documents into Perl data structures.
my $hashref;

$hashref = LoadFile($file);


print Dumper($hashref);

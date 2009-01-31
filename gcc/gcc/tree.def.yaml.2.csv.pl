use strict;
use warnings;
#use YAML;
use YAML::Syck;
use Data::Dumper;


my $debug =0; # if you want a report, just set this to 1
my $file = shift @ARGV;



# Load a YAML stream of 3 YAML documents into Perl data structures.
my $hashref;

## load the yaml
$hashref = LoadFile($file);

# the key to the data set
my $data_key = $hashref->{'infochimps_schema'}{'data_key'};

# the names of the fields
my @data_fields = map {$_->{'name'} } @{$hashref->{'infochimps_schema'}{'fields'}};

# the data itself
my $data = $hashref->{$data_key};

# the key of the data
my @keys = sort keys %{$data};

### report
if ($debug)
{
    warn "reading file $file";
    warn Dumper($hashref);
    warn "Data Key is $data_key\n";
    warn "Data Fields are " . join (",",@data_fields) . "\n";
    warn "Keys  " . join ",",@keys;
}

################################
my  @row;
foreach my $f (@data_fields)
{    
    push @row,'"'.$f. '"';
}
my $line = join ",",@row;
print "$line\n";
################################

# print the data
foreach my $key (@keys)
{
    my $obj = $data->{$key}; 
    my  @row;
    foreach my $f (@data_fields)
    {
	my $data='"'.$obj->{$f}. '"';
#	warn "$f : $data" . Dumper($obj);
	push @row,$data;
    }
    my $line = join ",",@row;
    print "$line\n";
}
#################################

use strict;
use warnings;
use YAML;

##
use constant COMMENT_BEG =>1;
use constant COMMENT_END =>COMMENT_BEG+1;
use constant DEFINED     =>COMMENT_END+1;
use constant CONTINUE    =>DEFINED +1;

our $state=0;
our $save="";
our $comment = ""; #save the last comment seen

sub Print 
{
}

sub State
{

    my $mstate=shift;
    Print "state is now $mstate ->" . $state .  " . $_ \n";
    $state=$mstate;

}

sub StateIs
{
    if ($state == shift)
    {
	return 1;
    }
}

# emit the current line
sub Emit
{

    my $content = $save . $_;

    Print "Comment:$comment" ;
    Print "Content:$content" ;

    die unless  $comment =~ s/^\/\*\s*//g;
    die unless  $comment =~ s/\s*\*\/$//g;

    

    if ($content =~ s/DEFTREECODE \(//g)
    {

	if ($content =~ s/\)$//g)
	{   
	    my @parts = split(",",$content);
	    
	 #   warn "check this ". 
#		join ("\n",@parts);

	    my $node_type_id       = shift @parts;
	    my $node_type_code     = shift @parts;
	    my $node_type_class    = shift @parts;
	    my $node_type_op_count = shift @parts;
	    
	    $node_type_code  =~ s/\"//g;
	    $node_type_class =~ s/\s+//g;
	    $node_type_op_count =~ s/\s+//g;
	    $node_type_code  =~ s/\s+//g;

	    # ' TARGET_OPTION_NODE.
	    $comment =~ s/ ${node_type_id}.\s+//g; # remove the stuff

# now we create a nice nodetype
	    my $node_type = 	    {
		node_type_id       => $node_type_id,
		node_type_code     => $node_type_code,
		node_type_class    => $node_type_class ,
		node_type_op_count => $node_type_op_count,
		comment            => $comment
	    };

	    
	    print Dump($node_type) . "\n";

	    State(COMMENT_BEG);
	    $save="";
	    $comment="";
	}
    }
    else
    {
	die "problem $content";
    }
}


sub AddComment
{
    return if /^\s*$/;
    Print "Adding comment :$_";
    $comment .= $_;

}

while (<>)
{
    
    chomp;

    if (/\/\*/)
    {
	State(COMMENT_BEG);
	$comment="";
	AddComment;

	if (/\*\//)
	{
	    State(COMMENT_END); # one line comments just end them
	    
	}    

	next;
    }

    if (StateIs(COMMENT_BEG))
    {
	Print "Comment $_\n";
	AddComment;
	next;

    }

    if (/\*\//)
    {
	State(COMMENT_END);
	AddComment;
	next;
    }    

    elsif (StateIs(CONTINUE))
    {
	Print "Check";
	if (/(\.+)\)/)
	{
	    my $val = $1;
	    Print "finish " . $1 . $save;
	    Print "got one $1 " . join (":",@_) . "\n";
	    Emit();
	    next;
	}
	elsif (/(.+)\)/)
	{
	    Print "finish " . $1 . $save;
	    Print "got one $1 " . join (":",@_) . "\n";
	    Emit();
	    next;
	}
	elsif (/^\s*$/)
	{
	}
	else
	{
	    die "unknown \"$_\"";
	}
    }    
    elsif (StateIs(COMMENT_END))
    {

	#    DEFTREECODE (ERROR_MARK, "error_mark", tcc_exceptional, 0)
	if (/DEFTREECODE\s+\((.+)\)/)
	{
	    my $val = $1;
	    #(\+w),\s+\"(\w+)\",\s+(\w+),\s+(\d+)

	    Print "got one $1 " . join (":",@_) . "\n";

	    Emit();
	    next;
	}
	elsif (/DEFTREECODE\s+\((.+)\\$/)
	{
	    my $val = $1;


	    State(CONTINUE);
	    $save = $_;
	    Print "continue one $1 " . join (":",@_) . "\n";
	    next;
	}
	elsif (/DEFTREECODE\s+\((.+)\s*,\s*$/)
	{
	    my $val = $1;
	    #(\+w),\s+\"(\w+)\",\s+(\w+),\s+(\d+)

	    State(CONTINUE);
	    $save = $_;
	    Print "continue one $1 " . join (":",@_) . "\n";
	    next;
	}



	if (/^\s*$/)
	{
	    next;   
	}
	else
	{
	    die "ELSE :$_";
	}
    }
}

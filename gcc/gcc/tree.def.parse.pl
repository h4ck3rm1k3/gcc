use strict;
use warnings;

##
use constant COMMENT_BEG =>1;
use constant COMMENT_END =>COMMENT_BEG+1;
use constant DEFINED     =>COMMENT_END+1;
use constant CONTINUE    =>DEFINED +1;

our $state=0;

sub State
{
    $state=shift;
    warn "state is now " . $state .  " -> $_";
}

sub StateIs
{
    if ($state == shift)
    {
	return 1;
    }
}

while (<>)
{
    
    if (/\/\*/)
    {
	State(COMMENT_BEG)
    }

    if (StateIs(COMMENT_BEG))
    {
	warn "Comment $_";
    }

    if (/\*\//)
    {
	State(COMMENT_END)
    }    
    elsif (StateIs(CONTINUE))
    {
	if (/(\.+)\)/)
	{
	    my $val = $1;
	    warn "got one $1 " . join ":",@_;
	    State(COMMENT_BEG);
	    next;
	}
    }    
    elsif (StateIs(COMMENT_END))
    {

	#    DEFTREECODE (ERROR_MARK, "error_mark", tcc_exceptional, 0)
	if (/DEFTREECODE\s+\((.+)\)/)
	{
	    my $val = $1;
	    #(\+w),\s+\"(\w+)\",\s+(\w+),\s+(\d+)

	    warn "got one $1 " . join ":",@_;
	    State(COMMENT_BEG);

	    next;
	}
	elsif (/DEFTREECODE\s+\((.+)\\$/)
	{
	    my $val = $1;
	    #(\+w),\s+\"(\w+)\",\s+(\w+),\s+(\d+)

	    State(CONTINUE);

	    warn "continue one $1 " . join ":",@_;
	    next;
	}
	elsif (/DEFTREECODE\s+\((.+)\s*,\s*$/)
	{
	    my $val = $1;
	    #(\+w),\s+\"(\w+)\",\s+(\w+),\s+(\d+)

	    State(CONTINUE);

	    warn "continue one $1 " . join ":",@_;
	    next;
	}



	if (/^\s+$/)
	{
	    next;   
	}
	else
	{
	    die "ELSE :$_";
	}
    }
}

use strict;
use warnings;
use YAML;

##
use constant COMMENT_BEG =>1;
use constant COMMENT_END =>COMMENT_BEG+1;
use constant DEFINED     =>COMMENT_END+1;
use constant CONTINUE    =>DEFINED +1;

our $enumeration_constant=0; #  By default, the first enumeration-constant is associated with the value 0
our $state=0;
our $save="";
our $comment = ""; #save the last comment seen

# schema is the global hash of all data
# so that we can dump it all at once
our $schema = 

     {
	 'infochimps_schema' => {
	     'name' => 'GCC Introspector Node Types dataset',
	     'collection' => 'Introspector Abstract Tree Definitions from Compilers',
	     'tags' => 'gcc gnu compiler "gnu compiler collection" tree introspector tree.def treenodes ast node type ',
	     'formats' => {
		 'yaml' => {}
	     },
	     'contributors' => [
		 {
		     'desc' => '',
		     'uniqid' => 'gcc.gnu.org/source/gcc/gcc/tree.def',
		     'url' => 'http://github.com/h4ck3rm1k3/gcc/blob/898602f91e4b37358dfe27f5522f3905e463b5fa/gcc/gcc/tree.def',
		     'name' => 'GccCompilerAuthors',
		     'role' => 'source',
		     'cite' => 'GCC Compiler Authors,"http://gcc.gnu.org":http://gcc.gnu.org'
		 },
		 {
		     'uniqid' => 'org.sf.introspector/h4ck3rm1k3',
		     'url' => 'http://www.linkedin.com/in/jamesmikedupont',
		     'name' => 'James Michael DuPont',
		     'role' => 'converted'
		 }
                                                       ],
                                     
	     'data_key' => 'node_type_id',

	     'fields' => [

		 {
		     'uniqid' => 'node_type_id',
		     'name' => 'node_type_id',
		     'col_num' => 1,
		     'datatype' => 'name',
		     'units' => 'name',
		     'key_field' => 1, # this is the key
		     'tags' => 'node_type_id KEY '
		 },

		 {
		     'col_num' => 2,
		     'uniqid' => 'node_type_code',
		     'name' => 'node_type_code',
		     'datatype' => 'name',
		     'units' => 'name',
		     'tags' => 'node_type_code'
		 },

		 {
		     'col_num' => 3,
		     'uniqid' => 'node_type_class',
		     'name' => 'node_type_class',
		     'datatype' => 'class name',
		     'units' => 'class',
		     'tags' => 'node_type_class'
		 },
		 
		 
		 ##enumeration_constant
		 {
		     'col_num' => 4,
		     'uniqid' => 'enumeration_constant',
		     'name' => 'enumeration_constant',
		     'datatype' => 'int',
		     'units' => 'int',
		     'tags' => 'enum value'
		 },
		  
		 {
		     'col_num' => 5,
		     'uniqid' => 'node_type_op_count',
		     'name' => 'node_type_op_count',
		     'datatype' => 'int',
		     'units' => 'operand count',
		     'tags' => 'number of operands'
		 },

		 {
		     'col_num' => 6,
		     'uniqid' => 'comment',
		     'col_num' => 5,
		     'name' => 'comment',
		     'datatype' => 'text',
		     'units' => 'text',
		     'tags' => 'comment'
		 },


		 ],
	     
# 	     'ratings' => {
# 		 'interesting' => {
# 		     'story' => '',
# 		     'by' => 'initial',
# 		     'rating' => '3'
# 		 },
# 			 'comprehensive' => {
# 			     'story' => '',
# 			     'by' => 'initial',
# 			     'rating' => '3'
# 		     },
# 				 'authoritative' => {
# 				     'story' => '',
# 				     'by' => 'initial',
# 				     'rating' => '3'
# 			     },
# 					 'accurate' => {
# 					     'story' => 'These files have not been checked for conversion errors.',
# 					     'by' => 'initial',
# 					     'rating' => '3'
# 				     }
# 	     },


                                     'notes' => {
                                                  'rights' => 'The data is derived from the GCC Compiler collection and provided under
the same licenses as the compiler itself. GPLv3',
                                                  'usage' => 'We want to have an RDF/OWL ontology for this
',
                                                  'collection_desc' => 'The compilers have many different abstract syntax trees. 
We want to catalog them',
                                                  'desc' => 'For each tree node type defined we have a row.
There are more subclasses and class relationships not shown here yet.
We want to create a class for each codepath in the compiler'
                                                },
                                     'uniqid' => 'GnuGccIntrospectorTreeDefinitionsNodeTypes',
                                     'coll_tags' => 'Compiler abstract tree definitions ',
                                     'coll_uniqid' => 'IntrospectorAbstractTreeDefinitionsFromCompilers'
                                   }
     }
    ;


sub Print 
{
    # just ignore the debug prints
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
		comment            => $comment,
		enumeration_constant => $enumeration_constant++
	    };

	$schema->{node_type_id}->{$node_type_id}=$node_type;

	    
#	    print Dump($node_type) . "\n";

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



print Dump($schema) . "\n";

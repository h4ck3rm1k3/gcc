grep  -B1 -A15 'enum tree_code_class {' ../tree.h > gcc_tree_code_class.h
swig -xml -module tree_code_class   gcc_tree_code_class.h

xsltproc --param ontology_date "'`date --rfc-3339=ns`'" --param ontology_uri "'http://github.com/h4ck3rm1k3/gcc/blob/6016b34cf3bd51bd3ca9119ada10e507b6507c2f/gcc/gcc/grddl/swig_tree.h.enum.tree_code_class.owl'"  --param ontology_name "'gcc tree.h enum tree_code_class '" --param ontology_acronym "'GCCTTCS'"  extract_enum.xsl  gcc_tree_code_class_wrap.xml > swig_tree.h.enum.tree_code_class.owl




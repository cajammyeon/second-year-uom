package comp26120;

public class bstree implements set<String> {
    int verbose;

    String value;
    bstree left;
    bstree right;

    speller_config config;

    // TODO add fields for statistics

    public bstree(speller_config config) {
	verbose = config.verbose;
	this.config = config;
    }

	
    public int size(){
	// This presumes that if value is not null then (possibly empty) left and right trees exist.
	if(tree()){
	    return 1 + left.size() + right.size();
	}
	return 0;
    } 

    public void insert (String value) 
    {
	if(tree()){
	    // TODO if tree is not NULL then insert into the correct sub-tree
	}
	else{
	    // TODO otherwise create a new node containing the value and two sub-trees.
	}
    }

    public boolean find (String value)
    {
	if(tree()){
	    //TODO complete the find function
	}
	// if tree is NULL then it contains no values
	return false;
    }

    private boolean tree() {
	return (value != null);
    }

    // You can update this if you want
    public void print_set ()
    {
	// TODO update code to print binary tree.
    }

    public void print_stats ()
    {
	// TODO update code to record and print statistics
    }
}

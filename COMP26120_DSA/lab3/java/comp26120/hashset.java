package comp26120;

public class hashset implements set<String> {
    int verbose;
    HashingModes mode;

    speller_config config;

    String[] cells;
    int size;
    int num_entries; // number of cells in_use

    // TODO add any other fields that you need

    public hashset(speller_config config) {
	verbose = config.verbose;
	mode = HashingModes.getHashingMode(config.mode);

	// TODO: create initial hash table
	
    }

    // Helper functions for finding prime numbers 
    public boolean isPrime (int n)
    {
	for (int i = 2; i*i <= n; i++)
	    if (n % i == 0)
		return false;
	return true;
    }

    public int nextPrime(int n)
    {
	int i = n;
	while (!isPrime(i)) {
	    i++;
	}
	return i;
    }

    public void insert (String value) 
    {
	// TODO code for inserting into hash table
    }

    public boolean find (String value)
    {
	// TODO code for looking up in hash table
	return false;
    }

    public void print_set ()
    {
	// TODO code for printing hash table
    }

    public void print_stats ()
    {
	// TODO code for printing statistic
    }

    // Hashing Modes

    public enum HashingModes {
	HASH_1_COLLISION_1, // =0 in mode flag
        HASH_1_COLLISION_2, // =1, 
        HASH_1_COLLISION_3, //=2, 
        HASH_2_COLLISION_1, // =3,
        HASH_2_COLLISION_2, // =4, 
        HASH_2_COLLISION_3; // =5, 

	public static HashingModes getHashingMode(int i) {
	    switch (i) {
	    case 1:
		return HASH_1_COLLISION_2;
	    case 2:
		return HASH_1_COLLISION_3;
	    case 3:
		return HASH_2_COLLISION_1;
	    case 4:
		return HASH_2_COLLISION_2;
	    case 5:
		return HASH_2_COLLISION_3;
	    default:
		return HASH_1_COLLISION_1;
	    }
	}
    }

    // Your code

   


}

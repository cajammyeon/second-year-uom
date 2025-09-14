package comp26120;

public class hashset implements set<String> {
    int verbose;
    HashingModes mode;

    speller_config config;

    String[] cells;
    int size;
    int num_entries; // number of cells in_use

    // TODO add any other fields that you need
    int collision;

    public hashset(speller_config config) {
	verbose = config.verbose;
	mode = HashingModes.getHashingMode(config.mode);

	// TODO: create initial hash table
	size = config.init_size;
	cells = initialise_cell_array();
    }

    private String[] initialise_cell_array() {
	String[] cell_array = new String[size];
	num_entries = 0;
	collision = 0;

	for (int i = 0; i < size; i++) {
	    cell_array[i] = null;
	}
	return cell_array;

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

    // h = x0*a^(k-1) + x1*a^(k-2) + ... + x(k-2)*a + x(k-1)
    // h = |ak + b| mod N
    public int hashFunc(String k, int N)
    {
	int temp = 1; int a = 41;
	int len = k.length();
	long h = 0;
	// System.err.format("%s, len: %d, k[%d]: %d%n\n", k, len, len - 1, h);
	for (int i = len - 1; i >= 0; i--){
	    int char_as_int = k.charAt(i);
	    h += char_as_int * temp;
	    // System.err.format("h += k[%d](%d) * %d, h = %d%n\n", i, (int) k.charAt(i), a, h);
	    temp *= a;
	}

	int h_int = (int) (Math.abs(h) % N);
	// System.err.format("%d\n", h_int);
	return h_int;
    }

    public int hashFunc2(String k, int N)
    {
	int len = k.length();
	int h = 0;
	for (int i = len - 1; i >= 0; i--) {
	    h += k.charAt(i);
	}
	int h_int = (int) (Math.abs(h) % N);
	return h_int;
    }

    // insertion

    private void insertCell(String k, int pos)
    {
	cells[pos] = k;
	num_entries ++;
	return;
    }

    private void rehash()
    {
	int N = size;
	int newSize = nextPrime(2*N);
	if (this.verbose > 2) {
	    System.out.println("Rehashing");
	    System.out.println("Current Set:");
	    this.print_set();
	}
	size = newSize;
	String[] old_cells = cells.clone();
	cells = initialise_cell_array();
	for(int i = 0; i < N; i++){
	    if(old_cells[i] != null) {
		insert(old_cells[i]);
	    }
	} 
	if (this.verbose > 2) {
	    System.out.println("New Set:");
	    this.print_set();
	}
    }

    boolean isLinearProbing(HashingModes mode){
	return mode == HashingModes.HASH_1_COLLISION_1 || mode == HashingModes.HASH_2_COLLISION_1;
    }

    boolean isQuadraticProbing(HashingModes mode){
	return mode == HashingModes.HASH_1_COLLISION_2 || mode == HashingModes.HASH_2_COLLISION_2;
    }

    boolean isDoubleHashing(HashingModes mode){
	return mode == HashingModes.HASH_1_COLLISION_3 || mode == HashingModes.HASH_2_COLLISION_3;
    }

    public void insert (String value) 
    {
	System.err.println("Entering insert:");
	System.err.println(value);
	if(find(value)) return; // detect duplicate

	int N = size;

	if(num_entries >= N/2) // check full table
	    rehash();

	N = size;
	int pos = hashFunc(value, N);

	// insert into empty cell
	if(cells[pos] == null) {
	    insertCell(value, pos);
	} else {
	    if (this.verbose > 2) {
		System.err.println("Collision Detected!");
	    }

	    if(isLinearProbing(mode)) // linear probing: A[(i+j)mod N]
		    {
			for(int j = 1; j < N; j++){
			    int look = (pos + j) % N;
			    collision ++;
			    if(cells[look] == null){
				insertCell(value, look);
				break;
			    }
			}
		    }
	    else if(isQuadraticProbing(mode)) // quadratic probing: A[(i+j^2)mod N]
		    {
			for(int j = 1; j < N; j++){
			    int look = (pos + j*j) % N;
			    if (look < 0)
				look = 0;
			    collision ++;
			    if(cells[look] == null){
				insertCell(value, look);
				break;
			    }
			}
		    }
	    else if(isDoubleHashing(mode)) // double hash: A[(i+j*h'(k))mod N] 
		    {
			int temp = hashFunc2(value, N);

			for(int j = 1; j < N; j++){
			    int look = (pos + j*temp) % N;
			    collision ++;
			    if(cells[look] == null){
				insertCell(value, look);
				break;
			    }
			}
		    }
	}
    }

    public boolean find (String value)
    {
	// TODO code for looking up in hash table
	int N = size;
	int pos = hashFunc(value, N);

	if(cells[pos] != null
	       && (cells[pos].compareTo(value) == 0))
		return true;

	else if(isLinearProbing(mode)) // linear probing
		{
		    for(int j = 1; j < N; j++){
			int look = (pos + j) % N;
			if(cells[look] == null)
			    return false;
			if(cells[look].compareTo(value) == 0) {
			    return true;
			}
		    }
		}
	    else if(isQuadraticProbing(mode)) // quadratic probing
		{
		    for(int j = 1; j < N; j++){
			int look = (pos + j*j) % N;
			if (look < 0)
			    look = 0;
			if(cells[look] == null)
			    return false;
			if(cells[look].compareTo(value) == 0){
			    return true;
			}
		    }
		}
	    else if(isDoubleHashing(mode)) // double hash
		{
		    int temp = hashFunc2(value, N);

		    for(int j = 1; j < N; j++){
			int look = (pos + j*temp) % N;
			if(cells[look] == null)
			    return false;
			if(cells[look].compareTo(value) == 0){
			    return true;
			}
		    }
		}
	return false;
    }

    public void print_set ()
    {
	 int i = 0;
	 for(; i < size; i++){
		 if(cells[i] != null)
		     System.out.format("Cell %5d: %s\n", i, cells[i]);
		 if(cells[i] == null)
		     System.out.format("Cell %5d: empty\n", i);
	 }

    }

    public void print_stats ()
    {
	System.out.format("Collision times: %d\n", collision);
	System.out.format("Entry number: %d\n", num_entries);
	System.out.format("Average collisions per access: %f\n", (double)collision / (double)num_entries);

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

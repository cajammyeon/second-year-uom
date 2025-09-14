public class FullyAssocCache extends Cache {
    int n_ignorebits;
    int n_tagbits;
    int l_number;
    int past_search;
    int remove_pointer;

    int[] tagField;
    boolean[] validData;
    Object[] dataField;

    FullyAssocCache(int csize, int lsize) {
        super();

        this.l_number = csize / lsize;
        this.n_ignorebits = (int) (Math.log(lsize) / Math.log(2));
        this.n_tagbits = (int) (32 - this.n_ignorebits);
        this.remove_pointer = 0;

        this.tagField = new int[this.l_number];
        this.validData = new boolean[this.l_number];
        this.dataField = new Object[this.l_number];

        // clear the validity field
        for (int i = 0; i < this.l_number; i++) {
            this.validData[i] = false;
        }

    }

    // use of bit shifting and masking to get the value of tag bits
    private int tagMask(int address) {
        return (address >> (this.n_ignorebits) & ((1 << this.n_tagbits) - 1));
    }

    private void update_pointer() {
        this.remove_pointer += 1;
        if (this.remove_pointer == this.l_number) {
            this.remove_pointer = 0;
        }
    }

    @Override
    public Object cacheSearch(int addr) {
        for (int i = 0; i < this.tagField.length; i++) {
            if ((this.tagField[i] == this.tagMask(addr))) { 
                if (this.validData[i]) {
                    this.past_search = i;
                }
                return this.dataField[i];
            } 
        }
        return null;
    }

    @Override
    public oldCacheLineInfo cacheNewEntry(int addr) {
        oldCacheLineInfo retVal = new oldCacheLineInfo();

        // save past state of the cache
        retVal.old_valid = this.validData[this.remove_pointer];
        retVal.data = this.dataField[this.remove_pointer];

        // insert new data into the cache - overwrite
        // validity true ? newly inserted : dirty line
        this.tagField[this.remove_pointer] = this.tagMask(addr);
        this.dataField[this.remove_pointer] = -1;
        this.validData[this.remove_pointer] = true;

        // update the pointer
        this.update_pointer();

        return retVal;
    }

    @Override
    public void cacheWriteData(Object entry) {
        // write into the field
        this.dataField[this.past_search] = entry;
    }
        
    
}
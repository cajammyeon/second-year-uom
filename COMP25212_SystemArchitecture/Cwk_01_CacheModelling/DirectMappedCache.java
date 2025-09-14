// import math for log calculation
import java.lang.Math;

public class DirectMappedCache extends Cache {
    int l_number;
    int n_indexbits;
    int n_ignorebits;
    int n_tagbits;
    int past_search;

    int[] tagField;
    boolean[] validData;
    Object[] dataField;

    DirectMappedCache(int csize, int lsize) {
        super();

        this.l_number = csize / lsize;
        this.n_indexbits = (int) (Math.log(this.l_number) / Math.log(2));
        this.n_ignorebits = (int) (Math.log(lsize) / Math.log(2));
        this.n_tagbits = (int) (32 - n_indexbits - n_ignorebits);

        this.tagField = new int[this.l_number];
        this.validData = new boolean[this.l_number];
        this.dataField = new Object[this.l_number];

        // clear the data validity field
        for (int i = 0; i < this.validData.length; i++) {
            this.validData[i] = false;
        }
    }

    // use of bit shifting and masking to get the value of index bits
    private int indexMask(int address) {
        return (address >> this.n_ignorebits) & ((1 << n_indexbits) - 1);
    }

    // use of bit shifting and masking to get the value of tag bits
    private int tagMask(int address) {
        return (address >> (this.n_ignorebits + this.n_indexbits) & ((1 << this.n_tagbits) - 1));
    }

    @Override
    public Object cacheSearch(int addr) {
        int locationInd = this.indexMask(addr);
        int locationTag = this.tagMask(addr);

        // value in tag field true ?
        // value is valid (unchanged) ?
        // return the data in that area
        if ((this.tagField[locationInd] == locationTag)) {
            if (this.validData[locationInd]) {
                this.past_search = locationInd;
            }
            return dataField[locationInd];
        } else {
            return null;
        }
    }

    @Override
    public oldCacheLineInfo cacheNewEntry(int addr) {
        int locationInd = this.indexMask(addr);
        int locationTag = this.tagMask(addr);
        oldCacheLineInfo retVal = new oldCacheLineInfo();

        // save the past state of the cache
        retVal.old_valid = this.validData[locationInd];
        retVal.data = this.dataField[locationInd];

        // insert new data into the cache
        // validity true ? newly inserted : dirty line
        this.tagField[locationInd] = locationTag;
        this.dataField[locationInd] = -1;
        this.validData[locationInd] = true;

        return retVal;
    }

    @Override
    public void cacheWriteData(Object entry) {
        // write into data
        this.dataField[this.past_search] = entry;
    }
      
    
}
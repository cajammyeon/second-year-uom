from enum import Enum
import config

class hashset:
    def __init__(self):
        # TODO: create initial hash table
        self.verbose = config.verbose
        self.mode = config.mode
        self.hash_table_size = config.init_size
        self.cells = self.initialise_cell_array()
        
    def initialise_cell_array(self):
        self.num_entries = 0
        self.collision = 0
        cells = []

        for i in range(self.hash_table_size):
            cells.append(None)
        return cells
        
                
    # Helper functions for finding prime numbers
    def isPrime(self, n):
        i = 2
        while (i * i <= n):
            if (n % i == 0):
                return False
            i = i + 1
        return True
        
    def nextPrime(self, n):
        while (not self.isPrime(n)):
            n = n + 1
        return n
        
    def hashFunc(self, k, N):
        temp = 1
        a = 41
        string_len = len(k)
        h = 0
        i = string_len - 1
        while i >= 0:
            h = h + ord(k[i]) * temp
            temp = temp * a
            i = i - 1
            
        h = abs(h) % N
        return h
        

    def hashFunc2(self, k, N):
        string_len = len(k)
        h = 0
        i = string_len - 1
        while i >= 0:
            h = h + ord(k[i]) 
            i = i - 1
            
        h = abs(h) % N
        return h
        
    # insertion
    
    def insertCell(self, k, pos):
        self.cells[pos] = k
        self.num_entries = self.num_entries + 1
        
    def rehash(self):
        N = self.hash_table_size
        newSize = self.nextPrime(2 * N)
        if (self.verbose > 2):
            print("Rehashing")
            print("Current Set:")
            self.print_set()
        self.hash_table_size = newSize
        old_cells = self.cells.copy()
        
        self.cells = self.initialise_cell_array()
        for i in range(N):
            if (old_cells[i] != None):
                 self.insert(old_cells[i])
        if (self.verbose > 2):
            print("New Set:")
            self.print_set()
                
    def isLinearProbing(self, mode):
        return (mode == HashingModes.HASH_1_COLLISION_1.value or mode == HashingModes.HASH_2_COLLISION_1.value)
        
    def isQuadraticProbing(self, mode):
        return (mode == HashingModes.HASH_1_COLLISION_2.value or mode == HashingModes.HASH_2_COLLISION_2.value)
        
    def isDoubleHashing(self, mode):
        return (mode == HashingModes.HASH_1_COLLISION_3.value or mode == HashingModes.HASH_2_COLLISION_3.value)
        

    def insert(self, value):
        if self.find(value): # detect duplicate
            return
            
        N = self.hash_table_size
        if (self.num_entries >= N/2): # check full table
            self.rehash()
            
        N = self.hash_table_size
        pos = self.hashFunc(value, N)
        
        # insert into empty cell
        if (self.cells[pos] == None):
            self.insertCell(value, pos)
        else:
            if self.isLinearProbing(self.mode): # linear probing: A[(i + j)mod N]
                for j in range(1, N):
                    look = (pos + j) % N
                    self.collision = self.collision + 1
                    if (self.cells[look] == None):
                        self.insertCell(value, look)
                        break
                    if (self.cells[look] == value):
                          break
            elif self.isQuadraticProbing(self.mode): # quadratic probing : A[(i + j^2)mod N]
                for j in range (1, N):
                    look = (pos + j*j) % N
                    self.collision = self.collision + 1
                    if (self.cells[look] == None):
                        self.insertCell(value, look)
                        break
                    if (self.cells[look] == value):
                        break
            elif self.isDoubleHashing(self.mode): # double hash: A[(i+j*h'(k))mod N]
                temp = self.hashFunc2(value, N)
                
                for j in range(1, N):
                    look = (pos + j * temp) % N
                    self.collision = self.collision + 1
                    if (self.cells[look] == None):
                        self.insertCell(value, look)
                        break
                    if (self.cells[look] == value):
                        break
        
    def find(self, value):
        N = self.hash_table_size
        pos = self.hashFunc(value, N)

        if (self.cells[pos] != None and self.cells[pos] == value):
            return True
            
        elif self.isLinearProbing(self.mode):
            for j in range(1, N):
                look = (pos + j) % N
                if (self.cells[look] == None):
                    return False
                if (self.cells[look] != None and self.cells[look] == value):
                    return True
        elif self.isQuadraticProbing(self.mode):
            for j in range(1, N):
                look = (pos + j*j) % N
                if (self.cells[look] == None):
                    return False
                if (self.cells[look] != None and self.cells[look] == value):
                    return True
        elif self.isDoubleHashing(self.mode):
            temp = self.hashFunc2(value, N)
            for j in range(1, N):
                look = (pos + j*temp) % N
                if (self.cells[look] == None):
                    return False
                if (self.cells[look] != None and self.cells[look] == value):
                    return True
             
        return False
        
    def print_set(self):
        for i in range(self.hash_table_size):
            if self.cells[i] != None:
                print("Cell %5d: %s" % (i,  self.cells[i]))
            if (self.cells[i] == None):
                print("Cell %5d: empty" % i)
         
    def print_stats(self):
        print("Collision times: %d\n" % self.collision)
        print("Entry number: %d\n" % self.num_entries)
        print("Average collisions per access: %lf\n" % (self.collision/self.num_entries))
        

        
# Hashing Modes
class HashingModes(Enum):
    HASH_1_COLLISION_1=0
    HASH_1_COLLISION_2=1
    HASH_1_COLLISION_3=2
    HASH_2_COLLISION_1=3
    HASH_2_COLLISION_2=4
    HASH_2_COLLISION_3=5

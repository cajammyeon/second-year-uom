from enum import Enum
import config

class hashset:
    def __init__(self):

        self.verbose = config.verbose
        self.mode = config.mode
        self.hash_table_size = config.init_size

        self.hash_table = [None] * self.hash_table_size

        # for stats purposes
        self.collision = 0
        self.rehash = 0
        self.access = 0
                
    # Helper functions for finding prime numbers
    def isPrime(self, n):
        i = 2
        while (i * i <= n):
            if (n % i == 0):
                return False
            i = i + 1
        return True
        
    def nextPrime(self, n):
        n += 1
        while (not self.isPrime(n)):
            n = n + 1
        return n

    """ Unnecessary load_facor calculation """
    def load_factor(self) :
        number_elements = 0

        for i in self.hash_table :
            if (i != None) :
                number_elements += 1

        return (number_elements/(self.hash_table_size))
    
    """ Hash methods """

    def hash_function(self, value) :

        """ Polynomial evaluation function """
        a = 31
        hash_value = 0
        d = len(str(value))
        loop_index = 1

        for i in str(value) :
            hash_value += ord(i) * ((a) ** (d - loop_index))
            loop_index += 1

        """ In the future : random polynomial function """

        return (hash_value % self.hash_table_size)  

    """ Rehashing methods """

    def rehashing(self, isLinear) :

        self.rehash += 1

        if (self.verbose == 3) :
            print("Rehashing ----------")

        temp_array = self.hash_table.copy()
        next_prime = self.nextPrime(self.hash_table_size)
        
        self.hash_table = [None] * next_prime
        self.hash_table_size = next_prime

        for i in temp_array :
            self.probing_template(i, True, isLinear)
        
        if (self.verbose == 3) :
            print("New state ----------")
            self.print_stats()

    """ Probing methods """

    def probing_template(self, value, isInsert, isLinear) :
        hash_value = self.hash_function(value)
        index = hash_value
        first_scan = True
        pointer = 1

        while (self.hash_table[index] != None) :

            # if the same value, return true, for both insertion and find
            if (self.hash_table[index] == value) :
                return True

            # quadratic might not be able to find space
            if ((index == hash_value) & (first_scan == False) & (isInsert)) :
                return False

            index = (index + (pointer ** 2)) % self.hash_table_size
            first_scan = False
            if (not isLinear) :
                pointer += 1
            self.collision += 1

        if (isInsert) :
            self.hash_table[index] = value
            return True
        else :
            return False
            
    """ Main methods """

    def insert(self, value):

        self.access += 1

        # Collision 1 : linear probing
        if (self.mode == 0) :
            while(not self.probing_template(value, True, True)) :
                self.rehashing(True)

        # Collision 2 : quadratic probing
        if (self.mode == 1) :
            while(not self.probing_template(value, True, False)) :
                self.rehashing(False)
        
    def find(self, value):

        self.access += 1

        # Collision 1 : linear probing
        if (self.mode == 0) :
            return self.probing_template(value, False, True)

        # Collision 2 : quadratic probing
        if (self.mode == 1) :
            return self.probing_template(value, False, False)
        
    def print_set(self):
        print(f"Hashset : {self}")
        index_num = 0
        for i in self.hash_table :
            if (i != None) :
                print(f"{index_num:7} : {i}")
            else :
                print(f"{index_num:7} : Empty space")
            index_num += 1
        
    def print_stats(self):
        print(f"Hashset : {self}")
        print(f"Collisions : {self.collision}")
        print(f"Rehash : {self.rehash}")
        print(f"Collision per access : {self.collision/self.access}")
                        
# Hashing Modes
class HashingModes(Enum):
    HASH_1_COLLISION_1=0
    HASH_1_COLLISION_2=1
    HASH_1_COLLISION_3=2
    HASH_2_COLLISION_1=3
    HASH_2_COLLISION_2=4
    HASH_2_COLLISION_3=5
 
if __name__ == '__main__':
    hash_test = hashset()
    original_size = hash_test.hash_table_size + 3

    test = ["susan", "ian", "barbara", "vicky", "steven", "sara"]
    for i in test :
        hash_test.insert(i)

    for i in test :
        hash_test.find(i)

    # hash_test.print_set()
    hash_test.print_stats()
from enum import Enum
import config
import sys

class darray:
    def __init__(self):
        self.array = []
        self.sorted = False
        self.mode = config.mode
        self.verbose = config.verbose
        
    def insert(self, string):
        self.array.append(string)
        
        # changing the array means it may no longer be sorted
        self.sorted = False
        
    def find(self, value):
        if (self.mode == SearchModes.LINEAR_SEARCH.value):
            # TODO implement linear search through list
            for element in self.array :
                if element == value :
                    return True;
            return False;
        else:
            if (not self.sorted):
                if (self.verbose > 0):
                    print("Dynamic Array not sorted, sorting... \n")
                    
                self.sort(self.mode)
                if (self.verbose > 0):
                    print("Dynamic Array sorted\n")
                
                self.sorted = True
            # TODO implement binary search through array
            return self.binary_search(self.array, 0, len(self.array) - 1, value)

        return False
        
    def print_set(self):
        print("DArray:\n")
        for i in range(len(self.array)):
            print("\t%s\n" % self.array[i])
            
    def print_stats(self):
        print("Dynamic array contains %d elements\n" % len(self.array))
        
    def sort(self, select):
        if (select == SearchModes.BINARY_SEARCH_ONE.value):
            self.insertion_sort()
        elif (select == SearchModes.BINARY_SEARCH_TWO.value):
            self.quick_sort(0, len(self.array) - 1)
        elif (select == SearchModes.BINARY_SEARCH_THREE.value):
            print("Nothing Implemented\n")
        elif (select == SearchModes.BINARY_SEARCH_FOUR.value):
            print("Nothing Implemented\n")
        elif (select == SearchModes.BINARY_SEARCH_FIVE.value):
             print("Nothing Implemented\n")
       #  Add your own choices here
        else:
            sys.stderr.write("The value %d is not supported\n" % select)
            sys.exit(23)
            
    # You may find this helpful
    # It swaps the element at index a and the element at index b in array
    def swap(self, a, b):
        temp = self.array[a]
        self.array[a] = self.array[b]
        self.array[b] = temp
        
    def insertion_sort(self):

        for j_index in range(1, len(self.array)) :
            key = self.array[j_index]
            i_index = j_index - 1

            while ((i_index >= 0) and (self.array[i_index] > key)) :
                self.array[i_index + 1] = self.array[i_index]
                i_index -= 1

            self.array[i_index + 1] = key
            j_index += 1

        self.sorted = True
        return self.array
    
    def partition(self, low, high) :
        pivot = self.array[high]
        i_index = low - 1

        for j_index in range(low, high) :
            if (self.array[j_index] < pivot) :
                i_index += 1
                self.swap(i_index, j_index)

        self.swap(i_index + 1, high)
        return i_index + 1

    # Hint: you probably want to define a help function for the recursive call    
    def quick_sort(self, low, high):

        if (low < high) :
            pivot = self.partition(low, high)

            self.quick_sort(low, pivot - 1)
            self.quick_sort(pivot + 1, high)

        self.sorted = True

    def binary_search(self, array_divide, low, high, value) :
            
        if low <= high:
            middle = (low + high + 1) // 2
            
            if (array_divide[middle] == value) :
                return True
            elif (array_divide[middle] > value) :
                return self.binary_search(array_divide, low, middle - 1, value)
            else :
                return self.binary_search(array_divide, middle + 1, high, value)

        return False
  
class SearchModes(Enum):
    LINEAR_SEARCH = 0
    BINARY_SEARCH_ONE = 1
    BINARY_SEARCH_TWO = 2
    BINARY_SEARCH_THREE = 3
    BINARY_SEARCH_FOUR = 4
    BINARY_SEARCH_FIVE = 5
    
if __name__ == '__main__':
    darray_instance = darray()
    darray_instance.array = ['ab', 'd', 'j', 'z', 'a']
    darray_instance.sort(SearchModes.BINARY_SEARCH_TWO.value)
    print(darray_instance.array)
    for i in ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i','j', 'k'] :
        print(darray_instance.binary_search(darray_instance.array, 0, len(darray_instance.array) - 1, i))
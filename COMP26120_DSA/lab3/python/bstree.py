import config

global_comparison = 0

class bstree:
    def __init__(self):
        self.verbose = config.verbose

        self.value = None
        self.left = None
        self.right = None

        # for stats purposes
        self.comparison = 0
        self.compare = 0
        
    def size(self):
        if (self.tree()):
            return 1 + self.left.size() + self.right.size()
        return 0
        
    def tree(self):
        # This counts as a tree if it has a field self.value
        # it should also have sub-trees self.left and self.right
        return hasattr(self, 'value')
        
    def insert(self, value):

        global global_comparison 
        global_comparison += 1
        self.compare += 1

        # set root
        if (self.value == None) :
            self.value = value
            return 0

        temp_node = bstree()
        temp_node.value = value

        if (self.tree()):
            if temp_node.value == self.value :
                return 0
            elif temp_node.value < self.value :
                if self.left == None :
                    self.left = temp_node
                else :
                    self.left.insert(value)
            else :
                if self.right == None :
                    self.right = temp_node
                else :
                    self.right.insert(value)
        else:
            self.value = 0
            self.left = None
            self.right = None
            self.insert(value)

    def find(self, value):

        global global_comparison 
        global_comparison += 1
        self.compare += 1
        
        if self.tree():
            if (self.right == None) & (self.left == None) & (self.value != value):
                return False

            if (self.value != value) & (value > self.value) & (self.right == None) :
                return False
            
            if (self.value != value) & (value < self.value) & (self.left == None) :
                return False

            if value == self.value :
                return True
            elif value < self.value :
                return self.left.find(value)
            else :
                return self.right.find(value)

        return False

    def in_order_traversal(self) :
        if self.left != None :
            self.left.in_order_travelsal()
        
        print(self.value)

        if self.right != None :
            self.right.in_order_traversal()

    def size(self) :
        item = 1

        if (self.left != None) :
            item += self.left.size()
        if (self.right != None) :
            item += self.right.size()

        return item

    # You can update this if you want
    def print_set(self):
        print(f"Value : {self.value} \n Left : {self.left.value if self.left!= None else self.left} \n Right : {self.right.value if self.right != None else self.right}\n")
       
        if self.left != None :
            self.left.print_set()
        
        if self.right != None :
            self.right.print_set()

    def print_stats(self):
        global global_comparison
        print(f"Binary Search Tree : {self}")
        print(f"Number of items : {self.size()}")
        print(f"Comparisons per access : {global_comparison/self.compare}")
            
if __name__ == "__main__" :
    testTree = bstree()
    
    for i in range(509) :
        testTree.insert(i)
    
    for i in range(108) :
        testTree.find(i)

    # testTree.print_set()
    testTree.print_stats()
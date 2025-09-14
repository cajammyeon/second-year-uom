import sys

def check_result(testno, expected, found):
    if (found == None):
        sys.stderr.write("Test %d Failed when %s expected and NULL found\n" % (testno,expected))
        exit(-1)

    if (not (expected == found)):
        sys.stderr.write("Test %d Failed when %s expected and %s found\n" % (testno,expected,found))
        exit(-1)
        
def assert_reason(testno, value, reason):
    if (not value):
        sys.stderr.write("Test %d Failed as %s\n" % (testno,reason))
        exit(-1)
        
def run_test0(initialize_pq):
    print("TEST 0")
    queue = initialize_pq(10)
    print("Initialised...")
    queue.insert("hello",1)
    print("Inserted hello with priority 1...")
    queue.insert("goodbye",2)
    print("Inserted goodbye with priority 2...")
    check_result(0,"hello",queue.pop_min())
    print("Popped hello...")
    check_result(0,"goodbye",queue.pop_min())
    print("Popped goodbye...")
    assert_reason(0,queue.is_empty()," queue is meant to be empty")
    print("Queue now empty")

def run_test1(initialize_pq):
    print("TEST 1")
    queue = initialize_pq(10)
    print("Initialised...")
    queue.insert("hello",2)
    print("Inserted hello with priority 2...")
    queue.insert("goodbye",1)
    print("Inserted goodbye with priority 1...")
    check_result(0,"goodbye",queue.pop_min())
    print("Popped goodby...")
    check_result(0,"hello",queue.pop_min())
    print("Popped hello...")
    assert_reason(0,queue.is_empty()," queue is meant to be empty")
    print("Queue now empty")
   

def run_test2(initialize_pq):
    print("TEST 2 - is expansion working?")
    queue = initialize_pq(5)
    queue.insert("first", 1)
    queue.insert("second", 2)
    queue.insert("fourth", 4)
    queue.insert("third", 3)
    queue.insert("hundred", 100)
    queue.insert("fifty", 50)
    queue.insert("ten", 10)
    check_result(2, "first", queue.pop_min())
    print("Popped first...")
    check_result(2, "second", queue.pop_min())
    print("Popped second...")
    check_result(2, "third", queue.pop_min())
    print("Popped third...")
    check_result(2, "fourth", queue.pop_min())
    print("Popped fourth...")
    check_result(2, "ten", queue.pop_min())
    print("Popped ten...")
    check_result(2, "fifty", queue.pop_min())
    print("Popped fifty...")
    check_result(2, "hundred", queue.pop_min())
    print("Popped hundred...")


prog_name=""

def run_tests(args, initialize_pq):
    prog_name = args.pop(0)

    if (len(args) != 1):
        sys.stderr.write("Supply test number\n")
        return -1
    
    test_string = args.pop(0)
    
    if (not test_string.isdigit()):
        sys.stderr.write("Supply test number as an integer\n")
        return -1
        
    test_number = int(test_string)
    
    if (test_number == 0):
        run_test0(initialize_pq)
    elif (test_number == 1):
         run_test1(initialize_pq)
    elif (test_number == 2):
         run_test2(initialize_pq)
    else:
        sys.stderr.write("Test number %d not recognised\n" % test_number)
    return 0
        
        

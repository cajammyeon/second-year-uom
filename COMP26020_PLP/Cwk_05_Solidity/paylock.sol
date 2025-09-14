pragma solidity >=0.4.16 <0.7.0;

contract Paylock {
    
    enum State { Working , Completed , Done_1 , Delay , Done_2 , Forfeit }
    
    int disc;
    State st;
    
    // adhere to deadline
    int clock;
    int time_collect_1_N_called;
    
    // allowing tick to be called only by agreed third party
    address timeAdd;
    
    constructor(address _timeAdd) public {
        st = State.Working;
        disc = 0;
        clock = 0;
        timeAdd = _timeAdd;
    }

    function signal() public {
        require( st == State.Working );
        st = State.Completed;
        disc = 10;
    }
    
    // collect_1_Y - succeed if called before the first deadline
    // collect_1_N - succeed if called once the first deadline has passed
    // collect_2_Y - succeed if called before the second deadline
    // collect_2_N - succeed if called once the second deadline has passed
    
    // first deadline = 4 units time
    // second deadline = time collect_1_N called + 4 units

    function collect_1_Y() public {
        require(st == State.Completed && clock < 4);
        st = State.Done_1;
        disc = 10;
    }

    function collect_1_N() external {
        require(st == State.Completed && clock >= 4);
        st = State.Delay;
        disc = 5;
        time_collect_1_N_called = clock;
    }

    function collect_2_Y() external {
        require(st == State.Delay && clock < (time_collect_1_N_called + 4));
        st = State.Done_2;
        disc = 5;
    }

    function collect_2_N() external {
        require(st == State.Delay && clock >= (time_collect_1_N_called + 4));
        st = State.Forfeit;
        disc = 0;
    }
    
    // set restriction on value of tick
    function tick() external {
        require(msg.sender == timeAdd);
        clock = clock + 1;
    } 

}

contract Supplier {
    
    Paylock p;
    
    enum State { Working , Completed }
    
    State st;
    Rental resource;
    
    bool hasResource;
    
        
    constructor(address pp, Rental _resource) public {
        p = Paylock(pp);
        st = State.Working;
        resource = _resource;
        hasResource = false;
    }
    
    function finish() external {
        require (st == State.Working);
        p.signal();
        st = State.Completed;
    }
    
    function acquire_resource() payable external {
        require(!hasResource);
        resource.rent_out_resource.value(msg.value)();
        hasResource = true;
    }
    
    function return_resource() external {
        require(hasResource);
        resource.retrieve_resource();
        hasResource = false;
    }
    
    receive() payable external {}
}

contract Rental {
    
    address resource_owner;
    bool resource_available;
    
    constructor() public {
        resource_available = true;
    }
    
    function rent_out_resource() payable external {
        require(resource_available == true);
        
        // CHECK FOR PAYMENT HERE
        require(msg.value >= 1 wei);

        resource_owner = msg.sender;
        resource_available = false;
    }

    function retrieve_resource() external {
        require(resource_available == false && msg.sender == resource_owner);
        
        // RETURN DEPOSIT HERE
        (bool success, ) = resource_owner.call.value(1 wei)("");
        require(success);
        
        resource_available = true;
    }
    
}
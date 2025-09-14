import im

# default client and server
SERVER = 's61110ab'
CLIENT = 'j47465wb'

# take the server input from terminal
term_input = input('Insert the SERVER username : ')
if (term_input != '') :
    SERVER = term_input

SERVER_LINK = im.IMServerProxy('https://web.cs.manchester.ac.uk/' + SERVER + '/COMP28112_ex1/IMserver.php')
CLIENT_LINK = im.IMServerProxy('https://web.cs.manchester.ac.uk/' + CLIENT + '/COMP28112_ex1/IMserver.php')

CLIENT_STATUS = CLIENT + '_STATUS'
SERVER_STATUS = SERVER + '_STATUS'

def check_status_send() -> bool:
    if SERVER_LINK[CLIENT_STATUS] == b'OK\n' :
        return True
    elif SERVER_LINK[CLIENT_STATUS] == b'WAIT\n' :
        return False
    else :
        print("Stats error - 1")

def check_status_receive() -> bool:
    if CLIENT_LINK[SERVER_STATUS] == b'WAIT\n' :
        return True
    elif CLIENT_LINK[SERVER_STATUS] == b'OK\n' :
        return False
    else :
        print("Stats error - 2")

while True :
    if (check_status_send()) :
        SERVER_LINK[CLIENT] = input("Send message : ")
        # send message - ready to read
        SERVER_LINK[CLIENT_STATUS] = "WAIT"
        CLIENT_LINK[SERVER_STATUS] = "OK"
    elif (check_status_receive()) :
        print(f"From {SERVER} : {CLIENT_LINK[SERVER]}")
        # read message - ready to send
        SERVER_LINK[CLIENT_STATUS] = "OK"
        CLIENT_LINK[SERVER_STATUS] = "WAIT"
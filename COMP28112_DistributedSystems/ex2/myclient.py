"""
    Author : s61110ab
    Created : 05 / 03 / 2025

    To run the code : python3 ./myclient.py localhost <server port number>

    Using the program :
    1. After execution, registration is needed before sending any message to the server
        a. To register, just type REGISTER %name% when '>' symbol appears on screen
    2. Then try sending message to all the registered clients
        a. To send message to all, use the command SEND_ALL %msg%
    3. Get the name of all registerd clients
        a. To get the namelist of all registered clients, just use GET_ALL command
    4. Try sending a message to registered client
        a. To send message to specified client, use command SEND_TO %usr% %msg%
        b. If the %usr% does not exist, an error message will be sent by the server
    5. Finally we can disconnect from the server
        a. To disconnect, just type out the command DISCONNECT
"""

import sys
from ex2utils import Client

import threading

command_list = """
1. Register - REGISTER %user%
2. Send message to all active users - SEND_ALL %msg%
3. Send to a specific user - SEND_TO %user% %msg%
4. Get the list of all active users - GET_ALL
5. Disconnect from the server - DISCONNECT
\n"""

class IRCClient(Client):

    def onStart(self):
        sys.stdout.write('Connected to server !')
        sys.stdout.write(command_list)
        threading.Thread(target=self._main_loop, daemon=True).start()
	
    def onConnect(self, socket):
        pass

    def onMessage(self, socket, message):
        if (message == 'Client exiting'):
            self.stop()
        else :
            sys.stdout.write(f"\r{message}\n> ")
            sys.stdout.flush()

        return True
    
    def _main_loop(self):
        while True :
            message = input(f"\r> ")
            self.send(message.encode())

ip = sys.argv[1]
port = int(sys.argv[2])

client = IRCClient()
client.start(ip, port)

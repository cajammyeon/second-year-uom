import sys
from ex2utils import Server

class MyServer(Server):

    # keep track of number of active clients
    _clients = []

    def onConnect(self, socket) -> None:
        # keep track of number of active clients
        self._clients.append(socket)

        # print messages as requested
        self.printOutput(f'new client connected')
        self.printOutput(f'{len(self._clients)} active clients')
    
    def onDisconnect(self, socket) -> None:
        # keep track of number of active clients
        self._clients.remove(socket)

        # print messages as requested
        self.printOutput('a client disconnected')
        self.printOutput(f'{len(self._clients)} active clients')

    def onStart(self) -> None:
        self.printOutput("myserver has started")

    def onMessage(self, socket, message) -> bool:

        # print message on server side - before parsing
        self.printOutput(f'{message}')

        # split the message in the format of <COMMAND> <some parameters>
        message_command = (message.split())[0]
        if message_command != 'DISCONNECT' or message_command != 'GET_ALL':
            message_parameters = (message.split())[1:]
        else :
            message_parameters = ''

        # print on server side
        self.printOutput(f'COMMAND : {message_command}')
        self.printOutput(f'PARAMETERS : {message_parameters}')

        # process message properly, according to commands
        self._parsing_command(socket, message_command, message_parameters)

        return True
    
    def _parsing_command(self, socket, command, parameters) -> None:
        if (command == 'REGISTER') :
            self._register(socket, parameters)
        elif (command == 'DISCONNECT') :
            self._close_connection(socket)
        else :
            if (self._check_registered(socket)) :
                if (command == 'SEND_ALL') :
                    self._send_to_all(socket, parameters)
                elif (command == 'SEND_TO') :
                    self._send_one(socket, parameters)
                elif (command == 'GET_ALL') :
                    self._online_users(socket)
                else :
                    socket.send(f'unknown command'.encode())
            else :
                socket.send(f'not registered'.encode())
    
    def _check_registered(self, socket) -> bool:

        # if attribute does not exist, means that the client is not registered
        if hasattr(socket, 'name') :
            return True
        else :
            return False
        
    def _register(self, socket, parameters) -> None:

        # input validation
        if len(parameters) == 0 :
            socket.send(f'name not given, try again'.encode())
            return

        # iterate through the list to check for duplicates
        # REGISTER <NAME>
        for i in self._clients :
            if self._check_registered(i) :
                if (i.name == parameters[0]) :
                    socket.send(f'name is taken, try again'.encode())
                    return
        
        # assign if there is no duplicate
        socket.name = parameters[0]

        # print on server
        self.printOutput(f'{socket.name} registered')

    def _send_to_all(self, socket, parameters) :

        # iterate through list of registered clients to send messages to each one
        # SEND_ALL <MESSAGE>
        for i in self._clients :
            if (self._check_registered(i)) :
                if (i != socket) :
                    i.send(f'message from {socket.name}: {" ".join(parameters)}'.encode())

    def _send_one(self, socket, parameters) :
        
        # iterate through list of registered clients to find the specified user
        # SEND_TO <RECIPIENT> <MESSAGE>
        for i in self._clients :
            if (self._check_registered(i)) :
                if (i.name == parameters[0]) :
                    i.send(f'message from {socket.name}: {" ".join(parameters[1:])}'.encode())
                    return
        
        # error message, user specified not found - input validation at the end
        socket.send(f'user {parameters[0]} cannot be found'.encode())

    def _online_users(self, socket) :

        # iterate through client list
        # registered ? obtain their name : ignore
        # GET_ALL
        name_list = []
        for i in self._clients :
            if self._check_registered(i) :
                name_list.append(i.name)

        # send the list to client
        socket.send(f'{name_list}'.encode())

    def _close_connection(self, socket) :

        # DISCONNECT
        socket.send(f'Client exiting'.encode())
    

ip = sys.argv[1]
port = int(sys.argv[2])

server = MyServer()
server.start(ip, port)
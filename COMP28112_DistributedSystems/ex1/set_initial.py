import im

# default client and server
SERVER = 'j47465wb'
CLIENT = 's61110ab'

# take the server input from terminal
term_input = input('Insert the SERVER username : ')
if (term_input != '') :
    SERVER = term_input
term_input = input('Insert the CLIENT username : ')
if (term_input != '') :
    CLIENT = term_input

SERVER_LINK = im.IMServerProxy('https://web.cs.manchester.ac.uk/' + SERVER + '/COMP28112_ex1/IMserver.php')
CLIENT_LINK = im.IMServerProxy('https://web.cs.manchester.ac.uk/' + CLIENT + '/COMP28112_ex1/IMserver.php')

CLIENT_STATUS = CLIENT + '_STATUS'
SERVER_STATUS = SERVER + '_STATUS'

# set the talking turn
# switch state when read, as acknowledgement
SERVER_LINK[CLIENT_STATUS] = 'OK'
CLIENT_LINK[SERVER_STATUS] = 'WAIT'

# set the empty space
SERVER_LINK[CLIENT] = ''
CLIENT_LINK[SERVER] = ''
#!/usr/bin/python3

import reservationapi
import configparser
import os

from exceptions import (
    BadRequestError, InvalidTokenError, BadSlotError, NotProcessedError,
    SlotUnavailableError,ReservationLimitError, ParameterError)

# Load the configuration file containing the URLs and keys
config = configparser.ConfigParser()
config.read("api.ini")

# Create an API object to communicate with the hotel API
hotel  = reservationapi.ReservationApi(config['hotel']['url'],
                                       config['hotel']['key'],
                                       int(config['global']['retries']),
                                       float(config['global']['delay']))

# Create an API object to communicate with the band API
band  = reservationapi.ReservationApi(config['band']['url'],
                                       config['band']['key'],
                                       int(config['global']['retries']),
                                       float(config['global']['delay']))

# Global variable declaration ===================================================
hotel_avail_list, hotel_held_list, band_avail_list, band_held_list = [], [], [], []

# Helper methods ================================================================
def dict_to_list(list_of_dict) :
    ret_list = []
    for i in list_of_dict :
        ret_list.append(int(i["id"]))
    return ret_list

def print_beautiful_layout(lst):

    if len(lst) == 0 :
        print("""
            | No slots |
            ------------
        """)
        return

    num_columns = 5
    num_rows = len(lst) // num_columns + (1 if len(lst) % num_columns != 0 else 0)
    
    for i in range(num_rows):
        row = lst[i * num_columns:(i + 1) * num_columns]
        print("\t|", " | ".join(f"{item:>5}" for item in row), " |")
        print("\t" + "-" * (len(row) * 7 + 1))

def print_current_info() :

    global hotel_avail_list
    global hotel_held_list
    global band_avail_list
    global band_held_list

    matched_slots = [i for i in hotel_avail_list if i in band_avail_list]
    print("""
        *************************
        * Hotel slots available *
        *************************
        """)
    print_beautiful_layout(hotel_avail_list[:20])
    print("""
        ************************
        * Band slots available *
        ************************
        """)
    print_beautiful_layout(band_avail_list[:20])
    print("""
        ********************
        * Hotel slots held *
        ********************
        """)
    print_beautiful_layout(hotel_held_list)
    print("""
        *******************
        * Band slots held *
        *******************
        """)
    print_beautiful_layout(band_held_list)
    print("""
        ****************************
        * Matching slots available *
        ****************************
        """)
    print_beautiful_layout(matched_slots[:5])

def fixing_state() :

    global hotel_avail_list
    global hotel_held_list
    global band_avail_list
    global band_held_list

    hotel_avail_list.sort()
    hotel_held_list.sort()
    band_avail_list.sort()
    band_held_list.sort()

# Error message handling ========================================================
def error_handler(error_message) :
    exception_dict = {
        BadRequestError : "Bad Request Error has occured",
        InvalidTokenError : "API token was invalid or missing",
        BadSlotError : "Requested slot does not exist",
        NotProcessedError : "The request has not been processed",
        SlotUnavailableError : "Requested slot is unavailable",
        ReservationLimitError : "The client already holds the maximum amount of reservation (2)",
        ParameterError : "Parameter passed is not the right type / not in the range"
    }
    
    os.system("clear")
    error_call = exception_dict.get(type(error_message), "No connection")

    print("*" * (len(error_call) + 4))
    print("* " + error_call + " *")
    print("*" * (len(error_call) + 4))

    user_in = input("""
        Press enter key to return
    
    """)

# Initialisation ================================================================
def system_synchronisation() :

    global hotel_avail_list
    global hotel_held_list
    global band_avail_list
    global band_held_list

    try :
        print("Synchronising hotel available slot =================")
        hotel_avail_list = dict_to_list(hotel.get_slots_available())
        print("Synchronising hotel reserved slot ==================")
        hotel_held_list = dict_to_list(hotel.get_slots_held())
        print("Synchronising band available slot ==================")
        band_avail_list = dict_to_list(band.get_slots_available())
        print("Synchronising band reserved slot ===================")
        band_held_list = dict_to_list(band.get_slots_held())
    
    except Exception as e :
        error_handler(e)

# Reservation ===================================================================
def reserve_avail_slot(type, slot_id) :

    global hotel_avail_list
    global hotel_held_list
    global band_avail_list
    global band_held_list

    try :
        if (type == "hotel") :

            #  check if reservation has reached limit
            if len(hotel_held_list) == 2 :
                error_handler(ReservationLimitError())
                return -1
            
            # slot availability is processed locally with cached information
            if (slot_id not in hotel_avail_list) :
                error_handler(SlotUnavailableError())
                return -1

            hotel.reserve_slot(slot_id)
            hotel_avail_list.remove(slot_id)
            hotel_held_list.append(slot_id)

            return 0
        
        elif (type == "band") :

            # check if reservation has reached limit
            if len(band_held_list) == 2 :
                error_handler(ReservationLimitError())
                return -1
            
            # slot availability is processed locally with cached information
            if (slot_id not in band_avail_list) :
                error_handler(SlotUnavailableError())
                return -1

            band.reserve_slot(slot_id)
            band_avail_list.remove(slot_id)
            band_held_list.append(slot_id)

            return 0
        
        else :
            error_handler(ParameterError())

        fixing_state()

    except Exception as e :
        error_handler(e)

def reserve_matching_slot() :

    global hotel_avail_list
    global hotel_held_list
    global band_avail_list
    global band_held_list

    matched_slots = [i for i in hotel_avail_list if i in band_avail_list][0]
    
    hotel_stats = reserve_avail_slot("hotel", matched_slots)
    band_stats = reserve_avail_slot("band", matched_slots)

    if (hotel_stats == -1) :
        if matched_slots in band_held_list :
            band_held_list.remove(matched_slots)
    if (band_stats == -1) :
        if matched_slots in hotel_held_list :
            hotel_held_list.remove(matched_slots)

# Cancel reservation ============================================================
def cancel_reserved_slot(type, slot_id) :

    global hotel_avail_list
    global hotel_held_list
    global band_avail_list
    global band_held_list

    try :
        if (type == "hotel") :

            # slot availability is processed locally with cached information
            if (slot_id not in hotel_held_list) :
                error_handler(SlotUnavailableError())
                return -1

            hotel.release_slot(slot_id)
            hotel_avail_list.append(slot_id)
            hotel_held_list.remove(slot_id)
        elif (type == "band") :

            # slot availability is processed locally with cached information
            if (slot_id not in band_held_list) :
                error_handler(SlotUnavailableError())
                return -1

            band.release_slot(slot_id)
            band_avail_list.append(slot_id)
            band_held_list.remove(slot_id)

        fixing_state()

    except Exception as e :
        error_handler(e)

def cancel_unneeded() :
    
    global hotel_avail_list
    global hotel_held_list
    global band_avail_list
    global band_held_list

    hotel_held_copy = hotel_held_list.copy()
    band_held_copy = band_held_list.copy()

    for i in hotel_held_copy :
        if i not in band_held_copy :
            cancel_reserved_slot("hotel", i)

    for i in band_held_copy :
        if i not in hotel_held_copy :
            cancel_reserved_slot("band", i)

def cancel_matching() :

    global hotel_avail_list
    global hotel_held_list
    global band_avail_list
    global band_held_list

    worst_matched_slots = [i for i in hotel_held_list if i in band_held_list][-1]

    cancel_reserved_slot("hotel", worst_matched_slots)
    cancel_reserved_slot("band", worst_matched_slots)

# Main loop =====================================================================
if __name__ == "__main__" :

    system_synchronisation()

    menu_options = {
        0 : """ 
        *************
        * Main menu *
        *************

        1. Reserve an available slot
        2. Reserve earliest matching slot
        3. Cancel slot reservation
        4. Cancel any unneeded reservation
        5. Cancel worst matching slot
        6. Synchronise with server 
        7. Exit system
        
        """,
        1 : reserve_avail_slot,
        2 : reserve_matching_slot,
        3 : cancel_reserved_slot,
        4 : cancel_unneeded,
        5 : cancel_matching,
        6 : system_synchronisation,
        7 : exit
    }

    while True :
        os.system("clear")
        print_current_info()
        print(menu_options[0])

        try :
            user_in = int(input("Menu option : "))
        except :
            error_handler(ParameterError())
            continue

        if (user_in == 1) | (user_in == 3) :

            type_in = input("Choose your reservation for (hotel / band) : ").strip().lower()
            if (type_in != "hotel") & (type_in != "band") :
                error_handler(ParameterError())
                continue

            try :
                slot_number_id = int(input("Slot id : "))
            except :
                error_handler(ParameterError())
                continue

            return_value = menu_options[user_in](type_in, slot_number_id)
        elif (user_in == 2) | (user_in == 4) | (user_in == 5) | (user_in == 6) | (user_in == 7):
            return_value = menu_options[user_in]()
        else :
            error_handler(ParameterError())

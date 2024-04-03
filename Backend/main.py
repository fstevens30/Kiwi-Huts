import firebase_admin
from firebase_admin import firestore, credentials
from get_huts import get_huts
import os
import json

try:
    print('Connecting to Firestore DB.')
    with open('firebasekey.json', 'r') as f:
        firebase_cred = json.load(f)
    
    cred_object = credentials.Certificate(firebase_cred)
    default_app = firebase_admin.initialise_app(cred_object)
    db = firestore.client()
    print('Connected.')

    db_check(db)

except Exception as e:
    print(f'Error: {e}')


def huts_db_builder(db):

    # TODO
    # Loop through each hut in the database
    # If get_huts cannot find the hut, delete it
    # If get_huts find the hut and get_hut_info has different info, update it
    # If get_huts find the hut but no new info then do nothing
    # Perhaps this loop could be its own function

    return None

def db_check(db, collection='huts'):

    if db.collection('huts').get():
        print('Collection found.')

    else:
        db.collection('huts').add({})
    print('Collection added.')
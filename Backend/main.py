import firebase_admin
from firebase_admin import firestore, credentials
from get_huts import get_huts
import json


def main():
    try:
        print('Connecting to Firestore DB.')
        # Load API Key from plist file for the huts API
        with open('Keys/DOC.json', 'r') as f:
            f_data = json.load(f)
            api_key = f_data.get('API_KEY', '')

        # Initialize Firebase Admin with a specific service account
        if not firebase_admin._apps:
            cred_path = 'Keys/Firebase.json'
            cred = credentials.Certificate(cred_path)
            firebase_admin.initialize_app(cred)
        db = firestore.client()
        print('Connected.')

        huts_db_builder(db, api_key)

    except Exception as e:
        print(f'Error: {e}')


def huts_db_builder(db, api_key):
    huts_data = get_huts(api_key)
    current_huts = {str(doc.id): doc.to_dict() for doc in db.collection(
        'huts').stream()}  # Convert doc.id to string if it's not

    for hut in huts_data:
        hut_id = str(hut['id'])  # Ensure hut_id is always a string
        if hut_id in current_huts:
            # Update if different
            if hut != current_huts[hut_id]:
                db.collection('huts').document(hut_id).update(hut)
                print(f'Updated hut {hut_id}')
        else:
            # Add new hut
            db.collection('huts').document(hut_id).set(hut)
            print(f'Added new hut {hut_id}')

    # Check for deletions
    for hut_id in current_huts:
        if hut_id not in [str(h['id']) for h in huts_data]:  # Convert h['id'] to string
            db.collection('huts').document(hut_id).delete()
            print(f'Deleted hut {hut_id}')


if __name__ == '__main__':
    main()

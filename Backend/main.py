import firebase_admin
from firebase_admin import firestore, credentials
from get_huts import get_huts
import os


def main():
    try:
        print('Connecting to Firestore DB.')
        api_key = os.getenv('DOC_API_KEY')

        if not firebase_admin._apps:
            cred_path = os.getenv('FIREBASE_JSON', 'firebase_key.json')
            cred = credentials.Certificate(cred_path)
            firebase_admin.initialize_app(cred)
        db = firestore.client()

        # Ensure the 'huts' collection is ready for use
        initialize_firestore_collection(db, 'huts')

        huts_db_builder(db, api_key)

    except Exception as e:
        print(f'Error: {e}')


def huts_db_builder(db, api_key):
    try:
        huts_data = get_huts(api_key)
        print(f"Fetched {len(huts_data)} huts from the API.")

        current_huts = {str(doc.id): doc.to_dict()
                        for doc in db.collection('huts').stream()}
        print(f"Currently have {len(current_huts)} huts in Firestore.")

        # Use a set for faster lookup
        huts_data_ids = {str(h['id']) for h in huts_data}

        for hut in huts_data:
            hut_id = str(hut['id'])
            if hut_id in current_huts:
                if hut != current_huts[hut_id]:
                    db.collection('huts').document(hut_id).update(hut)
                    print(f'Updated hut {hut_id}')
            else:
                db.collection('huts').document(hut_id).set(hut)
                print(f'Added new hut {hut_id}')

        # Check for deletions
        for hut_id in current_huts:
            if hut_id not in huts_data_ids:
                db.collection('huts').document(hut_id).delete()
                print(f'Deleted hut {hut_id}')

    except Exception as e:
        print(f"Error in huts_db_builder: {e}")


def initialize_firestore_collection(db, collection_name):
    try:
        # Check if the collection exists and has documents
        documents = list(db.collection(collection_name).limit(1).stream())
        if not documents:
            # Add a dummy document if the collection is empty or does not exist
            dummy_doc_id = 'dummy-document'
            db.collection(collection_name).document(
                dummy_doc_id).set({'init': True})
            # Immediately delete the dummy document
            db.collection(collection_name).document(dummy_doc_id).delete()
            print(
                f"Initialized collection '{collection_name}' with a dummy document and deleted it.")
        else:
            print(f"Collection '{collection_name}' exists and has documents.")
    except Exception as e:
        print(f"Failed to initialize collection '{collection_name}': {e}")


if __name__ == '__main__':
    main()

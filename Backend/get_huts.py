import requests
import json

def get_huts(api_key):
    """
    Creates the http request.
    Returns a JSON object of huts.
    """
    url = "https://api.doc.govt.nz/v2/huts?coordinatess=wgs84"
    headers = {'x-api-key': api_key}

    response = requests.get(url, headers=headers)

    if response.status_code == 200:
        # TODO
        # Open the JSON,
        # For each hut object, replace the key "assetId" with "id"
        # Then use this to pass each huts "id" into the get_hut_info function
        # If the function returns None remove the current hut

        return response.json()
    
    else:
        print(f'Error: {response.text}')
        return None

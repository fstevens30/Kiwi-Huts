import requests
import json

def get_hut_info(id, api_key):
    """
    Creates a http request using the huts id and the api key.
    Returns a JSON object of the huts information.
    Returns None if nothing is found.
    """

    url = f'https://api.doc.govt.nz/v2/huts/{id}/detail?coordinates=wgs84'
    headers = {'x-api-key': api_key}
    
    response = requests.get(url, headers=headers)

    if response.status_code == 200:
        return response.json()
    
    else:
        return None
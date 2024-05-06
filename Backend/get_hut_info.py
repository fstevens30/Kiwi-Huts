import requests
import json


def get_hut_info(id, api_key):
    """
    Fetches detailed information for a specific hut by its ID using the provided API key.
    Returns a JSON object of the hut's information if the request is successful.
    Returns None if no information is found or if an error occurs.
    """

    url = f'https://api.doc.govt.nz/v2/huts/{id}/detail?coordinates=wgs84'
    headers = {'x-api-key': api_key}

    response = requests.get(url, headers=headers)

    if response.status_code == 200:
        return response.json()
    else:
        # Create a file called 'error.txt' if it doesn't exist
        # append the hut id and the response status code to the file
        with open('error.txt', 'a') as f:
            f.write(f'{id}: {response.status_code}\n')
        return None

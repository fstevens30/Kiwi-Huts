import requests
import json
import get_hut_info


def get_huts(api_key):
    """
    Creates the http request.
    Returns a JSON object of huts.
    """
    url = "https://api.doc.govt.nz/v2/huts?coordinatess=wgs84"
    headers = {'x-api-key': api_key}

    response = requests.get(url, headers=headers)

    if response.status_code == 200:
        # Replace 'assetId' with 'id' to work for SwiftUI
        huts = response.json()
        fixed_huts = []

        for hut in huts:
            hut['id'] = hut.pop('assetId')
            fixed_huts.append(hut)

            # Fetch the hut info
            hut_info = get_hut_info.get_hut_info(hut['id'], api_key)
            if hut_info is not None:
                for key, value in hut_info.items():
                    if key not in hut:
                        hut[key] = value

                fixed_huts.append(hut)

        return fixed_huts

    else:
        print(f'Error: {response.text}')
        return None

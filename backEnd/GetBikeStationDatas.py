import requests

# importing the module
import json
 



def main():
	url = "https://data.explore.star.fr/api/records/1.0/search/?dataset=vls-stations-etat-tr&q=&rows=10000"

	payload={}
	headers = {}

	response = requests.request("GET", url, headers=headers, data=payload)
	data = json.loads(response.text)
	result = dict()
	result['records'] = data["records"]
	return result




if __name__ == '__main__':
	main()
import requests

# importing the module
import json




def main():
	url = "https://data.explore.star.fr/api/records/1.0/search/?dataset=tco-bus-circulation-passages-tr&q=&sort=-arriveetheorique&facet=idligne&facet=nomcourtligne&facet=sens&facet=destination&facet=precision&facet=visibilite&refine.nomcourtligne=72&refine.destination=Rennes&refine.nomarret=Vieux+Bourg&timezone=Europe%2FParis"

	payload={}
	headers = {}

	response = requests.request("GET", url, headers=headers, data=payload)
	data = json.loads(response.text)
	result = dict()
	result['records'] = data["records"]
	return result




if __name__ == '__main__':
	main()
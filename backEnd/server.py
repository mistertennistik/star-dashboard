from flask import Flask
from flask_cors import CORS

app = Flask(__name__)
cors = CORS(app)

@app.route("/bikesDatas")
def bikeDatasController():
    import GetBikeStationDatas as gBsD



    # GET bike stations datas
    bikeStationDatasDict = gBsD.main()
    return bikeStationDatasDict

@app.route("/busStopDatas")
def busDatasController():
    import GetBusStopDatas as gBusStop



    # GET bus stations datas
    bikeStationDatasDict = gBusStop.main()
    return bikeStationDatasDict
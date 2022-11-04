var store = {};
const BASE_PATH = 'http://localhost:5000';

function init(){

    return new Promise(async (resolve, reject)=>{
        store.busData = await getBusData();
        store.bikesData =  await getBikesData();
        resolve(store);        
    });
    
    
}


function getBikesData(){
    const req = new XMLHttpRequest();
    return new Promise((resolve) => {
        makeRequest("/bikesDatas",req,()=>{
        let tmpBikesData = parseResponseAndMapFields(req.responseText);
        resolve(keepUsefulBikesData(tmpBikesData));
        });
    });
}


function getBusData(){
    const req = new XMLHttpRequest();
    return new Promise((resolve) => {
        makeRequest("/busStopDatas",req,()=>{
        let tmpBusData = parseResponseAndMapFields(req.responseText);
        resolve(keepUsefulBusData(tmpBusData));
        });
    });

}


function keepUsefulBikesData(data){
    return data.map(
        e => {
            return {
                station : e.nom,
                velos_dispo : e.nombrevelosdisponibles,
                places_dispo : e.nombreemplacementsdisponibles
            }
        }
            
        
    );
}

function keepUsefulBusData(data){
    return data.map(
        e => {
            return {
                theorique : e.arriveetheorique,
                estimee : e.arrivee
            }
        }
            
        
    );
}

function parseResponseAndMapFields(res){
    return JSON.parse(res).records.map( e => e.fields);
}

function makeRequest(aPath, aReq ,aCallBack){
    aReq.addEventListener("load", aCallBack);
    aReq.open("GET", BASE_PATH+ aPath);
    aReq.send();
}
 

function makeList(listTitle, aList){
    let data = aList;
    let listContainer = document.createElement("div");
    listContainer.setAttribute("id", listTitle+"container");
    listContainer.innerHTML=listTitle;

    let list = document.createElement("ul");

    data.forEach((item)=>{
        let li = document.createElement("li");
        li.innerText = JSON.stringify(item,null,4);
        list.appendChild(li);
    });

    listContainer.appendChild(list);
    document.body.appendChild(listContainer);

}
import axios from 'axios';

const serverUrl = "";

export function getServerTableOrderData() {
    const url = serverUrl + "";
    return axios.get(url).then(response => response.data)
        .catch(error => console.log("error: " + error));
}
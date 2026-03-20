// 引入 axios
import axios from "axios";



let base = '';

//传送json格式的get请求
export const getRequest=(url,params)=>{
    return axios({
        method:'get',
        url:`${base}${url}`,
        data: params,
    })
}

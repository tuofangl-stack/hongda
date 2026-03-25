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

// ========== 用户认证 API ==========
export const userLogin = (data) => {
    return axios.post(`${base}/api/user/login`, data)
}

export const userRegister = (data) => {
    return axios.post(`${base}/api/user/register`, data)
}

export const sendEmailCode = (data) => {
    return axios.post(`${base}/api/user/sendCode`, data)
}

export const getUserInfo = () => {
    const token = localStorage.getItem('user_token')
    return axios.get(`${base}/api/user/info`, {
        headers: { Authorization: 'Bearer ' + token }
    })
}

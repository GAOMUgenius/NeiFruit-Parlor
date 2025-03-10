import { http } from "@kit.NetworkKit";
import { UserData } from "datastore/src/main/ets/model/UserDataModel";
import { APIContants } from "network";

export interface UserInfo{
  status: number,
  message: string,
  data: UserData
}

export async function getUserInfo(token: string): Promise<UserInfo> {
  // 创建 HTTP 客户端
  const httpClient = http.createHttp();
  let ip = APIContants.IP
  let port = APIContants.PORT

  try {
    // 1. 配置请求参数
    let requestOptions: http.HttpRequestOptions = {
      method: http.RequestMethod.GET,
      header: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${token}` // 注入 token
      },
      expectDataType: http.HttpDataType.OBJECT // 自动解析 JSON
    };

    // 2. 发送请求
    const response = await httpClient.request(
      `https://${ip}:${port}/api.example.com/api/v1/users`,
      requestOptions
    );

    // 3. 处理响应
    if (response.responseCode === 200) {
      // 解析响应数据
      const result = response.result as UserInfo;

      if (result.status === 1000) {
        return result
      } else {
        throw new Error(result.message || '用户注册失败');
      }
    } else {
      throw new Error(`请求失败，状态码：${response.responseCode}: ${response.result}`);
    }
  } catch (error) {
    // 处理错误情况
    console.error('注册失败:', error);
    throw new Error(`网络请求失败：${error.message}`);
  } finally {
    // 释放 HTTP 客户端资源
    httpClient.destroy();
  }
}